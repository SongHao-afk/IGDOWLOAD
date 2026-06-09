import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';
import '../models/ig_media_item.dart';
import 'downloader_state.dart';

class DownloaderCubit extends Cubit<DownloaderState> {
  DownloaderCubit() : super(DownloaderState.initial());

  final Dio dio = Dio();

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final server =
        prefs.getString(AppConstants.prefsServerBaseUrl) ??
        AppConstants.defaultServerBaseUrl;

    final privateMode = prefs.getBool(AppConstants.prefsPrivateMode) ?? false;
    final privateIgCookie = prefs.getString(AppConstants.prefsPrivateIgCookie);

    emit(
      state.copyWith(
        serverBaseUrl: server,
        privateMode: privateMode,
        privateIgCookie: privateIgCookie,
      ),
    );
  }

  Future<void> saveServer(String serverUrl) async {
    final clean = serverUrl.trim();
    if (clean.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsServerBaseUrl, clean);

    emit(state.copyWith(serverBaseUrl: clean, status: 'Đã lưu server: $clean'));
  }

  Future<void> setPrivateMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsPrivateMode, value);

    emit(
      state.copyWith(
        privateMode: value,
        status: value
            ? 'Đã bật chế độ Private.'
            : 'Đã chuyển về chế độ Public.',
      ),
    );
  }

  Future<void> savePrivateCookie(String cookie) async {
    final clean = cookie.trim();

    if (clean.isEmpty || !clean.contains('sessionid=')) {
      emit(
        state.copyWith(
          status: 'Không lấy được session Instagram. Hãy đăng nhập lại.',
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsPrivateMode, true);
    await prefs.setString(AppConstants.prefsPrivateIgCookie, clean);

    emit(
      state.copyWith(
        privateMode: true,
        privateIgCookie: clean,
        status: 'Đã lưu phiên đăng nhập Instagram trên máy này.',
      ),
    );
  }

  Future<void> logoutPrivateCookie() async {
    if (state.sessionBusy) return;

    emit(
      state.copyWith(
        sessionBusy: true,
        status: 'Đang đăng xuất Private mode...',
      ),
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsPrivateMode, false);
    await prefs.remove(AppConstants.prefsPrivateIgCookie);

    emit(
      state.copyWith(
        privateMode: false,
        clearPrivateIgCookie: true,
        sessionBusy: false,
        media: [],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
        status: 'Đã đăng xuất Private mode. Quay về Public.',
      ),
    );
  }

  Future<void> resolveMedia(String inputUrl) async {
    final url = inputUrl.trim();

    if (url.isEmpty) {
      emit(state.copyWith(status: 'Dán link Instagram trước đã.'));
      return;
    }

    if (state.privateMode && !state.hasPrivateCookie) {
      emit(state.copyWith(status: 'Private mode cần bấm Đăng nhập trước.'));
      return;
    }

    emit(
      state.copyWith(
        loading: true,
        status: state.activeIgCookie == null
            ? 'Đang bú link bằng Public mode...'
            : 'Đang bú link bằng Private mode...',
        media: [],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
      ),
    );

    try {
      final body = <String, dynamic>{'url': url};

      final headers = <String, String>{'Content-Type': 'application/json'};

      if (state.activeIgCookie != null) {
        body['igCookie'] = state.activeIgCookie;
        headers['x-ig-cookie'] = state.activeIgCookie!;
      }

      final res = await http.post(
        Uri.parse('${state.serverBaseUrl}/resolve'),
        headers: headers,
        body: jsonEncode(body),
      );

      dynamic decoded;

      try {
        decoded = jsonDecode(res.body);
      } catch (_) {
        decoded = null;
      }

      if (res.statusCode != 200) {
        throw Exception('resolve_failed');
      }

      if (decoded is! Map || decoded['success'] != true) {
        throw Exception('resolve_failed');
      }

      final List list = decoded['media'] ?? [];
      final media = list.map((x) => IgMediaItem.fromJson(x)).toList();

      emit(
        state.copyWith(
          loading: false,
          media: media,
          status: 'Bắt được ${media.length} media.',
          downloadingIds: <int>{},
          downloadErrors: <int, String>{},
          downloadingAll: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          loading: false,
          status: state.activeIgCookie == null
              ? 'Lỗi lấy media. Kiểm tra link hoặc thử lại.'
              : 'Lỗi lấy media bằng Private mode. Kiểm tra quyền xem hoặc đăng nhập lại.',
          downloadingIds: <int>{},
          downloadingAll: false,
        ),
      );
    }
  }

  Future<void> requestSavePermission() async {
    if (!Platform.isAndroid) return;

    await Permission.photos.request();
    await Permission.videos.request();
    await Permission.storage.request();
  }

  String _downloadErrorText(Object e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return 'Tải lỗi do kết nối chậm. Bấm thử lại.';
        case DioExceptionType.connectionError:
          return 'Không kết nối được server. Kiểm tra mạng/server.';
        case DioExceptionType.cancel:
          return 'Đã hủy tải.';
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          return 'Tải lỗi. Bấm thử lại.';
      }
    }

    return 'Tải lỗi. Bấm thử lại.';
  }

  Future<void> _downloadMediaOnce(IgMediaItem item) async {
    final tempDir = await getTemporaryDirectory();

    final ext = item.isVideo ? 'mp4' : 'jpg';
    final filename =
        'instagram_${DateTime.now().millisecondsSinceEpoch}_${item.id}.$ext';

    final tempPath = '${tempDir.path}/$filename';

    final proxyUrl = Uri.parse(
      '${state.serverBaseUrl}/download',
    ).replace(queryParameters: {'url': item.downloadUrl}).toString();

    final headers = <String, dynamic>{};

    if (state.activeIgCookie != null) {
      headers['x-ig-cookie'] = state.activeIgCookie!;
    }

    await dio.download(
      proxyUrl,
      tempPath,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
        headers: headers,
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
      onReceiveProgress: (received, total) {
        if (total <= 0) return;

        final percent = ((received / total) * 100).toStringAsFixed(0);

        emit(state.copyWith(status: 'Đang tải media ${item.id}: $percent%'));
      },
    );

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await File(tempPath).delete();
    } catch (_) {}
  }

  Future<void> _downloadMediaWithRetry(IgMediaItem item) async {
    Object? lastError;

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        await _downloadMediaOnce(item);
        return;
      } catch (e) {
        lastError = e;

        if (attempt < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }

    throw lastError ?? Exception('download_failed');
  }

  Future<void> downloadMedia(IgMediaItem item) async {
    if (state.downloadingIds.contains(item.id)) return;
    if (state.downloadingAll) return;

    if (state.privateMode && !state.hasPrivateCookie) {
      emit(state.copyWith(status: 'Private mode cần bấm Đăng nhập trước.'));
      return;
    }

    final nextDownloading = {...state.downloadingIds, item.id};
    final nextErrors = Map<int, String>.from(state.downloadErrors)
      ..remove(item.id);

    emit(
      state.copyWith(
        status: 'Đang tải media ${item.id}...',
        downloadingIds: nextDownloading,
        downloadErrors: nextErrors,
      ),
    );

    try {
      await requestSavePermission();

      await _downloadMediaWithRetry(item);

      final doneDownloading = {...state.downloadingIds}..remove(item.id);
      final doneErrors = Map<int, String>.from(state.downloadErrors)
        ..remove(item.id);

      emit(
        state.copyWith(
          status:
              'Đã lưu media ${item.id} vào album ${AppConstants.albumName}.',
          downloadingIds: doneDownloading,
          downloadErrors: doneErrors,
        ),
      );
    } catch (e) {
      final doneDownloading = {...state.downloadingIds}..remove(item.id);
      final doneErrors = Map<int, String>.from(state.downloadErrors)
        ..[item.id] = _downloadErrorText(e);

      emit(
        state.copyWith(
          status: 'Tải media ${item.id} lỗi. Bấm thử lại.',
          downloadingIds: doneDownloading,
          downloadErrors: doneErrors,
        ),
      );
    }
  }

  Future<void> downloadAll() async {
    if (state.media.isEmpty) return;
    if (state.downloadingAll || state.downloadingIds.isNotEmpty) return;

    if (state.privateMode && !state.hasPrivateCookie) {
      emit(state.copyWith(status: 'Private mode cần bấm Đăng nhập trước.'));
      return;
    }

    emit(
      state.copyWith(
        downloadingAll: true,
        status: 'Đang tải tất cả media...',
        downloadErrors: <int, String>{},
      ),
    );

    int successCount = 0;
    final items = List<IgMediaItem>.from(state.media);

    try {
      await requestSavePermission();

      for (final item in items) {
        final nextDownloading = {...state.downloadingIds, item.id};

        emit(
          state.copyWith(
            status: 'Đang tải media ${item.id}...',
            downloadingIds: nextDownloading,
          ),
        );

        try {
          await _downloadMediaWithRetry(item);

          successCount++;

          final doneDownloading = {...state.downloadingIds}..remove(item.id);
          final doneErrors = Map<int, String>.from(state.downloadErrors)
            ..remove(item.id);

          emit(
            state.copyWith(
              downloadingIds: doneDownloading,
              downloadErrors: doneErrors,
              status: 'Đã lưu media ${item.id}.',
            ),
          );
        } catch (e) {
          final doneDownloading = {...state.downloadingIds}..remove(item.id);
          final doneErrors = Map<int, String>.from(state.downloadErrors)
            ..[item.id] = _downloadErrorText(e);

          emit(
            state.copyWith(
              downloadingIds: doneDownloading,
              downloadErrors: doneErrors,
              status: 'Tải media ${item.id} lỗi, tiếp tục media khác...',
            ),
          );
        }
      }

      emit(
        state.copyWith(
          downloadingAll: false,
          downloadingIds: <int>{},
          status: successCount == items.length
              ? 'Tải xong tất cả vào album ${AppConstants.albumName}.'
              : 'Tải xong $successCount/${items.length} media. Có media bị lỗi.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          downloadingAll: false,
          downloadingIds: <int>{},
          status: 'Tải tất cả lỗi. Bấm thử lại.',
        ),
      );
    }
  }
}
