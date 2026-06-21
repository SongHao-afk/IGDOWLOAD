class ProfileStoryGroup {
  final String id;
  final String kind;
  final String title;
  final String? coverUrl;
  final int? itemCount;
  final String? userId;
  final String? username;
  final String? fullName;
  final String? avatarUrl;

  const ProfileStoryGroup({
    required this.id,
    required this.kind,
    required this.title,
    this.coverUrl,
    this.itemCount,
    this.userId,
    this.username,
    this.fullName,
    this.avatarUrl,
  });

  bool get isActiveStory => kind == 'active_story';
  bool get isHighlight => kind == 'highlight';

  factory ProfileStoryGroup.fromJson(Map json) {
    return ProfileStoryGroup(
      id: _text(json, ['groupId', 'group_id', 'id', 'pk']),
      kind: _text(json, ['kind']).isEmpty ? 'highlight' : _text(json, ['kind']),
      title:
          _text(json, [
            'title',
            'name',
            'highlightTitle',
            'highlight_title',
          ]).isEmpty
          ? 'Story'
          : _text(json, ['title', 'name', 'highlightTitle', 'highlight_title']),
      coverUrl: _nullableText(json, [
        'coverUrl',
        'cover_url',
        'thumb',
        'thumbnail',
        'thumbnailUrl',
        'thumbnail_url',
        'imageUrl',
        'image_url',
        'displayUrl',
        'display_url',
      ]),
      itemCount: _int(json, [
        'itemCount',
        'item_count',
        'mediaCount',
        'media_count',
      ]),
      userId: _nullableText(json, ['userId', 'user_id', 'ownerId', 'owner_id']),
      username: _nullableText(json, [
        'username',
        'userName',
        'user_name',
        'ownerUsername',
        'owner_username',
      ]),
      fullName: _nullableText(json, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      avatarUrl: _nullableText(json, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
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
