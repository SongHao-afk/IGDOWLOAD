class IgMediaItem {
  final int id;
  final String type;
  final int? width;
  final int? height;
  final num? duration;

  final String downloadUrl;
  final String thumbnailUrl;

  // Metadata mới từ server /resolve
  final String username;
  final String fullName;
  final String avatarUrl;
  final String shortcode;
  final String sourceUrl;

  IgMediaItem({
    required this.id,
    required this.type,
    required this.downloadUrl,
    String? thumbnailUrl,
    this.width,
    this.height,
    this.duration,
    this.username = '',
    this.fullName = '',
    this.avatarUrl = '',
    this.shortcode = '',
    this.sourceUrl = '',
  }) : thumbnailUrl = thumbnailUrl ?? '';

  bool get isVideo {
    final cleanType = type.trim().toLowerCase();

    return cleanType == 'video' || cleanType == 'reel' || cleanType == 'mp4';
  }

  bool get isImage {
    final cleanType = type.trim().toLowerCase();

    return cleanType == 'image' ||
        cleanType == 'photo' ||
        cleanType == 'jpg' ||
        cleanType == 'jpeg' ||
        cleanType == 'png' ||
        cleanType == 'webp';
  }

  // Giữ lại cho media_card.dart cũ không bị lỗi.
  // Ưu tiên thumbnailUrl. Nếu là ảnh mà không có thumb thì lấy downloadUrl.
  // Video không có thumbnail thì trả rỗng, không cố lấy mp4 làm ảnh. Không phải phù thủy.
  String get previewUrl {
    final thumb = thumbnailUrl.trim();

    if (thumb.isNotEmpty) {
      return thumb;
    }

    if (isImage) {
      return downloadUrl.trim();
    }

    return '';
  }

  factory IgMediaItem.fromJson(dynamic json) {
    final map = json is Map
        ? Map<String, dynamic>.from(json)
        : <String, dynamic>{};

    final type = _readString(map, ['type', 'mediaType', 'media_type']);

    final downloadUrl = _readString(map, [
      'downloadUrl',
      'download_url',
      'url',
      'src',
    ]);

    final rawThumbnailUrl = _readString(map, [
      'thumbnailUrl',
      'thumbnail_url',
      'thumbnail',
      'coverUrl',
      'cover_url',
      'displayUrl',
      'display_url',
      'imageUrl',
      'image_url',
      'poster',
    ]);

    final cleanType = type.trim().toLowerCase();

    final thumbnailUrl = rawThumbnailUrl.isNotEmpty
        ? rawThumbnailUrl
        : (cleanType == 'image' || cleanType == 'photo')
        ? downloadUrl
        : '';

    return IgMediaItem(
      id: _readInt(map, ['id', 'index']) ?? 0,
      type: type.isEmpty ? 'image' : type,
      width: _readInt(map, ['width', 'w']),
      height: _readInt(map, ['height', 'h']),
      duration: _readNum(map, ['duration']),
      downloadUrl: downloadUrl,
      thumbnailUrl: thumbnailUrl,

      // Metadata mới
      username: _readString(map, [
        'username',
        'ownerUsername',
        'owner_username',
        'userName',
        'user_name',
      ]),
      fullName: _readString(map, [
        'fullName',
        'full_name',
        'ownerFullName',
        'owner_full_name',
        'name',
      ]),
      avatarUrl: _readString(map, [
        'avatarUrl',
        'avatar_url',
        'profilePicUrl',
        'profile_pic_url',
        'profilePicUrlHd',
        'profile_pic_url_hd',
        'ownerAvatarUrl',
        'owner_avatar_url',
      ]),
      shortcode: _readString(map, [
        'shortcode',
        'shortCode',
        'code',
        'mediaKey',
        'media_key',
      ]),
      sourceUrl: _readString(map, [
        'sourceUrl',
        'source_url',
        'source',
        'normalizedSource',
        'normalized_source',
        'permalink',
      ]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'width': width,
      'height': height,
      'duration': duration,
      'downloadUrl': downloadUrl,
      'thumbnailUrl': thumbnailUrl,
      'username': username,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'shortcode': shortcode,
      'sourceUrl': sourceUrl,
    };
  }

  IgMediaItem copyWith({
    int? id,
    String? type,
    int? width,
    int? height,
    num? duration,
    String? downloadUrl,
    String? thumbnailUrl,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? shortcode,
    String? sourceUrl,
  }) {
    return IgMediaItem(
      id: id ?? this.id,
      type: type ?? this.type,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      shortcode: shortcode ?? this.shortcode,
      sourceUrl: sourceUrl ?? this.sourceUrl,
    );
  }

  static String _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];

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

  static int? _readInt(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];

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

  static num? _readNum(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];

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
