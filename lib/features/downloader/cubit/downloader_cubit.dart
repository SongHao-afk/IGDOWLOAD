import 'dart:convert';
import 'dart:io';

import 'package:vibration/vibration.dart';
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
import '../repository/frequent_profile_repository.dart';
import '../repository/profile_feed_repository.dart';
import '../repository/profile_story_repository.dart';
import 'downloader_messages.dart';
import 'downloader_state.dart';

class SavedDownloadFile {
  const SavedDownloadFile({required this.filename, required this.localPath});

  final String filename;
  final String localPath;
}

class DownloaderCubit extends Cubit<DownloaderState> {
  DownloaderCubit() : super(DownloaderState.initial());

  final Dio dio = Dio();

  final ProfileStoryRepository profileStoryRepository =
      const ProfileStoryRepository();

  final ProfileFeedRepository profileFeedRepository =
      const ProfileFeedRepository();

  final DownloadHistoryRepository downloadHistoryRepository =
      const DownloadHistoryRepository();

  final FrequentProfileRepository frequentProfileRepository =
      const FrequentProfileRepository();

  String _apiBase(String serverBaseUrl) {
    var clean = serverBaseUrl.trim();

    while (clean.endsWith('/')) {
      clean = clean.substring(0, clean.length - 1);
    }

    if (clean.endsWith('/instagram')) {
      return clean;
    }

    return '$clean/instagram';
  }

  String _serverErrorText(dynamic decoded, String fallback) {
    if (decoded is Map) {
      final detail = decoded['detail'];

      if (detail is Map && detail['message'] != null) {
        final message = detail['message'].toString().trim();
        if (message.isNotEmpty) return message;
      }

      if (decoded['error'] != null) {
        final message = decoded['error'].toString().trim();
        if (message.isNotEmpty) return message;
      }

      if (decoded['message'] != null) {
        final message = decoded['message'].toString().trim();
        if (message.isNotEmpty) return message;
      }
    }

    return fallback;
  }

  String _profileText(Map<String, dynamic>? profile, String key) {
    if (profile == null) {
      return '';
    }

    final direct = (profile[key] ?? '').toString().trim();

    if (direct.isNotEmpty && direct != 'null') {
      return direct;
    }

    final snakeKey = key.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (m) => '_${m.group(0)!.toLowerCase()}',
    );

    final snake = (profile[snakeKey] ?? '').toString().trim();

    if (snake.isNotEmpty && snake != 'null') {
      return snake;
    }

    return '';
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

  String _usernameFromProfileUrl(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return '';

    final uri = Uri.tryParse(clean);
    final segments =
        uri?.pathSegments
            .map((x) => x.trim())
            .where((x) => x.isNotEmpty)
            .toList() ??
        <String>[];

    var username = '';

    if (segments.isNotEmpty) {
      username =
          segments.first.toLowerCase() == 'stories' && segments.length >= 2
          ? segments[1]
          : segments.first;
    } else if (!clean.contains('/') && !clean.contains(' ')) {
      username = clean;
    }

    username = username.replaceFirst(RegExp(r'^@+'), '').trim();

    const reserved = {
      'p',
      'reel',
      'reels',
      'tv',
      'stories',
      'share',
      'explore',
      'accounts',
      'direct',
    };

    if (username.isEmpty || reserved.contains(username.toLowerCase())) {
      return '';
    }

    return username;
  }

  String _profileUrlFromUsername(String username) {
    final clean = username.trim().replaceFirst(RegExp(r'^@+'), '');
    if (clean.isEmpty) return '';
    return 'https://www.instagram.com/$clean/';
  }

  bool _isStoryOrHighlightUrl(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return false;

    final uri = Uri.tryParse(clean);
    final segments =
        uri?.pathSegments
            .map((x) => x.trim().toLowerCase())
            .where((x) => x.isNotEmpty)
            .toList() ??
        <String>[];

    if (segments.isEmpty) return false;

    return segments.first == 'stories' || segments.first == 's';
  }

  String _frequentProfileKey({
    required String userId,
    required String username,
  }) {
    final cleanUserId = userId.trim();
    if (cleanUserId.isNotEmpty) return 'id:$cleanUserId';

    final cleanUsername = username.trim().toLowerCase();
    if (cleanUsername.isNotEmpty) return 'username:$cleanUsername';

    return '';
  }

  Future<String> _copyToAppStorage({
    required String tempPath,
    required String filename,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final downloadsDir = Directory('${dir.path}/downloads');

    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    final localPath = '${downloadsDir.path}/$filename';
    await File(tempPath).copy(localPath);

    return localPath;
  }

  Future<void> _vibrateOnDownloadSuccess() async {
    final hasVibrator = await Vibration.hasVibrator() ?? false;
    if (!hasVibrator) return;

    await Vibration.vibrate(duration: 80);
  }

  Future<void> _saveFrequentProfile({
    required String userId,
    required String username,
    required String fullName,
    required String avatarUrl,
    required String profileUrl,
  }) async {
    final cleanUsername = username.trim().replaceFirst(RegExp(r'^@+'), '');
    final fallbackUsername = _usernameFromProfileUrl(profileUrl);
    final finalUsername = _firstNonEmpty([cleanUsername, fallbackUsername]);
    final cleanUserId = userId.trim();
    final key = _frequentProfileKey(
      userId: cleanUserId,
      username: finalUsername,
    );

    if (key.isEmpty || finalUsername.isEmpty) return;

    final cleanProfileUrl = _firstNonEmpty([
      profileUrl,
      _profileUrlFromUsername(finalUsername),
    ]);

    final nextItems = await frequentProfileRepository.upsert(
      FrequentProfileItem(
        key: key,
        userId: cleanUserId,
        username: finalUsername,
        fullName: fullName.trim(),
        avatarUrl: avatarUrl.trim(),
        profileUrl: cleanProfileUrl,
        lastVisitedAt: DateTime.now().toIso8601String(),
      ),
    );

    emit(state.copyWith(frequentProfiles: nextItems));
  }

  Future<void> _saveFrequentProfileFromResolvedMedia({
    required List<IgMediaItem> media,
    required String inputUrl,
  }) async {
    if (media.isEmpty) return;

    final firstItem = media.first;
    final username = _firstNonEmpty([
      firstItem.username,
      _usernameFromProfileUrl(firstItem.sourceUrl),
      _usernameFromProfileUrl(inputUrl),
    ]);

    if (username.isEmpty) return;

    await _saveFrequentProfile(
      userId: '',
      username: username,
      fullName: firstItem.fullName,
      avatarUrl: firstItem.avatarUrl,
      profileUrl: _profileUrlFromUsername(username),
    );
  }

  String _cleanHistoryShortcode(String? value) {
    final clean = value?.trim() ?? '';

    if (clean.isEmpty || clean == 'null') {
      return '';
    }

    final lower = clean.toLowerCase();

    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return '';
    }

    if (lower.contains('instagram.') || lower.contains('cdninstagram')) {
      return '';
    }

    if (lower.endsWith('.mp4') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp')) {
      return '';
    }

    return clean;
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
      _mapFirstText(decoded, [
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
      _mapFirstText(decoded, [
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
      _mapFirstText(decoded, [
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
        'thumb',
        'coverUrl',
        'cover_url',
        'displayUrl',
        'display_url',
        'imageUrl',
        'image_url',
        'poster',
      ]),
      type == 'image' || type == 'photo' ? downloadUrl : null,
    ]);

    putIfEmpty('username', username);
    putIfEmpty('fullName', fullName);
    putIfEmpty('avatarUrl', avatarUrl);
    putIfEmpty('shortcode', shortcode);
    putIfEmpty('sourceUrl', sourceUrl);
    putIfEmpty('thumbnailUrl', thumbnailUrl);

    return item;
  }

  List<IgMediaItem> _parseMediaResultToIgItems(
    Map<String, dynamic> decoded, {
    required String sourceUrl,
  }) {
    final status = (decoded['status'] ?? '').toString().trim();

    if (status == 'picker') {
      final picker = decoded['picker'];

      if (picker is! List) {
        return <IgMediaItem>[];
      }

      return picker
          .whereType<Map>()
          .toList()
          .asMap()
          .entries
          .map((entry) {
            final raw = Map<String, dynamic>.from(entry.value);

            raw['id'] = entry.key;
            raw['index'] = entry.key;

            raw['downloadUrl'] = _firstNonEmpty([
              raw['downloadUrl']?.toString(),
              raw['download_url']?.toString(),
              raw['url']?.toString(),
              raw['src']?.toString(),
            ]);

            raw['thumbnailUrl'] = _firstNonEmpty([
              raw['thumbnailUrl']?.toString(),
              raw['thumbnail_url']?.toString(),
              raw['thumb']?.toString(),
              raw['thumbnail']?.toString(),
              raw['coverUrl']?.toString(),
              raw['cover_url']?.toString(),
              raw['displayUrl']?.toString(),
              raw['display_url']?.toString(),
              raw['imageUrl']?.toString(),
              raw['image_url']?.toString(),
              raw['type']?.toString().toLowerCase() == 'photo'
                  ? raw['url']?.toString()
                  : null,
            ]);

            final map = _mergeResolveItemWithRootMetadata(
              rawItem: raw,
              decoded: decoded,
            );

            map['id'] = entry.key;
            map['index'] = entry.key;

            map['downloadUrl'] = _firstNonEmpty([
              map['downloadUrl']?.toString(),
              map['download_url']?.toString(),
              map['url']?.toString(),
              raw['downloadUrl']?.toString(),
            ]);

            map['thumbnailUrl'] = _firstNonEmpty([
              map['thumbnailUrl']?.toString(),
              map['thumbnail_url']?.toString(),
              map['thumb']?.toString(),
              raw['thumbnailUrl']?.toString(),
              raw['thumb']?.toString(),
              map['type']?.toString().toLowerCase() == 'photo'
                  ? map['downloadUrl']?.toString()
                  : null,
            ]);

            map['sourceUrl'] = _firstNonEmpty([
              map['sourceUrl']?.toString(),
              map['source_url']?.toString(),
              decoded['sourceUrl']?.toString(),
              decoded['source_url']?.toString(),
              sourceUrl,
            ]);

            return IgMediaItem.fromJson(map);
          })
          .where((item) {
            return item.downloadUrl.trim().isNotEmpty;
          })
          .toList();
    }

    if (status == 'success') {
      final downloadUrl = (decoded['url'] ?? '').toString().trim();

      if (downloadUrl.isEmpty) {
        return <IgMediaItem>[];
      }

      final raw = Map<String, dynamic>.from(decoded);

      raw['id'] = 0;
      raw['index'] = 0;
      raw['type'] =
          decoded['media_type'] ??
          decoded['mediaType'] ??
          decoded['type'] ??
          'photo';

      raw['downloadUrl'] = downloadUrl;

      raw['thumbnailUrl'] = _firstNonEmpty([
        decoded['thumbnailUrl']?.toString(),
        decoded['thumbnail_url']?.toString(),
        decoded['thumb']?.toString(),
        decoded['coverUrl']?.toString(),
        decoded['cover_url']?.toString(),
        raw['type']?.toString().toLowerCase() == 'photo' ? downloadUrl : null,
      ]);

      raw['sourceUrl'] = _firstNonEmpty([
        decoded['sourceUrl']?.toString(),
        decoded['source_url']?.toString(),
        sourceUrl,
      ]);

      raw['shortcode'] = _firstNonEmpty([
        decoded['shortcode']?.toString(),
        decoded['shortCode']?.toString(),
        decoded['code']?.toString(),
      ]);

      final map = _mergeResolveItemWithRootMetadata(
        rawItem: raw,
        decoded: decoded,
      );

      return [IgMediaItem.fromJson(map)].where((item) {
        return item.downloadUrl.trim().isNotEmpty;
      }).toList();
    }

    // Fallback giữ tương thích nếu lỡ còn test server cũ.
    if (decoded['success'] == true && decoded['media'] is List) {
      final list = decoded['media'] as List;

      return list
          .map(
            (x) => IgMediaItem.fromJson(
              _mergeResolveItemWithRootMetadata(rawItem: x, decoded: decoded),
            ),
          )
          .where((item) => item.downloadUrl.trim().isNotEmpty)
          .toList();
    }

    return <IgMediaItem>[];
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
    ].take(50).toList();

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

    const server = AppConstants.defaultServerBaseUrl;

    final privateMode = prefs.getBool(AppConstants.prefsPrivateMode) ?? false;
    final privateIgCookie = prefs.getString(AppConstants.prefsPrivateIgCookie);

    final history = await downloadHistoryRepository.getItems();
    final frequentProfiles = await frequentProfileRepository.getItems();

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
        frequentProfiles: frequentProfiles,
      ),
    );
  }

  Future<void> removeFrequentProfile(FrequentProfileItem item) async {
    final nextItems = await frequentProfileRepository.removeByKey(item.key);
    emit(state.copyWith(frequentProfiles: nextItems));
  }

  Future<void> loadFrequentProfileAll(FrequentProfileItem item) async {
    final username = item.username.trim();
    final profileUrl = _firstNonEmpty([
      item.profileUrl,
      _profileUrlFromUsername(username),
    ]);

    if (profileUrl.isEmpty && username.isEmpty) {
      emit(
        state.copyWith(
          profileError: DownloaderMessages.profileSavedMissingUsername(),
          status: DownloaderMessages.profileSavedMissingUsername(),
        ),
      );
      return;
    }

    if (!_guardPrivateLoginForStoryHighlight()) return;

    final sourceUrl = profileUrl.isNotEmpty
        ? profileUrl
        : _profileUrlFromUsername(username);

    emit(
      state.copyWith(
        profileMode: 'all',
        profileUrl: sourceUrl,
        media: <IgMediaItem>[],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
        profileGroupsLoading: true,
        profileItemsLoading: false,
        profileGroups: <ProfileStoryGroup>[],
        profileItems: <ProfileStoryItem>[],
        clearSelectedProfileGroup: true,
        downloadingProfileKeys: <String>{},
        profileFeedLoading: true,
        profileFeedLoadingMore: false,
        profileFeedHasNextPage: false,
        clearProfileFeedNextCursor: true,
        profileFeedItems: <ProfileFeedItem>[],
        clearSelectedProfileFeedItem: true,
        profileMediaLoading: false,
        profileMediaItems: <ProfileMediaItem>[],
        downloadingProfileMediaUrls: <String>{},
        profileUserId: item.userId,
        profileUsername: username,
        profileFullName: item.fullName,
        profileAvatarUrl: item.avatarUrl,
        clearProfileError: true,
        status: username.isEmpty
            ? DownloaderMessages.openingProfile()
            : DownloaderMessages.openingUsername(username),
      ),
    );

    List<ProfileStoryGroup> groups = <ProfileStoryGroup>[];
    ProfileFeedPageResult? reelsPage;
    ProfileFeedPageResult? postsPage;
    Object? lastError;

    try {
      groups = await profileStoryRepository.fetchStoryGroups(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: sourceUrl,
        privateIgCookie: state.activeIgCookie,
      );
    } catch (e) {
      lastError = e;
    }

    try {
      reelsPage = await profileFeedRepository.fetchProfileReels(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: sourceUrl,
        privateIgCookie: state.activeIgCookie,
        limit: 24,
      );
    } catch (e) {
      lastError = e;
    }

    try {
      postsPage = await profileFeedRepository.fetchProfilePosts(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: sourceUrl,
        privateIgCookie: state.activeIgCookie,
        limit: 24,
      );
    } catch (e) {
      lastError = e;
    }

    final feedItems = <ProfileFeedItem>[
      ...?reelsPage?.items,
      ...?postsPage?.items,
    ];

    final firstGroup = groups.isNotEmpty ? groups.first : null;
    final firstFeed = feedItems.isNotEmpty ? feedItems.first : null;
    final profile = postsPage?.profile ?? reelsPage?.profile;

    final nextUsername = _firstNonEmpty([
      _profileText(profile, 'username'),
      firstGroup?.username,
      firstFeed?.username,
      username,
      _usernameFromProfileUrl(sourceUrl),
    ]);
    final nextFullName = _firstNonEmpty([
      _profileText(profile, 'fullName'),
      firstGroup?.fullName,
      firstFeed?.fullName,
      item.fullName,
    ]);
    final nextAvatarUrl = _firstNonEmpty([
      _profileText(profile, 'avatarUrl'),
      firstGroup?.avatarUrl,
      firstFeed?.avatarUrl,
      item.avatarUrl,
    ]);
    final nextUserId = _firstNonEmpty([
      _profileText(profile, 'userId'),
      firstGroup?.userId,
      item.userId,
    ]);

    final nothingLoaded = groups.isEmpty && feedItems.isEmpty;
    final accessMessage = state.hasPrivateCookie
        ? DownloaderMessages.followRequired()
        : DownloaderMessages.loginRequired();

    emit(
      state.copyWith(
        profileMode: 'all',
        profileUrl: sourceUrl,
        profileGroupsLoading: false,
        profileFeedLoading: false,
        profileFeedLoadingMore: false,
        profileFeedHasNextPage: false,
        clearProfileFeedNextCursor: true,
        profileGroups: groups,
        profileFeedItems: feedItems,
        profileUserId: nextUserId,
        profileUsername: nextUsername,
        profileFullName: nextFullName,
        profileAvatarUrl: nextAvatarUrl,
        profileError: nothingLoaded ? accessMessage : null,
        clearProfileError: !nothingLoaded,
        status: nothingLoaded
            ? accessMessage
            : DownloaderMessages.foundStoryHighlightsAndPosts(
                groups.length,
                feedItems.length,
              ),
      ),
    );

    if (!nothingLoaded) {
      await _saveFrequentProfile(
        userId: nextUserId,
        username: nextUsername,
        fullName: nextFullName,
        avatarUrl: nextAvatarUrl,
        profileUrl: sourceUrl,
      );
    } else if (lastError != null) {
      return;
    }
  }

  Future<void> setPrivateMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsPrivateMode, value);

    emit(
      state.copyWith(
        privateMode: value,
        status: value
            ? DownloaderMessages.privateModeEnabled()
            : DownloaderMessages.publicModeEnabled(),
      ),
    );
  }

  Future<void> savePrivateCookie(String cookie) async {
    final clean = cookie.trim();

    if (clean.isEmpty || !clean.contains('sessionid=')) {
      emit(
        state.copyWith(
          status: DownloaderMessages.cannotConfirmInstagramLogin(),
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
        status: DownloaderMessages.instagramConnected(),
      ),
    );
  }

  Future<void> logoutPrivateCookie() async {
    if (state.sessionBusy) return;

    emit(
      state.copyWith(
        sessionBusy: true,
        status: DownloaderMessages.loggingOutInstagram(),
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
          status: DownloaderMessages.instagramLoggedOut(),
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
          status: DownloaderMessages.instagramLogoutCleanupFailed(),
        ),
      );
    }
  }

  Future<void> resolveMedia(String inputUrl) async {
    final url = inputUrl.trim();
    final isStoryOrHighlightUrl = _isStoryOrHighlightUrl(url);

    if (isStoryOrHighlightUrl && !_guardPrivateLoginForStoryHighlight()) {
      return;
    }

    if (url.isEmpty) {
      emit(state.copyWith(status: DownloaderMessages.emptyInstagramLink()));
      return;
    }

    emit(
      state.copyWith(
        loading: true,
        status: state.activeIgCookie == null
            ? DownloaderMessages.preparingContent()
            : DownloaderMessages.loadingContentWithAccount(),
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
      ),
    );

    try {
      final body = <String, dynamic>{
        'url': url,
        if (state.activeIgCookie != null) 'cookie': state.activeIgCookie,
      };

      final res = await http
          .post(
            Uri.parse('${_apiBase(state.serverBaseUrl)}/media'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 90));

      dynamic decoded;

      try {
        decoded = jsonDecode(res.body);
      } catch (_) {
        decoded = null;
      }

      if (res.statusCode != 200 || decoded is! Map) {
        throw Exception(_serverErrorText(decoded, 'cannot_fetch_content'));
      }

      final decodedMap = Map<String, dynamic>.from(decoded);

      if ((decodedMap['status'] ?? '').toString() == 'error') {
        throw Exception(_serverErrorText(decodedMap, 'cannot_fetch_content'));
      }

      final media = _parseMediaResultToIgItems(decodedMap, sourceUrl: url);

      if (media.isEmpty) {
        throw Exception('no_downloadable_content_found');
      }

      emit(
        state.copyWith(
          loading: false,
          media: media,
          status: DownloaderMessages.foundDownloadableContent(media.length),
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
        ),
      );

      await _saveFrequentProfileFromResolvedMedia(media: media, inputUrl: url);
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          status: state.activeIgCookie == null
              ? DownloaderMessages.fetchContentFailedPublic()
              : DownloaderMessages.fetchContentFailedPrivate(),
          downloadingIds: <int>{},
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
    return true;
  }

  bool _guardPrivateLoginForStoryHighlight() {
    if (state.hasPrivateCookie) {
      return true;
    }

    final message = DownloaderMessages.loginRequired();

    emit(state.copyWith(profileError: message, status: message));

    return false;
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
          profileError: DownloaderMessages.emptyProfileInput(),
          status: DownloaderMessages.emptyProfileInput(),
        ),
      );
      return;
    }

    if (!_guardPrivateLoginForStoryHighlight()) return;

    emit(
      state.copyWith(
        profileMode: 'stories',
        media: <IgMediaItem>[],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
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
        status: DownloaderMessages.loadingStoryHighlights(),
      ),
    );

    try {
      final groups = await profileStoryRepository.fetchStoryGroups(
        serverBaseUrl: state.serverBaseUrl,
        profileUrl: profileUrl,
        privateIgCookie: state.activeIgCookie,
      );

      final firstGroup = groups.isNotEmpty ? groups.first : null;

      emit(
        state.copyWith(
          profileGroupsLoading: false,
          profileGroups: groups,
          profileUserId: firstGroup?.userId ?? '',
          profileUsername: firstGroup?.username ?? '',
          profileFullName: firstGroup?.fullName ?? '',
          profileAvatarUrl: firstGroup?.avatarUrl ?? '',
          status: groups.isEmpty
              ? DownloaderMessages.noCurrentStoryOrHighlight()
              : DownloaderMessages.foundStoryHighlights(groups.length),
        ),
      );

      await _saveFrequentProfile(
        userId: firstGroup?.userId ?? '',
        username: firstGroup?.username ?? _usernameFromProfileUrl(profileUrl),
        fullName: firstGroup?.fullName ?? '',
        avatarUrl: firstGroup?.avatarUrl ?? '',
        profileUrl: profileUrl,
      );
    } catch (_) {
      final message = state.hasPrivateCookie
          ? DownloaderMessages.followRequired()
          : DownloaderMessages.loginRequired();

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
          profileError: DownloaderMessages.cannotOpenContent(),
          status: DownloaderMessages.cannotOpenContent(),
        ),
      );
      return;
    }

    if (!_guardPrivateLoginForStoryHighlight()) return;

    emit(
      state.copyWith(
        selectedProfileGroup: group,
        profileItemsLoading: true,
        profileItems: <ProfileStoryItem>[],
        downloadingProfileKeys: <String>{},
        clearProfileError: true,
        status: DownloaderMessages.openingStoryGroup(group.title),
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
              ? DownloaderMessages.noStoryItems()
              : DownloaderMessages.foundStoryGroupItems(
                  items.length,
                  group.title,
                ),
        ),
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? DownloaderMessages.cannotOpenStoryHighlightLogin()
          : DownloaderMessages.cannotOpenStoryHighlightPermission();

      emit(
        state.copyWith(
          profileItemsLoading: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<SavedDownloadFile> _downloadProfileStoryItemOnce(
    ProfileStoryItem item,
  ) async {
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

    final localPath = await _copyToAppStorage(
      tempPath: tempPath,
      filename: filename,
    );

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await file.delete();
    } catch (_) {}

    return SavedDownloadFile(filename: filename, localPath: localPath);
  }

  Future<SavedDownloadFile> _downloadProfileStoryItemWithRetry(
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
          profileError: DownloaderMessages.cannotDownloadContent(),
          status: DownloaderMessages.cannotDownloadContent(),
        ),
      );
      return;
    }

    if (state.downloadingProfileKeys.contains(item.downloadKey)) return;
    if (state.downloadingAll) return;
    if (!_guardPrivateLoginForStoryHighlight()) return;

    final nextDownloading = {...state.downloadingProfileKeys, item.downloadKey};

    emit(
      state.copyWith(
        downloadingProfileKeys: nextDownloading,
        clearProfileError: true,
        status: DownloaderMessages.downloadingStory(),
      ),
    );

    try {
      await requestSavePermission();

      final saved = await _downloadProfileStoryItemWithRetry(item);

      final group = state.selectedProfileGroup;

      final username = _firstNonEmpty([group?.username, state.profileUsername]);

      // Story/highlight chỉ tin metadata nằm trong group.
      // Không fallback sang state để tránh bê nhầm profile chủ cookie.
      final fullName = group?.fullName?.trim() ?? '';
      final avatarUrl = group?.avatarUrl?.trim() ?? '';

      final historyKey = item.downloadKey.trim();

      await _upsertDownloadHistoryItem(
        DownloadHistoryItem(
          key: historyKey,
          username: username,
          fullName: fullName,
          avatarUrl: avatarUrl,
          shortcode: historyKey,
          type: item.isVideo ? 'video' : 'image',
          sourceUrl: state.profileUrl,
          thumbnailUrl: _firstNonEmpty([
            item.thumbnailUrl,
            item.isVideo ? null : item.downloadUrl,
          ]),
          downloadUrl: historyKey,
          filename: saved.filename,
          localPath: saved.localPath,
          savedAt: DateTime.now().toIso8601String(),
        ),
      );

      await _vibrateOnDownloadSuccess();

      final doneDownloading = {...state.downloadingProfileKeys}
        ..remove(item.downloadKey);

      emit(
        state.copyWith(
          downloadingProfileKeys: doneDownloading,
          status: DownloaderMessages.savedStoryToAlbum(AppConstants.albumName),
        ),
      );
    } catch (_) {
      final doneDownloading = {...state.downloadingProfileKeys}
        ..remove(item.downloadKey);

      emit(
        state.copyWith(
          downloadingProfileKeys: doneDownloading,
          profileError: DownloaderMessages.downloadStoryFailed(),
          status: DownloaderMessages.downloadStoryFailed(),
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
          profileError: DownloaderMessages.emptyProfileInput(),
          status: DownloaderMessages.emptyProfileInput(),
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileMode: 'reels',
        profileUrl: profileUrl,
        media: <IgMediaItem>[],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
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
            ? DownloaderMessages.loadingReelsPublic()
            : DownloaderMessages.loadingReelsPrivate(),
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
      final firstItem = items.isNotEmpty ? items.first : null;
      final username = _firstNonEmpty([
        _profileText(page.profile, 'username'),
        firstItem?.username,
        _usernameFromProfileUrl(profileUrl),
      ]);
      final fullName = _firstNonEmpty([
        _profileText(page.profile, 'fullName'),
        firstItem?.fullName,
      ]);
      final avatarUrl = _firstNonEmpty([
        _profileText(page.profile, 'avatarUrl'),
        firstItem?.avatarUrl,
      ]);
      final userId = _profileText(page.profile, 'userId');

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedItems: items,
          profileFeedHasNextPage: page.hasNextPage,
          profileFeedNextCursor: page.nextCursor,
          clearProfileFeedNextCursor: page.nextCursor == null,
          profileUserId: userId,
          profileUsername: username,
          profileFullName: fullName,
          profileAvatarUrl: avatarUrl,
          status: items.isEmpty
              ? DownloaderMessages.noReelsOrPermission()
              : DownloaderMessages.foundReels(items.length),
        ),
      );

      await _saveFrequentProfile(
        userId: userId,
        username: username,
        fullName: fullName,
        avatarUrl: avatarUrl,
        profileUrl: profileUrl,
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? DownloaderMessages.cannotLoadReelsPublic()
          : DownloaderMessages.cannotLoadReelsPrivate();

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
          profileError: DownloaderMessages.emptyProfileInput(),
          status: DownloaderMessages.emptyProfileInput(),
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileMode: 'posts',
        profileUrl: profileUrl,
        media: <IgMediaItem>[],
        downloadingIds: <int>{},
        downloadErrors: <int, String>{},
        downloadingAll: false,
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
            ? DownloaderMessages.loadingPostsPublic()
            : DownloaderMessages.loadingPostsPrivate(),
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
      final firstItem = items.isNotEmpty ? items.first : null;
      final username = _firstNonEmpty([
        _profileText(page.profile, 'username'),
        firstItem?.username,
        _usernameFromProfileUrl(profileUrl),
      ]);
      final fullName = _firstNonEmpty([
        _profileText(page.profile, 'fullName'),
        firstItem?.fullName,
      ]);
      final avatarUrl = _firstNonEmpty([
        _profileText(page.profile, 'avatarUrl'),
        firstItem?.avatarUrl,
      ]);
      final userId = _profileText(page.profile, 'userId');

      emit(
        state.copyWith(
          profileFeedLoading: false,
          profileFeedLoadingMore: false,
          profileFeedItems: items,
          profileFeedHasNextPage: page.hasNextPage,
          profileFeedNextCursor: page.nextCursor,
          clearProfileFeedNextCursor: page.nextCursor == null,
          profileUserId: userId,
          profileUsername: username,
          profileFullName: fullName,
          profileAvatarUrl: avatarUrl,
          status: items.isEmpty
              ? DownloaderMessages.noPostsOrPermission()
              : DownloaderMessages.foundPosts(items.length),
        ),
      );

      await _saveFrequentProfile(
        userId: userId,
        username: username,
        fullName: fullName,
        avatarUrl: avatarUrl,
        profileUrl: profileUrl,
      );
    } catch (_) {
      final message = state.activeIgCookie == null
          ? DownloaderMessages.cannotLoadPostsPublic()
          : DownloaderMessages.cannotLoadPostsPrivate();

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
      emit(state.copyWith(status: DownloaderMessages.endOfContent()));
      return;
    }

    final cursor = state.profileFeedNextCursor?.trim();

    if (cursor == null || cursor.isEmpty) {
      emit(
        state.copyWith(
          profileFeedHasNextPage: false,
          clearProfileFeedNextCursor: true,
          status: DownloaderMessages.cannotLoadMoreContent(),
        ),
      );
      return;
    }

    final profileUrl = state.profileUrl.trim();

    if (profileUrl.isEmpty) {
      emit(
        state.copyWith(
          profileError: DownloaderMessages.cannotLoadMoreProfile(),
          status: DownloaderMessages.cannotLoadMoreProfile(),
        ),
      );
      return;
    }

    if (!_guardPrivateModeForProfile()) return;

    emit(
      state.copyWith(
        profileFeedLoadingMore: true,
        clearProfileError: true,
        status: DownloaderMessages.loadingMore(),
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
              ? DownloaderMessages.noMoreNewContent()
              : DownloaderMessages.loadedMoreContent(addedCount),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          profileFeedLoadingMore: false,
          profileError: DownloaderMessages.loadMoreFailed(),
          status: DownloaderMessages.loadMoreFailed(),
        ),
      );
    }
  }

  Future<void> loadProfileMediaItems(ProfileFeedItem item) async {
    if (item.shortcode.trim().isEmpty && item.url.trim().isEmpty) {
      emit(
        state.copyWith(
          profileError: DownloaderMessages.cannotOpenContent(),
          status: DownloaderMessages.cannotOpenContent(),
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
        status: kind == 'reel'
            ? DownloaderMessages.openingReel()
            : DownloaderMessages.openingPost(),
      ),
    );

    try {
      final rawItems = await profileFeedRepository.fetchProfileMediaItems(
        serverBaseUrl: state.serverBaseUrl,
        kind: kind,
        shortcode: item.shortcode,
        url: item.url,
        privateIgCookie: state.activeIgCookie,
      );

      // Backend /profile/reels đã trả cover ở item.coverUrl.
      // Nhưng /instagram/media đôi khi không trả thumb cho video detail,
      // nên phải bơm lại cover cũ vào ProfileMediaItem.
      final fallbackThumbnailUrl = _firstNonEmpty([item.coverUrl]);

      final items = rawItems.map((mediaItem) {
        final thumbnailUrl = _firstNonEmpty([
          mediaItem.thumbnailUrl,
          fallbackThumbnailUrl,

          // Nếu là ảnh thì dùng chính link ảnh làm cover.
          mediaItem.isVideo ? null : mediaItem.downloadUrl,
        ]);

        return mediaItem.copyWith(
          thumbnailUrl: thumbnailUrl.isEmpty ? null : thumbnailUrl,
        );
      }).toList();

      emit(
        state.copyWith(
          profileMediaLoading: false,
          profileMediaItems: items,
          status: items.isEmpty
              ? DownloaderMessages.cannotShowPostContent()
              : DownloaderMessages.foundDownloadableContent(items.length),
        ),
      );
    } catch (_) {
      final message = DownloaderMessages.cannotOpenContentPermission();

      emit(
        state.copyWith(
          profileMediaLoading: false,
          profileError: message,
          status: message,
        ),
      );
    }
  }

  Future<SavedDownloadFile> _downloadProfileMediaItemOnce(
    ProfileMediaItem item,
  ) async {
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

    final localPath = await _copyToAppStorage(
      tempPath: tempPath,
      filename: filename,
    );

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await file.delete();
    } catch (_) {}

    return SavedDownloadFile(filename: filename, localPath: localPath);
  }

  Future<SavedDownloadFile> _downloadProfileMediaItemWithRetry(
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
          profileError: DownloaderMessages.cannotDownloadContent(),
          status: DownloaderMessages.cannotDownloadContent(),
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
        status: DownloaderMessages.downloadingContent(),
      ),
    );

    try {
      await requestSavePermission();

      final saved = await _downloadProfileMediaItemWithRetry(item);

      final selectedFeed = state.selectedProfileFeedItem;

      final historyKey = downloadHistoryRepository.buildKeyFromDownloadUrl(
        downloadUrl,
      );

      final username = _firstNonEmpty([
        item.username,
        selectedFeed?.username,
        state.profileUsername,
      ]);

      final fullName = _firstNonEmpty([
        item.fullName,
        selectedFeed?.fullName,
        state.profileFullName,
      ]);

      final avatarUrl = _firstNonEmpty([
        item.avatarUrl,
        selectedFeed?.avatarUrl,
        state.profileAvatarUrl,
      ]);

      final shortcode = _cleanHistoryShortcode(
        _firstNonEmpty([item.shortcode, selectedFeed?.shortcode]),
      );

      final sourceUrl = _firstNonEmpty([
        item.sourceUrl,
        selectedFeed?.url,
        state.profileUrl,
      ]);

      final thumbnailUrl = _firstNonEmpty([
        item.thumbnailUrl,
        selectedFeed?.coverUrl,
        item.isVideo ? null : item.downloadUrl,
      ]);

      final historyItem = DownloadHistoryItem(
        key: historyKey,
        username: username,
        fullName: fullName,
        avatarUrl: avatarUrl,
        shortcode: shortcode,
        type: item.isVideo ? 'video' : 'image',
        sourceUrl: sourceUrl,
        thumbnailUrl: thumbnailUrl,
        downloadUrl: downloadUrl,
        filename: saved.filename,
        localPath: saved.localPath,
        savedAt: DateTime.now().toIso8601String(),
      );

      await _upsertDownloadHistoryItem(historyItem);

      await _vibrateOnDownloadSuccess();

      final doneDownloading = {...state.downloadingProfileMediaUrls}
        ..remove(downloadUrl);

      emit(
        state.copyWith(
          downloadingProfileMediaUrls: doneDownloading,
          status: DownloaderMessages.savedToAlbum(AppConstants.albumName),
        ),
      );
    } catch (_) {
      final doneDownloading = {...state.downloadingProfileMediaUrls}
        ..remove(downloadUrl);

      emit(
        state.copyWith(
          downloadingProfileMediaUrls: doneDownloading,
          profileError: DownloaderMessages.downloadContentErrorRetry(),
          status: DownloaderMessages.downloadContentErrorRetry(),
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
        status: DownloaderMessages.downloadHistoryCleared(),
      ),
    );
  }

  Future<void> removeDownloadHistoryItems(Set<String> keys) async {
    final cleanKeys = keys
        .map((x) => x.trim())
        .where((x) => x.isNotEmpty)
        .toSet();

    if (cleanKeys.isEmpty) return;

    for (final key in cleanKeys) {
      await downloadHistoryRepository.removeByKey(key);
    }

    final nextHistory = await downloadHistoryRepository.getItems();

    emit(
      state.copyWith(
        downloadHistory: nextHistory,
        downloadedProfileMediaKeys: nextHistory
            .map((x) => x.key.trim())
            .where((x) => x.isNotEmpty)
            .toSet(),
        status: DownloaderMessages.downloadHistoryItemsRemoved(
          cleanKeys.length,
        ),
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
          return DownloaderMessages.downloadConnectionSlow();
        case DioExceptionType.connectionError:
          return DownloaderMessages.downloadNetworkUnavailable();
        case DioExceptionType.cancel:
          return DownloaderMessages.downloadCancelled();
        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          return DownloaderMessages.downloadGenericError();
      }
    }

    return DownloaderMessages.downloadGenericError();
  }

  Future<SavedDownloadFile> _downloadMediaOnce(IgMediaItem item) async {
    final tempDir = await getTemporaryDirectory();

    final ext = item.isVideo ? 'mp4' : 'jpg';
    final filename =
        'instagram_${DateTime.now().millisecondsSinceEpoch}_${item.id}.$ext';

    final tempPath = '${tempDir.path}/$filename';

    final downloadUrl = item.downloadUrl.trim();

    if (downloadUrl.isEmpty) {
      throw Exception('download_url_empty');
    }

    await dio.download(
      downloadUrl,
      tempPath,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: true,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
              '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
          'Referer': 'https://www.instagram.com/',
        },
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
      onReceiveProgress: (received, total) {
        if (total <= 0) return;

        final percent = ((received / total) * 100).toStringAsFixed(0);

        emit(
          state.copyWith(status: DownloaderMessages.downloadProgress(percent)),
        );
      },
    );

    final localPath = await _copyToAppStorage(
      tempPath: tempPath,
      filename: filename,
    );

    if (item.isVideo) {
      await Gal.putVideo(tempPath, album: AppConstants.albumName);
    } else {
      await Gal.putImage(tempPath, album: AppConstants.albumName);
    }

    try {
      await File(tempPath).delete();
    } catch (_) {}

    return SavedDownloadFile(filename: filename, localPath: localPath);
  }

  Future<SavedDownloadFile> _downloadMediaWithRetry(IgMediaItem item) async {
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
    required SavedDownloadFile saved,
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

    final shortcode = _cleanHistoryShortcode(item.shortcode);

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
      filename: saved.filename,
      localPath: saved.localPath,
      savedAt: DateTime.now().toIso8601String(),
    );

    await _upsertDownloadHistoryItem(historyItem);
  }

  Future<void> downloadMedia(IgMediaItem item) async {
    if (state.downloadingIds.contains(item.id)) return;
    if (state.downloadingAll) return;

    final nextDownloading = {...state.downloadingIds, item.id};

    final nextErrors = Map<int, String>.from(state.downloadErrors)
      ..remove(item.id);

    emit(
      state.copyWith(
        status: DownloaderMessages.downloadingContent(),
        downloadingIds: nextDownloading,
        downloadErrors: nextErrors,
      ),
    );

    try {
      await requestSavePermission();

      final saved = await _downloadMediaWithRetry(item);

      await _addNormalMediaToHistory(item: item, saved: saved);
      await _vibrateOnDownloadSuccess();

      final doneDownloading = {...state.downloadingIds}..remove(item.id);

      final doneErrors = Map<int, String>.from(state.downloadErrors)
        ..remove(item.id);

      emit(
        state.copyWith(
          status: DownloaderMessages.savedContentToAlbum(
            AppConstants.albumName,
          ),
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
          status: DownloaderMessages.downloadContentErrorRetry(),
          downloadingIds: doneDownloading,
          downloadErrors: doneErrors,
        ),
      );
    }
  }
}
