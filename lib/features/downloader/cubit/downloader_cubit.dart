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
import '../../../core/utils/instagram_webview_cleaner.dart';
import '../models/ig_media_item.dart';
import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';
import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';
import '../repository/download_history_repository.dart';
import '../repository/profile_feed_repository.dart';
import '../repository/profile_story_repository.dart';
import 'downloader_state.dart';

class DownloaderCubit extends Cubit<DownloaderState> {
  DownloaderCubit() : super(DownloaderState.initial());

  final Dio dio = Dio();

  final ProfileStoryRepository profileStoryRepository =
      const ProfileStoryRepository();

  final ProfileFeedRepository profileFeedRepository =
      const ProfileFeedRepository();

  final DownloadHistoryRepository downloadHistoryRepository =
      const DownloadHistoryRepository();

  String _profileText(Map<String, dynamic>? profile, String key) {
    return (profile?[key] ?? '').toString().trim();
  }

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final clean = value?.trim() ?? '';

      if (clean.isNotEmpty && clean != 'null') {
        return clean;
      }
    }

    return '';
  }

  Map<String, dynamic> _safeMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }

  String _mapFirstText(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];

      if (value == null) {
        continue;
      }

      final clean = value.toString().trim();

      if (clean.isNotEmpty && clean != 'null') {
        return clean;
      }
    }

    return '';
  }

  Map<String, dynamic> _mergeResolveItemWithRootMetadata({
    required dynamic rawItem,
    required Map<String, dynamic> decoded,
  }) {
    final item = _safeMap(rawItem);
    final profile = _safeMap(decoded['profile']);

    void putIfEmpty(String key, String value) {
      final oldValue = item[key]?.toString().trim() ?? '';

      if (oldValue.isEmpty && value.trim().isNotEmpty) {
        item[key] = value.trim();
      }
    }

    final username = _firstNonEmpty([
      _mapFirstText(item, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
      _mapFirstText(profile, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
    ]);

    final fullName = _firstNonEmpty([
      _mapFirstText(item, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      _mapFirstText(profile, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
    ]);

    final avatarUrl = _firstNonEmpty([
      _mapFirstText(item, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
      _mapFirstText(profile, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
    ]);

    final shortcode = _firstNonEmpty([
      _mapFirstText(item, [
        'shortcode',
        'shortCode',
        'code',
        'mediaKey',
        'media_key',
      ]),
      _mapFirstText(decoded, [
        'mediaKey',
        'media_key',
        'shortcode',
        'shortCode',
        'code',
      ]),
    ]);

    final sourceUrl = _firstNonEmpty([
      _mapFirstText(item, [
        'sourceUrl',
        'source_url',
        'source',
        'normalizedSource',
        'normalized_source',
        'permalink',
      ]),
      _mapFirstText(decoded, [
        'normalizedSource',
        'normalized_source',
        'source',
        'sourceUrl',
        'source_url',
        'permalink',
      ]),
    ]);

    final type = _mapFirstText(item, [
      'type',
      'mediaType',
      'media_type',
    ]).toLowerCase();

    final downloadUrl = _mapFirstText(item, [
      'downloadUrl',
      'download_url',
      'url',
      'src',
    ]);

    final thumbnailUrl = _firstNonEmpty([
      _mapFirstText(item, [
        'thumbnailUrl',
        'thumbnail_url',
        'thumbnail',
        'coverUrl',
        'cover_url',
        'displayUrl',
        'display_url',
        'imageUrl',
        'image_url',
        'poster',
      ]),
      type == 'image' ? downloadUrl : null,
    ]);

    putIfEmpty('username', username);
    putIfEmpty('fullName', fullName);
    putIfEmpty('avatarUrl', avatarUrl);
    putIfEmpty('shortcode', shortcode);
    putIfEmpty('sourceUrl', sourceUrl);
    putIfEmpty('thumbnailUrl', thumbnailUrl);

    return item;
  }

  String _feedIdentityKey(ProfileFeedItem item) {
    final shortcode = item.shortcode.trim();

    if (shortcode.isNotEmpty) {
      return shortcode;
    }

    final id = item.id.trim();

    if (id.isNotEmpty) {
      return id;
    }

    return item.url.trim();
  }

  Future<void> _upsertDownloadHistoryItem(
    DownloadHistoryItem historyItem,
  ) async {
    final cleanKey = historyItem.key.trim();

    if (cleanKey.isEmpty) {
      return;
    }

    final cleanItem = historyItem.copyWith(key: cleanKey);

    await downloadHistoryRepository.addItem(cleanItem);

    final nextHistory = <DownloadHistoryItem>[
      cleanItem,
      ...state.downloadHistory.where((x) => x.key.trim() != cleanKey),
    ].take(300).toList();

    final nextDownloadedKeys = {...state.downloadedProfileMediaKeys, cleanKey};

    emit(
      state.copyWith(
        downloadHistory: nextHistory,
        downloadedProfileMediaKeys: nextDownloadedKeys,
      ),
    );
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final server =
        prefs.getString(AppConstants.prefsServerBaseUrl) ??
        AppConstants.defaultServerBaseUrl;

    final privateMode = prefs.getBool(AppConstants.prefsPrivateMode) ?? false;
    final privateIgCookie = prefs.getString(AppConstants.prefsPrivateIgCookie);

    final history = await downloadHistoryRepository.getItems();

    final downloadedKeys = history
        .map((x) => x.key.trim())
        .where((x) => x.isNotEmpty)
        .toSet();

    emit(
      state.copyWith(
        serverBaseUrl: server,
        privateMode: privateMode,
        privateIgCookie: privateIgCookie,
        downloadHistory: history,
        downloadedProfileMediaKeys: downloadedKeys,
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
        status: 'Đang đăng xuất và xoá sạch phiên Instagram...',
      ),
    );

    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool(AppConstants.prefsPrivateMode, false);
      await prefs.remove(AppConstants.prefsPrivateIgCookie);

      await InstagramWebViewCleaner.clearAll();

      emit(
        state.copyWith(
          privateMode: false,
          clearPrivateIgCookie: true,
          sessionBusy: false,
          media: <IgMediaItem>[],
          downloadingIds: <int>{},
          downloadErrors: <int, String>{},
          downloadingAll: false,
          profileMode: '',
          profileUrl: '',
          clearProfileIdentity: true,
          profileGroupsLoading: false,
          profileItemsLoading: false,
          profileGroups: <ProfileStoryGroup>[],
          profileItems: <ProfileStoryItem>[],
          clearSelectedProfileGroup: true,
          downloadingProfileKeys: <String>{},
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedHasNextPage: false,
          clearProfileFeedNextCursor: true,
          profileFeedItems: <ProfileFeedItem>[],
          clearSelectedProfileFeedItem: true,
          profileMediaLoading: false,
          profileMediaItems: <ProfileMediaItem>[],
          downloadingProfileMediaUrls: <String>{},
          clearProfileError: true,
          status:
              'Đã đăng xuất Private mode và xoá sạch WebView Instagram. Quay về Public.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          privateMode: false,
          clearPrivateIgCookie: true,
          sessionBusy: false,
          media: <IgMediaItem>[],
          downloadingIds: <int>{},
          downloadErrors: <int, String>{},
          downloadingAll: false,
          profileMode: '',
          profileUrl: '',
          clearProfileIdentity: true,
          profileGroupsLoading: false,
          profileItemsLoading: false,
          profileGroups: <ProfileStoryGroup>[],
          profileItems: <ProfileStoryItem>[],
          clearSelectedProfileGroup: true,
          downloadingProfileKeys: <String>{},
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedHasNextPage: false,
          clearProfileFeedNextCursor: true,
          profileFeedItems: <ProfileFeedItem>[],
          clearSelectedProfileFeedItem: true,
          profileMediaLoading: false,
          profileMediaItems: <ProfileMediaItem>[],
          downloadingProfileMediaUrls: <String>{},
          clearProfileError: true,
          status: 'Đã đăng xuất Private mode, nhưng xoá WebView có lỗi: $e',
        ),
      );
    }
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
        media: <IgMediaItem>[],
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

      final res = await http
          .post(
            Uri.parse('${state.serverBaseUrl}/resolve'),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 90));

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

      final decodedMap = Map<String, dynamic>.from(decoded);
      final List list = decodedMap['media'] ?? [];

      final media = list
          .map(
            (x) => IgMediaItem.fromJson(
              _mergeResolveItemWithRootMetadata(
                rawItem: x,
                decoded: decodedMap,
              ),
            ),
          )
          .toList();

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

  // =========================
  // PROFILE COMMON
  // =========================

  void setProfileMode(String mode) {
    emit(
      state.copyWith(
        profileMode: mode.trim().toLowerCase(),
        clearProfileError: true,
      ),
    );
  }

  void updateProfileUrl(String value) {
    emit(state.copyWith(profileUrl: value, clearProfileError: true));
  }

  bool _guardPrivateModeForProfile() {
    if (state.privateMode && !state.hasPrivateCookie) {
      emit(
        state.copyWith(
          profileError: 'Private mode cần bấm Đăng nhập trước.',
          status: 'Private mode cần bấm Đăng nhập trước.',
        ),
      );
      return false;
    }

    return true;
  }

  // =========================
  // PROFILE STORY / HIGHLIGHT
  // =========================

  Future<void> loadProfileStoryGroups() async {
    final profileUrl = state.profileUrl.trim();

    if (profileUrl.isEmpty) {
      emit(
        state.copyWith(
          profileMode: 'stories',
          profileError: 'Dán link trang cá nhân trước đã.',
          status: 'Dán link trang cá nhân trước đã.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileMode: 'stories',
        profileGroupsLoading: true,
        profileItemsLoading: false,
        profileGroups: <ProfileStoryGroup>[],
        profileItems: <ProfileStoryItem>[],
        clearSelectedProfileGroup: true,
        downloadingProfileKeys: <String>{},
        profileFeedLoading: false,
        profileFeedLoadingMore: false,
        profileFeedHasNextPage: false,
        clearProfileFeedNextCursor: true,
        profileFeedItems: <ProfileFeedItem>[],
        clearSelectedProfileFeedItem: true,
        profileMediaLoading: false,
        profileMediaItems: <ProfileMediaItem>[],
        downloadingProfileMediaUrls: <String>{},
        clearProfileIdentity: true,
        clearProfileError: true,
        status: state.activeIgCookie == null
            ? 'Đang lấy story/highlight bằng Public mode...'
            : 'Đang lấy story/highlight bằng Private mode...',
      ),
    );

    try {
      final groups = await profileStoryRepository.fetchStoryGroups(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: profileUrl,
        privateIgCookie: state.activeIgCookie,
      );

      emit(
        state.copyWith(
          profileGroupsLoading: false,
          profileGroups: groups,
          status: groups.isEmpty
              ? 'Không thấy story hiện tại hoặc tin nổi bật.'
              : 'Bắt được ${groups.length} mục story/highlight.',
        ),
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? 'Lỗi lấy profile. Kiểm tra link hoặc default session.'
          : 'Lỗi lấy profile bằng Private mode. Kiểm tra quyền xem hoặc đăng nhập lại.';

      emit(
        state.copyWith(
          profileGroupsLoading: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<void> loadProfileStoryGroupItems(ProfileStoryGroup group) async {
    final username = (group.username ?? '').trim();

    if (username.isEmpty) {
      emit(
        state.copyWith(
          profileError: 'Group thiếu username.',
          status: 'Group thiếu username.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        selectedProfileGroup: group,
        profileItemsLoading: true,
        profileItems: <ProfileStoryItem>[],
        downloadingProfileKeys: <String>{},
        clearProfileError: true,
        status: 'Đang mở "${group.title}"...',
      ),
    );

    try {
      final items = await profileStoryRepository.fetchStoryGroupItems(
        serverBaseUrl: state.serverBaseUrl,
        groupId: group.id,
        username: username,
        userId: group.userId,
        privateIgCookie: state.activeIgCookie,
      );

      emit(
        state.copyWith(
          profileItemsLoading: false,
          profileItems: items,
          status: items.isEmpty
              ? 'Mục "${group.title}" không có item hoặc session không có quyền xem.'
              : 'Bắt được ${items.length} item trong "${group.title}".',
        ),
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? 'Lỗi mở highlight/story. Kiểm tra default session.'
          : 'Lỗi mở highlight/story bằng Private mode. Kiểm tra quyền xem.';

      emit(
        state.copyWith(
          profileItemsLoading: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<String> _downloadProfileStoryItemOnce(ProfileStoryItem item) async {
    final bytes = await profileStoryRepository.downloadStoryItem(
      serverBaseUrl: state.serverBaseUrl,
      downloadKey: item.downloadKey,
      privateIgCookie: state.activeIgCookie,
    );

    final tempDir = await getTemporaryDirectory();

    final ext = item.isVideo ? 'mp4' : 'jpg';
    final filename =
        'instagram_story_${DateTime.now().millisecondsSinceEpoch}_${item.index}.$ext';

    final tempPath = '${tempDir.path}/$filename';
    final file = File(tempPath);

    await file.writeAsBytes(bytes);

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await file.delete();
    } catch (_) {}

    return filename;
  }

  Future<String> _downloadProfileStoryItemWithRetry(
    ProfileStoryItem item,
  ) async {
    Object? lastError;

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        return await _downloadProfileStoryItemOnce(item);
      } catch (e) {
        lastError = e;

        if (attempt < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }

    throw lastError ?? Exception('profile_story_download_failed');
  }

  Future<void> downloadProfileStoryItem(ProfileStoryItem item) async {
    if (item.downloadKey.trim().isEmpty) {
      emit(
        state.copyWith(
          profileError: 'Item thiếu downloadKey.',
          status: 'Item thiếu downloadKey.',
        ),
      );
      return;
    }

    if (state.downloadingProfileKeys.contains(item.downloadKey)) return;
    if (state.downloadingAll) return;
    if (!_guardPrivateModeForProfile()) return;

    final nextDownloading = {...state.downloadingProfileKeys, item.downloadKey};

    emit(
      state.copyWith(
        downloadingProfileKeys: nextDownloading,
        clearProfileError: true,
        status: 'Đang tải story item ${item.index}...',
      ),
    );

    try {
      await requestSavePermission();

      final filename = await _downloadProfileStoryItemWithRetry(item);

      final group = state.selectedProfileGroup;
      final username = _firstNonEmpty([group?.username, state.profileUsername]);

      final historyKey = item.downloadKey.trim();

      await _upsertDownloadHistoryItem(
        DownloadHistoryItem(
          key: historyKey,
          username: username,
          fullName: state.profileFullName,
          avatarUrl: state.profileAvatarUrl,
          shortcode: historyKey,
          type: item.isVideo ? 'video' : 'image',
          sourceUrl: state.profileUrl,
          thumbnailUrl: '',
          downloadUrl: historyKey,
          filename: filename,
          savedAt: DateTime.now().toIso8601String(),
        ),
      );

      final doneDownloading = {...state.downloadingProfileKeys}
        ..remove(item.downloadKey);

      emit(
        state.copyWith(
          downloadingProfileKeys: doneDownloading,
          status:
              'Đã lưu story item ${item.index} vào album ${AppConstants.albumName}.',
        ),
      );
    } catch (_) {
      final doneDownloading = {...state.downloadingProfileKeys}
        ..remove(item.downloadKey);

      emit(
        state.copyWith(
          downloadingProfileKeys: doneDownloading,
          profileError: 'Tải story item ${item.index} lỗi. Bấm thử lại.',
          status: 'Tải story item ${item.index} lỗi. Bấm thử lại.',
        ),
      );
    }
  }

  // =========================
  // PROFILE REELS / POSTS
  // =========================

  Future<void> loadProfileReels(String inputProfileUrl) async {
    final profileUrl = inputProfileUrl.trim();

    if (profileUrl.isEmpty) {
      emit(
        state.copyWith(
          profileMode: 'reels',
          profileError: 'Dán link trang cá nhân trước đã.',
          status: 'Dán link trang cá nhân trước đã.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileMode: 'reels',
        profileUrl: profileUrl,
        profileFeedLoading: true,
        profileFeedLoadingMore: false,
        profileFeedHasNextPage: false,
        clearProfileFeedNextCursor: true,
        profileFeedItems: <ProfileFeedItem>[],
        clearSelectedProfileFeedItem: true,
        profileMediaLoading: false,
        profileMediaItems: <ProfileMediaItem>[],
        downloadingProfileMediaUrls: <String>{},
        profileGroupsLoading: false,
        profileItemsLoading: false,
        profileGroups: <ProfileStoryGroup>[],
        profileItems: <ProfileStoryItem>[],
        clearSelectedProfileGroup: true,
        downloadingProfileKeys: <String>{},
        clearProfileIdentity: true,
        clearProfileError: true,
        status: state.activeIgCookie == null
            ? 'Đang lấy reels bằng Public mode...'
            : 'Đang lấy reels bằng Private mode...',
      ),
    );

    try {
      final page = await profileFeedRepository.fetchProfileReels(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: profileUrl,
        privateIgCookie: state.activeIgCookie,
        limit: 30,
      );

      final items = page.items;

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedItems: items,
          profileFeedHasNextPage: page.hasNextPage,
          profileFeedNextCursor: page.nextCursor,
          clearProfileFeedNextCursor: page.nextCursor == null,
          profileUsername: _profileText(page.profile, 'username'),
          profileFullName: _profileText(page.profile, 'fullName'),
          profileAvatarUrl: _profileText(page.profile, 'avatarUrl'),
          status: items.isEmpty
              ? 'Profile này chưa có reel hoặc session không có quyền xem.'
              : 'Bắt được ${items.length} video reel.',
        ),
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? 'Lỗi lấy reels. Kiểm tra link hoặc default session.'
          : 'Lỗi lấy reels bằng Private mode. Kiểm tra quyền xem.';

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<void> loadProfilePosts(String inputProfileUrl) async {
    final profileUrl = inputProfileUrl.trim();

    if (profileUrl.isEmpty) {
      emit(
        state.copyWith(
          profileMode: 'posts',
          profileError: 'Dán link trang cá nhân trước đã.',
          status: 'Dán link trang cá nhân trước đã.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileMode: 'posts',
        profileUrl: profileUrl,
        profileFeedLoading: true,
        profileFeedLoadingMore: false,
        profileFeedHasNextPage: false,
        clearProfileFeedNextCursor: true,
        profileFeedItems: <ProfileFeedItem>[],
        clearSelectedProfileFeedItem: true,
        profileMediaLoading: false,
        profileMediaItems: <ProfileMediaItem>[],
        downloadingProfileMediaUrls: <String>{},
        profileGroupsLoading: false,
        profileItemsLoading: false,
        profileGroups: <ProfileStoryGroup>[],
        profileItems: <ProfileStoryItem>[],
        clearSelectedProfileGroup: true,
        downloadingProfileKeys: <String>{},
        clearProfileIdentity: true,
        clearProfileError: true,
        status: state.activeIgCookie == null
            ? 'Đang lấy ảnh/bài viết bằng Public mode...'
            : 'Đang lấy ảnh/bài viết bằng Private mode...',
      ),
    );

    try {
      final page = await profileFeedRepository.fetchProfilePosts(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: profileUrl,
        privateIgCookie: state.activeIgCookie,
        limit: 30,
      );

      final items = page.items;

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedItems: items,
          profileFeedHasNextPage: page.hasNextPage,
          profileFeedNextCursor: page.nextCursor,
          clearProfileFeedNextCursor: page.nextCursor == null,
          profileUsername: _profileText(page.profile, 'username'),
          profileFullName: _profileText(page.profile, 'fullName'),
          profileAvatarUrl: _profileText(page.profile, 'avatarUrl'),
          status: items.isEmpty
              ? 'Profile này chưa có ảnh/bài viết hoặc session không có quyền xem.'
              : 'Bắt được ${items.length} ảnh/bài viết.',
        ),
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? 'Lỗi lấy ảnh/bài viết. Kiểm tra link hoặc default session.'
          : 'Lỗi lấy ảnh/bài viết bằng Private mode. Kiểm tra quyền xem.';

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<void> loadMoreProfileFeed() async {
    if (state.profileFeedLoading || state.profileFeedLoadingMore) return;

    if (state.profileMode != 'reels' && state.profileMode != 'posts') {
      return;
    }

    if (!state.profileFeedHasNextPage) {
      emit(state.copyWith(status: 'Đã hết dữ liệu.'));
      return;
    }

    final cursor = state.profileFeedNextCursor?.trim();

    if (cursor == null || cursor.isEmpty) {
      emit(
        state.copyWith(
          profileFeedHasNextPage: false,
          clearProfileFeedNextCursor: true,
          status: 'Không có cursor để tải tiếp.',
        ),
      );
      return;
    }

    final profileUrl = state.profileUrl.trim();

    if (profileUrl.isEmpty) {
      emit(
        state.copyWith(
          profileError: 'Thiếu link profile để tải tiếp.',
          status: 'Thiếu link profile để tải tiếp.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileFeedLoadingMore: true,
        clearProfileError: true,
        status: 'Đang tải thêm...',
      ),
    );

    try {
      final page = state.profileMode == 'reels'
          ? await profileFeedRepository.fetchProfileReels(
              serverBaseUrl: state.serverBaseUrl,
              profileUrl: profileUrl,
              privateIgCookie: state.activeIgCookie,
              limit: 30,
              cursor: cursor,
            )
          : await profileFeedRepository.fetchProfilePosts(
              serverBaseUrl: state.serverBaseUrl,
              profileUrl: profileUrl,
              privateIgCookie: state.activeIgCookie,
              limit: 30,
              cursor: cursor,
            );

      final existed = state.profileFeedItems
          .map(_feedIdentityKey)
          .where((x) => x.trim().isNotEmpty)
          .toSet();

      final nextItems = <ProfileFeedItem>[...state.profileFeedItems];

      int addedCount = 0;

      for (final item in page.items) {
        final key = _feedIdentityKey(item);

        if (key.isEmpty) {
          nextItems.add(item);
          addedCount++;
          continue;
        }

        if (!existed.contains(key)) {
          existed.add(key);
          nextItems.add(item);
          addedCount++;
        }
      }

      emit(
        state.copyWith(
          profileFeedLoadingMore: false,
          profileFeedItems: nextItems,
          profileFeedHasNextPage: page.hasNextPage,
          profileFeedNextCursor: page.nextCursor,
          clearProfileFeedNextCursor: page.nextCursor == null,
          status: addedCount == 0
              ? 'Không có thêm dữ liệu mới.'
              : 'Đã tải thêm $addedCount mục. Tổng ${nextItems.length}.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          profileFeedLoadingMore: false,
          profileError: 'Tải thêm lỗi. Bấm thử lại.',
          status: 'Tải thêm lỗi. Bấm thử lại.',
        ),
      );
    }
  }

  Future<void> loadProfileMediaItems(ProfileFeedItem item) async {
    if (item.shortcode.trim().isEmpty) {
      emit(
        state.copyWith(
          profileError: 'Item thiếu shortcode.',
          status: 'Item thiếu shortcode.',
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    final kind = item.kind == 'reel' ? 'reel' : 'post';

    emit(
      state.copyWith(
        selectedProfileFeedItem: item,
        profileMediaLoading: true,
        profileMediaItems: <ProfileMediaItem>[],
        downloadingProfileMediaUrls: <String>{},
        clearProfileError: true,
        status:
            'Đang mở ${kind == 'reel' ? 'reel' : 'bài viết'} ${item.shortcode}...',
      ),
    );

    try {
      final items = await profileFeedRepository.fetchProfileMediaItems(
        serverBaseUrl: state.serverBaseUrl,
        kind: kind,
        shortcode: item.shortcode,
        url: item.url,
        privateIgCookie: state.activeIgCookie,
      );

      emit(
        state.copyWith(
          profileMediaLoading: false,
          profileMediaItems: items,
          status: items.isEmpty
              ? 'Không lấy được item con.'
              : 'Bắt được ${items.length} item con.',
        ),
      );
    } catch (_) {
      const message = 'Lỗi mở item. Kiểm tra quyền xem hoặc thử lại.';

      emit(
        state.copyWith(
          profileMediaLoading: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<String> _downloadProfileMediaItemOnce(ProfileMediaItem item) async {
    final bytes = await profileFeedRepository.downloadProfileMediaItem(
      serverBaseUrl: state.serverBaseUrl,
      downloadUrl: item.downloadUrl,
      privateIgCookie: state.activeIgCookie,
    );

    final tempDir = await getTemporaryDirectory();

    final ext = item.isVideo ? 'mp4' : 'jpg';
    final filename =
        'instagram_profile_media_${DateTime.now().millisecondsSinceEpoch}_${item.index}.$ext';

    final tempPath = '${tempDir.path}/$filename';
    final file = File(tempPath);

    await file.writeAsBytes(bytes);

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await file.delete();
    } catch (_) {}

    return filename;
  }

  Future<String> _downloadProfileMediaItemWithRetry(
    ProfileMediaItem item,
  ) async {
    Object? lastError;

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        return await _downloadProfileMediaItemOnce(item);
      } catch (e) {
        lastError = e;

        if (attempt < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }

    throw lastError ?? Exception('profile_media_download_failed');
  }

  Future<void> downloadProfileMediaItem(ProfileMediaItem item) async {
    final downloadUrl = item.downloadUrl.trim();

    if (downloadUrl.isEmpty) {
      emit(
        state.copyWith(
          profileError: 'Item thiếu downloadUrl.',
          status: 'Item thiếu downloadUrl.',
        ),
      );
      return;
    }

    if (state.downloadingProfileMediaUrls.contains(downloadUrl)) return;
    if (state.downloadingAll) return;
    if (!_guardPrivateModeForProfile()) return;

    final nextDownloading = {...state.downloadingProfileMediaUrls, downloadUrl};

    emit(
      state.copyWith(
        downloadingProfileMediaUrls: nextDownloading,
        clearProfileError: true,
        status: 'Đang tải item ${item.index}...',
      ),
    );

    try {
      await requestSavePermission();

      final filename = await _downloadProfileMediaItemWithRetry(item);

      final selectedFeed = state.selectedProfileFeedItem;

      final historyKey = downloadHistoryRepository.buildKeyFromDownloadUrl(
        downloadUrl,
      );

      final historyItem = DownloadHistoryItem(
        key: historyKey,
        username: state.profileUsername,
        fullName: state.profileFullName,
        avatarUrl: state.profileAvatarUrl,
        shortcode: selectedFeed?.shortcode ?? '',
        type: item.type,
        sourceUrl: selectedFeed?.url ?? '',
        thumbnailUrl: _firstNonEmpty([
          item.thumbnailUrl,
          selectedFeed?.coverUrl,
        ]),
        downloadUrl: downloadUrl,
        filename: filename,
        savedAt: DateTime.now().toIso8601String(),
      );

      await _upsertDownloadHistoryItem(historyItem);

      final doneDownloading = {...state.downloadingProfileMediaUrls}
        ..remove(downloadUrl);

      emit(
        state.copyWith(
          downloadingProfileMediaUrls: doneDownloading,
          status:
              'Đã lưu item ${item.index} vào album ${AppConstants.albumName}.',
        ),
      );
    } catch (_) {
      final doneDownloading = {...state.downloadingProfileMediaUrls}
        ..remove(downloadUrl);

      emit(
        state.copyWith(
          downloadingProfileMediaUrls: doneDownloading,
          profileError: 'Tải item ${item.index} lỗi. Bấm thử lại.',
          status: 'Tải item ${item.index} lỗi. Bấm thử lại.',
        ),
      );
    }
  }

  Future<void> clearDownloadHistory() async {
    await downloadHistoryRepository.clear();

    emit(
      state.copyWith(
        downloadHistory: <DownloadHistoryItem>[],
        downloadedProfileMediaKeys: <String>{},
        status: 'Đã xoá lịch sử tải.',
      ),
    );
  }

  // =========================
  // LINK LẺ DOWNLOAD
  // =========================

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

  Future<String> _downloadMediaOnce(IgMediaItem item) async {
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

    return filename;
  }

  Future<String> _downloadMediaWithRetry(IgMediaItem item) async {
    Object? lastError;

    for (int attempt = 1; attempt <= 2; attempt++) {
      try {
        return await _downloadMediaOnce(item);
      } catch (e) {
        lastError = e;

        if (attempt < 2) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }

    throw lastError ?? Exception('download_failed');
  }

  Future<void> _addNormalMediaToHistory({
    required IgMediaItem item,
    required String filename,
  }) async {
    final downloadUrl = item.downloadUrl.trim();

    if (downloadUrl.isEmpty) {
      return;
    }

    final historyKey = downloadHistoryRepository.buildKeyFromDownloadUrl(
      downloadUrl,
    );

    final thumbnailUrl = _firstNonEmpty([
      item.thumbnailUrl,
      item.isVideo ? null : item.downloadUrl,
    ]);

    final shortcode = _firstNonEmpty([item.shortcode, item.id.toString()]);

    final sourceUrl = _firstNonEmpty([item.sourceUrl, state.profileUrl]);

    final historyItem = DownloadHistoryItem(
      key: historyKey,
      username: item.username,
      fullName: item.fullName,
      avatarUrl: item.avatarUrl,
      shortcode: shortcode,
      type: item.isVideo ? 'video' : 'image',
      sourceUrl: sourceUrl,
      thumbnailUrl: thumbnailUrl,
      downloadUrl: downloadUrl,
      filename: filename,
      savedAt: DateTime.now().toIso8601String(),
    );

    await _upsertDownloadHistoryItem(historyItem);
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

      final filename = await _downloadMediaWithRetry(item);

      await _addNormalMediaToHistory(item: item, filename: filename);

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

    if (state.downloadingAll ||
        state.downloadingIds.isNotEmpty ||
        state.downloadingProfileKeys.isNotEmpty ||
        state.downloadingProfileMediaUrls.isNotEmpty) {
      return;
    }

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
          final filename = await _downloadMediaWithRetry(item);

          await _addNormalMediaToHistory(item: item, filename: filename);

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
