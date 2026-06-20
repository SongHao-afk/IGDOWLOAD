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

  ProfileFeedPageResult _parseFeedPage(
    dynamic decoded, {
    required String kind,
  }) {
    final rawItems = decoded is Map ? decoded['items'] : null;

    final items = rawItems is List
        ? rawItems.whereType<Map>().toList().asMap().entries.map((entry) {
            final map = Map<dynamic, dynamic>.from(entry.value);

            map.putIfAbsent('index', () => entry.key);
            map['kind'] = kind;

            if (map['type'] == null && map['mediaType'] != null) {
              map['type'] = map['mediaType'];
            }

            return ProfileFeedItem.fromJson(map);
          }).toList()
        : <ProfileFeedItem>[];

    final rawCursor = decoded is Map
        ? decoded['nextCursor'] ??
              decoded['next_cursor'] ??
              decoded['nextMaxId'] ??
              decoded['next_max_id'] ??
              decoded['maxId'] ??
              decoded['max_id']
        : null;

    final nextCursor = rawCursor?.toString().trim();

    final rawProfile = decoded is Map ? decoded['profile'] : null;

    final profile = rawProfile is Map
        ? Map<String, dynamic>.from(rawProfile)
        : decoded is Map
        ? <String, dynamic>{
            'username': decoded['username'] ?? '',
            'userId': decoded['userId'] ?? decoded['user_id'] ?? '',
            'fullName': '',
            'avatarUrl': '',
          }
        : null;

    return ProfileFeedPageResult(
      items: items,
      hasNextPage: nextCursor != null && nextCursor.isNotEmpty,
      nextCursor: nextCursor == null || nextCursor.isEmpty ? null : nextCursor,
      profile: profile,
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

    return _parseFeedPage(decoded, kind: 'reel');
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

    return _parseFeedPage(decoded, kind: 'post');
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

    return _mediaResultToProfileItems(decoded);
  }

  List<ProfileMediaItem> _mediaResultToProfileItems(Map decoded) {
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
            final map = Map<dynamic, dynamic>.from(entry.value);

            map['index'] = entry.key;
            map['downloadUrl'] = map['url'];
            map['thumbnailUrl'] = map['thumb'];

            return ProfileMediaItem.fromJson(map);
          })
          .where((item) {
            return item.downloadUrl.trim().isNotEmpty;
          })
          .toList();
    }

    final url = (decoded['url'] ?? '').toString().trim();

    if (status == 'success' && url.isNotEmpty) {
      return [
        ProfileMediaItem.fromJson({
          'id': decoded['filename'] ?? '0',
          'index': 0,
          'type': decoded['media_type'] ?? decoded['mediaType'] ?? 'photo',
          'downloadUrl': url,
          'thumbnailUrl': decoded['thumb'],
        }),
      ];
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
