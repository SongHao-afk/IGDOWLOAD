import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';

class ProfileStoryRepository {
  const ProfileStoryRepository();

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

  Future<List<ProfileStoryGroup>> fetchStoryGroups({
    required String serverBaseUrl,
    required String profileUrl,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse('${_apiBase(serverBaseUrl)}/profile/story-groups');

    final response = await http
        .post(
          uri,
          headers: _headers(),
          body: jsonEncode(
            _bodyWithCookie({'url': profileUrl}, privateIgCookie),
          ),
        )
        .timeout(const Duration(seconds: 60));

    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = null;
    }

    if (response.statusCode != 200 || body is! Map || body['success'] != true) {
      throw Exception(_errorMessage(body, 'Không lấy được story/highlight'));
    }

    final groups = body['groups'];

    if (groups is! List) {
      return [];
    }

    final username = (body['username'] ?? '').toString();
    final userId = (body['userId'] ?? body['user_id'] ?? '').toString();

    return groups.whereType<Map>().map((raw) {
      final map = Map<dynamic, dynamic>.from(raw);

      if (username.isNotEmpty) {
        map['username'] = username;
      }

      if (userId.isNotEmpty) {
        map['userId'] = userId;
      }

      return ProfileStoryGroup.fromJson(map);
    }).toList();
  }

  Future<List<ProfileStoryItem>> fetchStoryGroupItems({
    required String serverBaseUrl,
    required String groupId,
    required String username,
    String? userId,
    String? privateIgCookie,
  }) async {
    final uri = Uri.parse(
      '${_apiBase(serverBaseUrl)}/profile/story-group-items',
    );

    final response = await http
        .post(
          uri,
          headers: _headers(),
          body: jsonEncode(
            _bodyWithCookie({
              'groupId': groupId,
              'username': username,
            }, privateIgCookie),
          ),
        )
        .timeout(const Duration(seconds: 60));

    dynamic body;

    try {
      body = jsonDecode(response.body);
    } catch (_) {
      body = null;
    }

    if (response.statusCode != 200 || body is! Map || body['success'] != true) {
      throw Exception(_errorMessage(body, 'Không lấy được item story'));
    }

    final items = body['items'];

    if (items is! List) {
      return [];
    }

    return items.whereType<Map>().toList().asMap().entries.map((entry) {
      final map = Map<dynamic, dynamic>.from(entry.value);
      map.putIfAbsent('index', () => entry.key);
      return ProfileStoryItem.fromJson(map);
    }).toList();
  }

  Future<Uint8List> downloadStoryItem({
    required String serverBaseUrl,
    required String downloadKey,
    String? privateIgCookie,
  }) async {
    final url = downloadKey.trim();

    if (url.isEmpty) {
      throw Exception('Story item thiếu URL tải');
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
        .timeout(const Duration(seconds: 90));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Không tải được story item: HTTP ${response.statusCode}');
    }

    return response.bodyBytes;
  }
}
