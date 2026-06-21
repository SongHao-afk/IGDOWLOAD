class ProfileFeedItem {
  final String id;
  final int index;
  final String kind;
  final String type;
  final String shortcode;
  final String url;
  final String? coverUrl;

  final String username;
  final String fullName;
  final String avatarUrl;

  final String caption;
  final int? takenAt;
  final int itemCount;
  final int? likeCount;
  final int? commentCount;
  final int? viewCount;

  const ProfileFeedItem({
    required this.id,
    required this.index,
    required this.kind,
    required this.type,
    required this.shortcode,
    required this.url,
    required this.coverUrl,
    this.username = '',
    this.fullName = '',
    this.avatarUrl = '',
    required this.caption,
    required this.takenAt,
    required this.itemCount,
    required this.likeCount,
    required this.commentCount,
    required this.viewCount,
  });

  bool get isReel => kind == 'reel';
  bool get isPost => kind == 'post';
  bool get isVideo => isReel || type == 'video' || type == 'reel';
  bool get isCarousel => type == 'carousel';

  factory ProfileFeedItem.fromJson(Map json) {
    final rawKind = _text(json, ['kind']);

    final kind = rawKind.isNotEmpty
        ? rawKind
        : _kindFromType(_text(json, ['mediaType', 'media_type', 'type']));

    final rawType = _text(json, ['type']);

    final type = rawType.isNotEmpty
        ? rawType
        : _text(json, ['mediaType', 'media_type']);

    return ProfileFeedItem(
      id: _text(json, ['id', 'pk']),
      index: _int(json, ['index']) ?? 0,
      kind: kind,
      type: type,
      shortcode: _text(json, ['shortcode', 'shortCode', 'code']),
      url: _text(json, ['url', 'permalink']),
      coverUrl: _nullableText(json, [
        'coverUrl',
        'cover_url',
        'thumbnailUrl',
        'thumbnail_url',
        'thumb',
        'thumbnail',
        'displayUrl',
        'display_url',
        'imageUrl',
        'image_url',
      ]),
      username: _text(json, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
      fullName: _text(json, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      avatarUrl: _text(json, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
      caption: _text(json, ['caption']),
      takenAt: _int(json, ['takenAt', 'taken_at']),
      itemCount: _int(json, ['itemCount', 'item_count']) ?? 1,
      likeCount: _int(json, ['likeCount', 'like_count']),
      commentCount: _int(json, ['commentCount', 'comment_count']),
      viewCount: _int(json, ['viewCount', 'view_count', 'play_count']),
    );
  }

  static String _kindFromType(String value) {
    final clean = value.trim().toLowerCase();

    if (clean == 'reel' || clean == 'profile_reels') {
      return 'reel';
    }

    return 'post';
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
