import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DownloadHistoryItem {
  final String key;

  // Instagram profile info
  final String username;
  final String fullName;
  final String avatarUrl;

  // Media/source info
  final String shortcode;
  final String type; // image / video / reel / post
  final String sourceUrl;
  final String thumbnailUrl;
  final String downloadUrl;

  // Local/save info
  final String filename;
  final String savedAt;

  const DownloadHistoryItem({
    required this.key,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    required this.shortcode,
    required this.type,
    required this.sourceUrl,
    required this.thumbnailUrl,
    required this.downloadUrl,
    required this.filename,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'username': username,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'shortcode': shortcode,
      'type': type,
      'sourceUrl': sourceUrl,
      'thumbnailUrl': thumbnailUrl,
      'downloadUrl': downloadUrl,
      'filename': filename,
      'savedAt': savedAt,
    };
  }

  factory DownloadHistoryItem.fromJson(Map<String, dynamic> json) {
    return DownloadHistoryItem(
      key: (json['key'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      avatarUrl: (json['avatarUrl'] ?? '').toString(),
      shortcode: (json['shortcode'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      sourceUrl: (json['sourceUrl'] ?? '').toString(),
      thumbnailUrl: (json['thumbnailUrl'] ?? '').toString(),
      downloadUrl: (json['downloadUrl'] ?? '').toString(),
      filename: (json['filename'] ?? '').toString(),
      savedAt: (json['savedAt'] ?? '').toString(),
    );
  }

  DownloadHistoryItem copyWith({
    String? key,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? shortcode,
    String? type,
    String? sourceUrl,
    String? thumbnailUrl,
    String? downloadUrl,
    String? filename,
    String? savedAt,
  }) {
    return DownloadHistoryItem(
      key: key ?? this.key,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      shortcode: shortcode ?? this.shortcode,
      type: type ?? this.type,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      filename: filename ?? this.filename,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}

class DownloadHistoryRepository {
  static const String _prefsKey = 'download_history_items_v1';

  // Giữ 300 item gần nhất là đủ vui rồi.
  // Không cần biến SharedPreferences thành nghĩa địa dữ liệu.
  static const int _maxItems = 300;

  const DownloadHistoryRepository();

  String buildKeyFromDownloadUrl(String downloadUrl) {
    return downloadUrl.trim();
  }

  Future<List<DownloadHistoryItem>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);

    if (raw == null || raw.trim().isEmpty) {
      return <DownloadHistoryItem>[];
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is! List) {
        return <DownloadHistoryItem>[];
      }

      return decoded
          .whereType<Map>()
          .map(
            (x) => DownloadHistoryItem.fromJson(Map<String, dynamic>.from(x)),
          )
          .where((x) => x.key.trim().isNotEmpty)
          .toList();
    } catch (_) {
      return <DownloadHistoryItem>[];
    }
  }

  Future<Set<String>> getDownloadedKeys() async {
    final items = await getItems();

    return items.map((x) => x.key.trim()).where((x) => x.isNotEmpty).toSet();
  }

  Future<bool> containsKey(String key) async {
    final cleanKey = key.trim();

    if (cleanKey.isEmpty) {
      return false;
    }

    final keys = await getDownloadedKeys();

    return keys.contains(cleanKey);
  }

  Future<void> addItem(DownloadHistoryItem item) async {
    final cleanKey = item.key.trim();

    if (cleanKey.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final oldItems = await getItems();

    // Item mới đưa lên đầu.
    // Nếu đã tồn tại thì xóa bản cũ, tránh trùng.
    final nextItems = <DownloadHistoryItem>[
      item.copyWith(key: cleanKey),
      ...oldItems.where((x) => x.key.trim() != cleanKey),
    ];

    final limitedItems = nextItems.take(_maxItems).toList();

    final raw = jsonEncode(limitedItems.map((x) => x.toJson()).toList());

    await prefs.setString(_prefsKey, raw);
  }

  Future<void> removeByKey(String key) async {
    final cleanKey = key.trim();

    if (cleanKey.isEmpty) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final oldItems = await getItems();

    final nextItems = oldItems.where((x) => x.key.trim() != cleanKey).toList();

    final raw = jsonEncode(nextItems.map((x) => x.toJson()).toList());

    await prefs.setString(_prefsKey, raw);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}
