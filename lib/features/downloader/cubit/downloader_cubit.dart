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

    emit(state.copyWith(serverBaseUrl: server));
  }

  Future<void> saveServer(String serverUrl) async {
    final clean = serverUrl.trim();
    if (clean.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsServerBaseUrl, clean);

    emit(state.copyWith(serverBaseUrl: clean, status: 'Đã lưu server: $clean'));
  }

  Future<void> resolveMedia(String inputUrl) async {
    final url = inputUrl.trim();

    if (url.isEmpty) {
      emit(state.copyWith(status: 'Dán link Instagram trước đã.'));
      return;
    }

    emit(
      state.copyWith(
        loading: true,
        status: 'Chờ đợi là hạnh phúc 😏😼...',
        media: [],
      ),
    );

    try {
      final res = await http.post(
        Uri.parse('${state.serverBaseUrl}/resolve'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200 || data['success'] != true) {
        throw Exception(data['error'] ?? 'Resolve lỗi');
      }

      final List list = data['media'] ?? [];
      final media = list.map((x) => IgMediaItem.fromJson(x)).toList();

      emit(
        state.copyWith(
          loading: false,
          media: media,
          status: 'Bắt được ${media.length} media.',
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, status: 'Lỗi: $e'));
    }
  }

  Future<void> requestSavePermission() async {
    if (!Platform.isAndroid) return;

    await Permission.photos.request();
    await Permission.videos.request();
    await Permission.storage.request();
  }

  Future<void> downloadMedia(IgMediaItem item) async {
    await requestSavePermission();

    emit(state.copyWith(status: 'Đang tải media ${item.id}...'));

    try {
      final tempDir = await getTemporaryDirectory();

      final ext = item.isVideo ? 'mp4' : 'jpg';
      final filename =
          'instagram_${DateTime.now().millisecondsSinceEpoch}_${item.id}.$ext';

      final tempPath = '${tempDir.path}/$filename';

      final proxyUrl =
          '${state.serverBaseUrl}/download?url=${Uri.encodeComponent(item.downloadUrl)}';

      await dio.download(
        proxyUrl,
        tempPath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
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

      emit(
        state.copyWith(status: 'Đã lưu vào album ${AppConstants.albumName}.'),
      );
    } catch (e) {
      emit(state.copyWith(status: 'Tải lỗi: $e'));
    }
  }

  Future<void> downloadAll() async {
    if (state.media.isEmpty) return;

    for (final item in state.media) {
      await downloadMedia(item);
    }

    emit(
      state.copyWith(
        status: 'Tải xong tất cả vào album ${AppConstants.albumName}.',
      ),
    );
  }
}
