import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';

class ProfileStoryRepository {
  const ProfileStoryRepository();

  Map<String, String> _headers({String? privateIgCookie}) {
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (privateIgCookie != null && privateIgCookie.trim().isNotEmpty) {
      headers['x-ig-cookie'] = privateIgCookie.trim();
    }

    return headers;
  }

  Future<List<ProfileStoryGroup>> fetchStoryGroups({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/story-groups');

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode({'profileUrl': profileUrl}),
        )
        .timeout(const Duration(seconds: 60));

    final body = jsonDecode(response.body);

    if (response.statusCode != 200 || body['success'] != true) {
      throw Exception(
        body['error'] ?? 'Không lấy được story/highlight profile',
      );
    }

    final groups = body['groups'];

    if (groups is! List) {
      return [];
    }

    return groups
        .whereType<Map<String, dynamic>>()
        .map(ProfileStoryGroup.fromJson)
        .toList();
  }

  Future<List<ProfileStoryItem>> fetchStoryGroupItems({
    required String serverBaseUrl,
    required String groupId,
    required String username,
    String? userId,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/story-group-items');

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode({
            'groupId': groupId,
            'username': username,
            if (userId != null && userId.isNotEmpty) 'userId': userId,
          }),
        )
        .timeout(const Duration(seconds: 60));

    final body = jsonDecode(response.body);

    if (response.statusCode != 200 || body['success'] != true) {
      throw Exception(body['error'] ?? 'Không lấy được item trong story group');
    }

    final items = body['items'];

    if (items is! List) {
      return [];
    }

    return items
        .whereType<Map<String, dynamic>>()
        .map(ProfileStoryItem.fromJson)
        .toList();
  }

  Future<Uint8List> downloadStoryItem({
    required String serverBaseUrl,
    required String downloadKey,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('$serverBaseUrl/profile/download-story-item');

    final response = await http
        .post(
          uri,
          headers: _headers(privateIgCookie: privateIgCookie),
          body: jsonEncode({'downloadKey': downloadKey}),
        )
        .timeout(const Duration(seconds: 90));

    if (response.statusCode != 200) {
      throw Exception(
        response.body.isNotEmpty ? response.body : 'Không tải được story item',
      );
    }

    return response.bodyBytes;
  }
}
