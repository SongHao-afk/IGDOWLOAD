import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';

class ProfileFeedPageResult {
  final List<ProfileFeedItem> items;
  final bool hasNextPage;
  final String? nextCursor;

  // Server trả:
  // profile: {
  //   username,
  //   userId,
  //   fullName,
  //   avatarUrl,
  //   isPrivate,
  //   isVerified
  // }
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

  Map<String, String> _headers({String? privateIgCookie}) {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (privateIgCookie != null && privateIgCookie.trim().isNotEmpty) {
      headers['x-ig-cookie'] = privateIgCookie.trim();
    }

    return headers;
  }

  ProfileFeedPageResult _parseFeedPage(dynamic decoded) {
    final rawItems = decoded is Map ? decoded['items'] : null;

    final items = rawItems is List
        ? rawItems
              .whereType<Map>()
              .map(
                (x) => ProfileFeedItem.fromJson(Map<String, dynamic>.from(x)),
              )
              .toList()
        : <ProfileFeedItem>[];

    bool hasNextPage = false;

    if (decoded is Map) {
      hasNextPage =
          decoded['hasNextPage'] == true ||
          decoded['has_next_page'] == true ||
          decoded['moreAvailable'] == true ||
          decoded['more_available'] == true ||
          decoded['hasMore'] == true ||
          decoded['has_more'] == true;
    }

    final rawCursor = decoded is Map
        ? decoded['nextCursor'] ??
              decoded['next_cursor'] ??
              decoded['nextMaxId'] ??
              decoded['next_max_id'] ??
              decoded['maxId'] ??
              decoded['max_id']
        : null;

    final nextCursor = rawCursor == null ? null : rawCursor.toString().trim();

    final rawProfile = decoded is Map ? decoded['profile'] : null;

    return ProfileFeedPageResult(
      items: items,
      hasNextPage: hasNextPage && nextCursor != null && nextCursor.isNotEmpty,
      nextCursor: nextCursor == null || nextCursor.isEmpty ? null : nextCursor,
      profile: rawProfile is Map ? Map<String, dynamic>.from(rawProfile) : null,
    );
  }

  Future<ProfileFeedPageResult> fetchProfileReels({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
    int limit = 30,
    String? cursor,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/reels');

    final body = <String, dynamic>{'profileUrl': profileUrl, 'limit': limit};

    if (cursor != null && cursor.trim().isNotEmpty) {
      body['cursor'] = cursor.trim();
    }

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode(body),
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
      throw Exception(
        decoded is Map
            ? decoded['error'] ?? 'Không lấy được reels'
            : 'Không lấy được reels',
      );
    }

    return _parseFeedPage(decoded);
  }

  Future<ProfileFeedPageResult> fetchProfilePosts({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
    int limit = 30,
    String? cursor,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/posts');

    final body = <String, dynamic>{'profileUrl': profileUrl, 'limit': limit};

    if (cursor != null && cursor.trim().isNotEmpty) {
      body['cursor'] = cursor.trim();
    }

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode(body),
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
      throw Exception(
        decoded is Map
            ? decoded['error'] ?? 'Không lấy được ảnh/bài viết'
            : 'Không lấy được ảnh/bài viết',
      );
    }

    return _parseFeedPage(decoded);
  }

  Future<List<ProfileMediaItem>> fetchProfileMediaItems({
    required String serverBaseUrl,
    required String kind,
    required String shortcode,
    String? url,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/media-items');

    final body = <String, dynamic>{
      'kind': kind,
      'shortcode': shortcode,
      if (url != null && url.trim().isNotEmpty) 'url': url.trim(),
    };

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode(body),
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
      throw Exception(
        decoded is Map
            ? decoded['error'] ?? 'Không lấy được media item'
            : 'Không lấy được media item',
      );
    }

    final items = decoded['items'];

    if (items is! List) {
      return <ProfileMediaItem>[];
    }

    return items
        .whereType<Map>()
        .map((x) => ProfileMediaItem.fromJson(Map<String, dynamic>.from(x)))
        .toList();
  }

  Future<Uint8List> downloadProfileMediaItem({
    required String serverBaseUrl,
    required String downloadUrl,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/download-media-item');

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode({'downloadUrl': downloadUrl}),
        )
        .timeout(const Duration(seconds: 120));

    if (response.statusCode != 200) {
      throw Exception(
        response.body.isNotEmpty ? response.body : 'Không tải được media item',
      );
    }

    return response.bodyBytes;
  }
}
