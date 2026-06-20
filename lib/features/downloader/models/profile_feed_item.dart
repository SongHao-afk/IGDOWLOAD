class ProfileFeedItem {
  final String id;
  final int index;
  final String kind;
  final String type;
  final String shortcode;
  final String url;
  final String? coverUrl;
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
    final kind = _text(json, ['kind']).isNotEmpty
        ? _text(json, ['kind'])
        : _kindFromType(_text(json, ['mediaType', 'media_type', 'type']));

    final type = _text(json, ['type']).isNotEmpty
        ? _text(json, ['type'])
        : _text(json, ['mediaType', 'media_type']);

    return ProfileFeedItem(
      id: _text(json, ['id']),
      index: _int(json, ['index']) ?? 0,
      kind: kind,
      type: type,
      shortcode: _text(json, ['shortcode', 'code']),
      url: _text(json, ['url', 'permalink']),
      coverUrl: _nullableText(json, [
        'coverUrl',
        'cover_url',
        'thumbnailUrl',
        'thumbnail_url',
        'thumb',
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
