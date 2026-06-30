import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FrequentProfileItem {
  final String key;
  final String userId;
  final String username;
  final String fullName;
  final String avatarUrl;
  final String profileUrl;
  final String lastVisitedAt;

  const FrequentProfileItem({
    required this.key,
    required this.userId,
    required this.username,
    required this.fullName,
    required this.avatarUrl,
    required this.profileUrl,
    required this.lastVisitedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'userId': userId,
      'username': username,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'profileUrl': profileUrl,
      'lastVisitedAt': lastVisitedAt,
    };
  }

  factory FrequentProfileItem.fromJson(Map<String, dynamic> json) {
    return FrequentProfileItem(
      key: (json['key'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      avatarUrl: (json['avatarUrl'] ?? '').toString(),
      profileUrl: (json['profileUrl'] ?? '').toString(),
      lastVisitedAt: (json['lastVisitedAt'] ?? '').toString(),
    );
  }

  FrequentProfileItem copyWith({
    String? key,
    String? userId,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? profileUrl,
    String? lastVisitedAt,
  }) {
    return FrequentProfileItem(
      key: key ?? this.key,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      profileUrl: profileUrl ?? this.profileUrl,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
    );
  }
}

class FrequentProfileRepository {
  static const String _prefsKey = 'frequent_profiles_v1';
  static const int _maxItems = 30;

  const FrequentProfileRepository();

  String _cleanUsername(String value) {
    return value.trim().replaceFirst(RegExp(r'^@+'), '').toLowerCase();
  }

  bool _isSameAccount(FrequentProfileItem a, FrequentProfileItem b) {
    final aUserId = a.userId.trim();
    final bUserId = b.userId.trim();

    if (aUserId.isNotEmpty && bUserId.isNotEmpty && aUserId == bUserId) {
      return true;
    }

    final aUsername = _cleanUsername(a.username);
    final bUsername = _cleanUsername(b.username);

    if (aUsername.isNotEmpty &&
        bUsername.isNotEmpty &&
        aUsername == bUsername) {
      return true;
    }

    return a.key.trim().isNotEmpty && a.key.trim() == b.key.trim();
  }

  List<FrequentProfileItem> _dedupe(List<FrequentProfileItem> items) {
    final result = <FrequentProfileItem>[];

    for (final item in items) {
      if (item.key.trim().isEmpty) continue;

      final exists = result.any((old) => _isSameAccount(old, item));
      if (!exists) result.add(item);
    }

    return result.take(_maxItems).toList();
  }

  Future<List<FrequentProfileItem>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);

    if (raw == null || raw.trim().isEmpty) {
      return <FrequentProfileItem>[];
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is! List) {
        return <FrequentProfileItem>[];
      }

      final items = decoded
          .whereType<Map>()
          .map(
            (x) => FrequentProfileItem.fromJson(
              Map<String, dynamic>.from(x),
            ),
          )
          .where((x) => x.key.trim().isNotEmpty)
          .toList();

      final deduped = _dedupe(items);

      if (deduped.length != items.length) {
        await prefs.setString(
          _prefsKey,
          jsonEncode(deduped.map((x) => x.toJson()).toList()),
        );
      }

      return deduped;
    } catch (_) {
      return <FrequentProfileItem>[];
    }
  }

  Future<List<FrequentProfileItem>> upsert(FrequentProfileItem item) async {
    final cleanKey = item.key.trim();
    if (cleanKey.isEmpty) return getItems();

    final prefs = await SharedPreferences.getInstance();
    final oldItems = await getItems();

    final nextItems = _dedupe(<FrequentProfileItem>[
      item.copyWith(key: cleanKey),
      ...oldItems.where((x) => !_isSameAccount(x, item)),
    ]);

    await prefs.setString(
      _prefsKey,
      jsonEncode(nextItems.map((x) => x.toJson()).toList()),
    );

    return nextItems;
  }

  Future<List<FrequentProfileItem>> removeByKey(String key) async {
    final cleanKey = key.trim();
    if (cleanKey.isEmpty) return getItems();

    final prefs = await SharedPreferences.getInstance();
    final oldItems = await getItems();
    final nextItems = oldItems.where((x) => x.key.trim() != cleanKey).toList();

    await prefs.setString(
      _prefsKey,
      jsonEncode(nextItems.map((x) => x.toJson()).toList()),
    );

    return nextItems;
  }
}
