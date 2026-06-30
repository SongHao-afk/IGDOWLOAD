import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';

class ProfileFeedPageResult {
  final List<ProfileFeedItem> items;
  final bool hasNextPage;
  final String? nextCursor;
  final Map<String, dynamic>? profile;

  const ProfileFeedPageResult({
    required this.items,
    required this.hasNextPage,
    required this.nextCursor,
    required this.profile,
  });
}

class ProfileFeedRepository {
  const ProfileFeedRepository();

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

  Map<String, String> _headers() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, dynamic> _bodyWithCookie(
    Map<String, dynamic> body,
    String? privateIgCookie,
  ) {
    final cookie = privateIgCookie?.trim();

    return {...body, if (cookie != null && cookie.isNotEmpty) 'cookie': cookie};
  }

  String _errorMessage(dynamic body, String fallback) {
    if (body is Map) {
      final detail = body['detail'];

      if (detail is Map && detail['message'] != null) {
        return detail['message'].toString();
      }

      if (body['error'] != null) {
        return body['error'].toString();
      }

      if (body['message'] != null) {
        return body['message'].toString();
      }
    }

    return fallback;
  }

  Map<String, dynamic> _stringMap(dynamic value) {
    if (value is! Map) {
      return <String, dynamic>{};
    }

    final result = <String, dynamic>{};

    value.forEach((key, mapValue) {
      result[key.toString()] = mapValue;
    });

    return result;
  }

  Map<dynamic, dynamic> _dynamicMap(dynamic value) {
    if (value is Map) {
      return Map<dynamic, dynamic>.from(value);
    }

    return <dynamic, dynamic>{};
  }

  String _firstText(Map map, List<String> keys) {
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

  String _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final clean = value?.trim() ?? '';

      if (clean.isNotEmpty && clean != 'null') {
        return clean;
      }
    }

    return '';
  }

  void _putIfEmpty(Map map, String key, String value) {
    final oldValue = map[key]?.toString().trim() ?? '';

    if (oldValue.isEmpty && value.trim().isNotEmpty) {
      map[key] = value.trim();
    }
  }

  String _usernameFromProfileUrl(String value) {
    final clean = value.trim();

    if (clean.isEmpty) {
      return '';
    }

    Uri? uri;

    try {
      uri = Uri.parse(clean);
    } catch (_) {
      uri = null;
    }

    final segments =
        uri?.pathSegments
            .map((x) => x.trim())
            .where((x) => x.isNotEmpty)
            .toList() ??
        <String>[];

    String username = '';

    if (segments.isNotEmpty) {
      final first = segments.first.toLowerCase();

      if (first == 'stories' && segments.length >= 2) {
        username = segments[1];
      } else {
        username = segments.first;
      }
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
      'about',
      'developer',
      'api',
    };

    if (username.isEmpty || reserved.contains(username.toLowerCase())) {
      return '';
    }

    return username;
  }

  bool _sameUsername(String a, String b) {
    final left = a.trim().replaceFirst(RegExp(r'^@+'), '').toLowerCase();
    final right = b.trim().replaceFirst(RegExp(r'^@+'), '').toLowerCase();

    return left.isNotEmpty && left == right;
  }

  bool _looksLikeImageUrl(String value) {
    final clean = value.toLowerCase();

    return clean.contains('.jpg') ||
        clean.contains('.jpeg') ||
        clean.contains('.png') ||
        clean.contains('.webp') ||
        clean.contains('scontent') ||
        clean.contains('cdninstagram');
  }

  bool _isVideoType(dynamic value) {
    final clean = value?.toString().trim().toLowerCase() ?? '';

    return clean == '2' ||
        clean == 'video' ||
        clean == 'reel' ||
        clean == 'clips';
  }

  bool _isPhotoType(dynamic value) {
    final clean = value?.toString().trim().toLowerCase() ?? '';

    return clean == '1' ||
        clean == 'photo' ||
        clean == 'image' ||
        clean == 'jpg';
  }

  String _normalizeMediaType(dynamic value) {
    if (_isVideoType(value)) {
      return 'video';
    }

    return 'photo';
  }

  ProfileFeedPageResult _parseFeedPage(
    dynamic decoded, {
    required String kind,
    required String profileUrl,
  }) {
    final root = decoded is Map ? decoded : <dynamic, dynamic>{};

    final rawProfile = root['profile'];

    final profile = rawProfile is Map
        ? _stringMap(rawProfile)
        : <String, dynamic>{
            'username':
                root['username'] ?? root['userName'] ?? root['user_name'] ?? '',
            'userId':
                root['userId'] ??
                root['user_id'] ??
                root['pk'] ??
                root['id'] ??
                '',
            'fullName': root['fullName'] ?? root['full_name'] ?? '',
            'avatarUrl': root['avatarUrl'] ?? root['avatar_url'] ?? '',
          };

    final requestedUsername = _usernameFromProfileUrl(profileUrl);

    final profileUsername = _firstText(profile, [
      'username',
      'userName',
      'user_name',
      'ownerUsername',
      'owner_username',
    ]);

    final profileFullName = _firstText(profile, [
      'fullName',
      'full_name',
      'ownerFullName',
      'owner_full_name',
      'name',
    ]);

    final profileAvatarUrl = _firstText(profile, [
      'avatarUrl',
      'avatar_url',
      'profilePicUrl',
      'profile_pic_url',
      'profilePicUrlHd',
      'profile_pic_url_hd',
      'ownerAvatarUrl',
      'owner_avatar_url',
    ]);

    final rootUserId = _firstText(root, [
      'userId',
      'user_id',
      'pk',
      'id',
    ]);

    final profileUserId = _firstText(profile, [
      'userId',
      'user_id',
      'pk',
      'id',
    ]);

    // Mode profile phải ưu tiên username từ URL người dùng dán.
    // Nếu server trả profile chủ cookie thì không bê fullName/avatar sai vào item.
    final safeUsername = requestedUsername.isNotEmpty
        ? requestedUsername
        : profileUsername;

    final profileMatchesRequest =
        requestedUsername.isEmpty ||
        profileUsername.isEmpty ||
        _sameUsername(requestedUsername, profileUsername);

    final safeFullName = profileMatchesRequest ? profileFullName : '';
    final safeAvatarUrl = profileMatchesRequest ? profileAvatarUrl : '';

    final safeProfile = <String, dynamic>{
      ...profile,
      'userId': profileUserId.isNotEmpty ? profileUserId : rootUserId,
      'username': safeUsername,
      'fullName': safeFullName,
      'avatarUrl': safeAvatarUrl,
    };

    final rawItems = root['items'];

    final items = rawItems is List
        ? rawItems.whereType<Map>().toList().asMap().entries.map((entry) {
            final map = Map<dynamic, dynamic>.from(entry.value);

            map.putIfAbsent('index', () => entry.key);
            map['kind'] = kind;

            if (map['type'] == null && map['mediaType'] != null) {
              map['type'] = map['mediaType'];
            }

            if (map['type'] == null && map['media_type'] != null) {
              map['type'] = map['media_type'];
            }

            if (safeUsername.isNotEmpty) {
              map['username'] = safeUsername;
            }

            _putIfEmpty(map, 'fullName', safeFullName);
            _putIfEmpty(map, 'avatarUrl', safeAvatarUrl);

            return ProfileFeedItem.fromJson(map);
          }).toList()
        : <ProfileFeedItem>[];

    final rawCursor =
        root['nextCursor'] ??
        root['next_cursor'] ??
        root['nextMaxId'] ??
        root['next_max_id'] ??
        root['maxId'] ??
        root['max_id'];

    final nextCursor = rawCursor?.toString().trim();

    return ProfileFeedPageResult(
      items: items,
      hasNextPage: nextCursor != null && nextCursor.isNotEmpty,
      nextCursor: nextCursor == null || nextCursor.isEmpty ? null : nextCursor,
      profile: safeProfile,
    );
  }

  Future<ProfileFeedPageResult> fetchProfileReels({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
    int limit = 30,
    String? cursor,
  }) async {
    final uri = Uri.parse('${_apiBase(serverBaseUrl)}/profile/reels');

    final body = <String, dynamic>{
      'url': profileUrl,
      'limit': limit,
      if (cursor != null && cursor.trim().isNotEmpty) 'cursor': cursor.trim(),
    };

    final response = await http
        .post(
          uri,
          headers: _headers(),
          body: jsonEncode(_bodyWithCookie(body, privateIgCookie)),
        )
        .timeout(const Duration(seconds: 90));

    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }

    if (response.statusCode != 200 ||
        decoded is! Map ||
        decoded['success'] != true) {
      throw Exception(_errorMessage(decoded, 'Không lấy được reels'));
    }

    return _parseFeedPage(decoded, kind: 'reel', profileUrl: profileUrl);
  }

  Future<ProfileFeedPageResult> fetchProfilePosts({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
    int limit = 30,
    String? cursor,
  }) async {
    final uri = Uri.parse('${_apiBase(serverBaseUrl)}/profile/posts');

    final body = <String, dynamic>{
      'url': profileUrl,
      'limit': limit,
      if (cursor != null && cursor.trim().isNotEmpty) 'cursor': cursor.trim(),
    };

    final response = await http
        .post(
          uri,
          headers: _headers(),
          body: jsonEncode(_bodyWithCookie(body, privateIgCookie)),
        )
        .timeout(const Duration(seconds: 90));

    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }

    if (response.statusCode != 200 ||
        decoded is! Map ||
        decoded['success'] != true) {
      throw Exception(_errorMessage(decoded, 'Không lấy được ảnh/bài viết'));
    }

    return _parseFeedPage(decoded, kind: 'post', profileUrl: profileUrl);
  }

  Future<List<ProfileMediaItem>> fetchProfileMediaItems({
    required String serverBaseUrl,
    required String kind,
    required String shortcode,
    String? url,
    String? privateIgCookie,
  }) async {
    final cleanUrl = url?.trim();

    final mediaUrl = cleanUrl != null && cleanUrl.isNotEmpty
        ? cleanUrl
        : 'https://www.instagram.com/${kind == 'reel' ? 'reel' : 'p'}/$shortcode/';

    final uri = Uri.parse('${_apiBase(serverBaseUrl)}/media');

    final response = await http
        .post(
          uri,
          headers: _headers(),
          body: jsonEncode(_bodyWithCookie({'url': mediaUrl}, privateIgCookie)),
        )
        .timeout(const Duration(seconds: 90));

    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      decoded = null;
    }

    if (response.statusCode != 200 || decoded is! Map) {
      throw Exception(_errorMessage(decoded, 'Không lấy được media item'));
    }

    final status = (decoded['status'] ?? '').toString();

    if (status == 'error') {
      throw Exception(decoded['error']?.toString() ?? 'Không lấy được media');
    }

    return _mediaResultToProfileItems(decoded, sourceUrl: mediaUrl);
  }

  Map<dynamic, dynamic> _mergeProfileMediaMetadata({
    required Map<dynamic, dynamic> raw,
    required Map decoded,
    required String sourceUrl,
    required int index,
  }) {
    final map = Map<dynamic, dynamic>.from(raw);
    final profile = _dynamicMap(decoded['profile']);

    final username = _firstNonEmpty([
      _firstText(map, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
      _firstText(decoded, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
      _firstText(profile, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
    ]);

    final fullName = _firstNonEmpty([
      _firstText(map, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      _firstText(decoded, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      _firstText(profile, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
    ]);

    final avatarUrl = _firstNonEmpty([
      _firstText(map, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
      _firstText(decoded, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
      _firstText(profile, [
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
      _firstText(map, [
        'shortcode',
        'shortCode',
        'code',
        'mediaKey',
        'media_key',
      ]),
      _firstText(decoded, [
        'shortcode',
        'shortCode',
        'code',
        'mediaKey',
        'media_key',
      ]),
    ]);

    final cleanSourceUrl = _firstNonEmpty([
      _firstText(map, [
        'sourceUrl',
        'source_url',
        'source',
        'normalizedSource',
        'normalized_source',
        'permalink',
      ]),
      _firstText(decoded, [
        'sourceUrl',
        'source_url',
        'source',
        'normalizedSource',
        'normalized_source',
        'permalink',
      ]),
      sourceUrl,
    ]);

    final rawType = _firstNonEmpty([
      _firstText(map, ['type', 'mediaType', 'media_type']),
      _firstText(decoded, ['type', 'mediaType', 'media_type']),
    ]);

    final type = _normalizeMediaType(rawType);

    final downloadUrl = _firstNonEmpty([
      _firstText(map, ['downloadUrl', 'download_url', 'url', 'src']),
      _firstText(decoded, ['downloadUrl', 'download_url', 'url', 'src']),
    ]);

    final thumbnailUrl = _firstNonEmpty([
      _firstText(map, [
        'thumbnailUrl',
        'thumbnail_url',
        'thumb',
        'thumbnail',
        'coverUrl',
        'cover_url',
        'displayUrl',
        'display_url',
        'imageUrl',
        'image_url',
        'poster',
      ]),
      _firstText(decoded, [
        'thumbnailUrl',
        'thumbnail_url',
        'thumb',
        'thumbnail',
        'coverUrl',
        'cover_url',
        'displayUrl',
        'display_url',
        'imageUrl',
        'image_url',
        'poster',
      ]),
      type == 'photo' ? downloadUrl : null,
    ]);

    map['index'] = index;
    map['type'] = type;
    map['downloadUrl'] = downloadUrl;
    map['thumbnailUrl'] = thumbnailUrl;
    map['sourceUrl'] = cleanSourceUrl;

    _putIfEmpty(map, 'username', username);
    _putIfEmpty(map, 'fullName', fullName);
    _putIfEmpty(map, 'avatarUrl', avatarUrl);
    _putIfEmpty(map, 'shortcode', shortcode);

    return map;
  }

  List<ProfileMediaItem> _mediaResultToProfileItems(
    Map decoded, {
    required String sourceUrl,
  }) {
    final status = (decoded['status'] ?? '').toString();

    if (status == 'picker') {
      final picker = decoded['picker'];

      if (picker is! List) {
        return [];
      }

      return picker
          .whereType<Map>()
          .toList()
          .asMap()
          .entries
          .map((entry) {
            final raw = Map<dynamic, dynamic>.from(entry.value);

            final map = _mergeProfileMediaMetadata(
              raw: raw,
              decoded: decoded,
              sourceUrl: sourceUrl,
              index: entry.key,
            );

            return ProfileMediaItem.fromJson(map);
          })
          .where((item) {
            return item.downloadUrl.trim().isNotEmpty;
          })
          .toList();
    }

    final url = _firstText(decoded, [
      'downloadUrl',
      'download_url',
      'url',
      'src',
    ]);

    if (status == 'success' && url.isNotEmpty) {
      final raw = Map<dynamic, dynamic>.from(decoded);

      raw['id'] = decoded['filename'] ?? decoded['id'] ?? '0';
      raw['index'] = 0;
      raw['downloadUrl'] = url;

      final map = _mergeProfileMediaMetadata(
        raw: raw,
        decoded: decoded,
        sourceUrl: sourceUrl,
        index: 0,
      );

      return [ProfileMediaItem.fromJson(map)].where((item) {
        return item.downloadUrl.trim().isNotEmpty;
      }).toList();
    }

    return [];
  }

  Future<Uint8List> downloadProfileMediaItem({
    required String serverBaseUrl,
    required String downloadUrl,
    String? privateIgCookie,
  }) async {
    final url = downloadUrl.trim();

    if (url.isEmpty) {
      throw Exception('Media item thiếu URL tải');
    }

    final response = await http
        .get(
          Uri.parse(url),
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
                '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
            'Referer': 'https://www.instagram.com/',
          },
        )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Không tải được media item: HTTP ${response.statusCode}');
    }

    return response.bodyBytes;
  }
}
