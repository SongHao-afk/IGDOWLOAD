class ProfileMediaItem {
  final String id;
  final int index;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String? thumbnailUrl;
  final String downloadUrl;

  final String username;
  final String fullName;
  final String avatarUrl;
  final String shortcode;
  final String sourceUrl;

  const ProfileMediaItem({
    required this.id,
    required this.index,
    required this.type,
    required this.width,
    required this.height,
    required this.duration,
    required this.thumbnailUrl,
    required this.downloadUrl,
    this.username = '',
    this.fullName = '',
    this.avatarUrl = '',
    this.shortcode = '',
    this.sourceUrl = '',
  });

  bool get isVideo => type.trim().toLowerCase() == 'video';
  bool get isPhoto => !isVideo;

  ProfileMediaItem copyWith({
    String? id,
    int? index,
    String? type,
    int? width,
    int? height,
    num? duration,
    String? thumbnailUrl,
    String? downloadUrl,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? shortcode,
    String? sourceUrl,
  }) {
    return ProfileMediaItem(
      id: id ?? this.id,
      index: index ?? this.index,
      type: type ?? this.type,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      shortcode: shortcode ?? this.shortcode,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  factory ProfileMediaItem.fromJson(Map json) {
    final index = _int(json, ['index']) ?? 0;

    final url = _text(json, ['downloadUrl', 'download_url', 'url', 'src']);

    final type = _normalizeType(
      _text(json, ['type', 'mediaType', 'media_type']),
    );

    final rawThumb = _nullableText(json, [
      'thumbnailUrl',
      'thumbnail_url',
      'thumb',
      'thumbnail',
      'coverUrl',
      'cover_url',
      'displayUrl',
      'display_url',
      'imageUrl',
      'image_url',
      'poster',
    ]);

    final thumbnailUrl =
        rawThumb ?? (type == 'photo' && url.isNotEmpty ? url : null);

    final id = _text(json, ['id', 'pk', 'mediaId', 'media_id']);

    return ProfileMediaItem(
      id: id.isEmpty ? index.toString() : id,
      index: index,
      type: type,
      width: _int(json, ['width', 'w']),
      height: _int(json, ['height', 'h']),
      duration: _num(json, ['duration', 'videoDuration', 'video_duration']),
      thumbnailUrl: thumbnailUrl,
      downloadUrl: url,
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
      shortcode: _text(json, [
        'shortcode',
        'shortCode',
        'code',
        'mediaKey',
        'media_key',
      ]),
      sourceUrl: _text(json, [
        'sourceUrl',
        'source_url',
        'source',
        'normalizedSource',
        'normalized_source',
        'permalink',
      ]),
    );
  }

  static String _normalizeType(String value) {
    final clean = value.trim().toLowerCase();

    if (clean == '2' ||
        clean == 'video' ||
        clean == 'reel' ||
        clean == 'clips') {
      return 'video';
    }

    return 'photo';
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

  static num? _num(Map json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];

      if (value == null) {
        continue;
      }

      if (value is num) {
        return value;
      }

      final parsed = num.tryParse(value.toString());

      if (parsed != null) {
        return parsed;
      }
    }

    return null;
  }
}
