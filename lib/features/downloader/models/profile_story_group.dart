class ProfileStoryGroup {
  final String id;
  final String kind;
  final String title;
  final String? coverUrl;
  final int? itemCount;
  final String? userId;
  final String? username;

  const ProfileStoryGroup({
    required this.id,
    required this.kind,
    required this.title,
    this.coverUrl,
    this.itemCount,
    this.userId,
    this.username,
  });

  bool get isActiveStory => kind == 'active_story';
  bool get isHighlight => kind == 'highlight';

  factory ProfileStoryGroup.fromJson(Map json) {
    return ProfileStoryGroup(
      id: _text(json, ['groupId', 'group_id', 'id']),
      kind: _text(json, ['kind']),
      title: _text(json, ['title']).isEmpty ? 'Story' : _text(json, ['title']),
      coverUrl: _nullableText(json, ['coverUrl', 'cover_url', 'thumb']),
      itemCount: _int(json, ['itemCount', 'item_count', 'mediaCount']),
      userId: _nullableText(json, ['userId', 'user_id']),
      username: _nullableText(json, ['username']),
    );
  }

  static String _text(Map json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];

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

  static String? _nullableText(Map json, List<String> keys) {
    final value = _text(json, keys);
    return value.isEmpty ? null : value;
  }

  static int? _int(Map json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];

      if (value == null) {
        continue;
      }

      if (value is int) {
        return value;
      }

      if (value is num) {
        return value.toInt();
      }

      final parsed = int.tryParse(value.toString());

      if (parsed != null) {
        return parsed;
      }
    }

    return null;
  }
}
