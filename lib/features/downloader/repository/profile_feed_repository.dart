import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';

class ProfileFeedPageResult {
  final List<ProfileFeedItem> items;
  final bool hasNextPage;
  final String? nextCursor;

  const ProfileFeedPageResult({
    required this.items,
    required this.hasNextPage,
    required this.nextCursor,
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

    final hasNextPage = decoded is Map && decoded['hasNextPage'] == true;
    final rawCursor = decoded is Map ? decoded['nextCursor'] : null;
    final nextCursor = rawCursor == null ? null : rawCursor.toString();

    return ProfileFeedPageResult(
      items: items,
      hasNextPage: hasNextPage,
      nextCursor: nextCursor == null || nextCursor.trim().isEmpty
          ? null
          : nextCursor,
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
        .timeout(const Duration(seconds: 60));

    final decoded = jsonDecode(response.body);

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
        .timeout(const Duration(seconds: 60));

    final decoded = jsonDecode(response.body);

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

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode({
            'kind': kind,
            'shortcode': shortcode,
            if (url != null && url.trim().isNotEmpty) 'url': url.trim(),
          }),
        )
        .timeout(const Duration(seconds: 60));

    final decoded = jsonDecode(response.body);

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
      return [];
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
        .timeout(const Duration(seconds: 90));

    if (response.statusCode != 200) {
      throw Exception(
        response.body.isNotEmpty ? response.body : 'Không tải được media item',
      );
    }

    return response.bodyBytes;
  }
}
