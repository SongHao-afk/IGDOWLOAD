class ProfileStoryItem {
  final String id;
  final int index;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String? thumbnailUrl;
  final String downloadUrl;
  final String downloadKey;
  final String? sourceUrl;
  final int? takenAt;

  const ProfileStoryItem({
    required this.id,
    required this.index,
    required this.type,
    this.width,
    this.height,
    this.duration,
    this.thumbnailUrl,
    required this.downloadUrl,
    required this.downloadKey,
    this.sourceUrl,
    this.takenAt,
  });

  bool get isVideo => type.trim().toLowerCase() == 'video';

  factory ProfileStoryItem.fromJson(Map json) {
    final url = _text(json, ['downloadUrl', 'download_url', 'url']);
    final id = _text(json, ['id']);
    final index = _int(json, ['index']) ?? 0;

    return ProfileStoryItem(
      id: id.isEmpty ? index.toString() : id,
      index: index,
      type: _text(json, ['type']).isEmpty ? 'photo' : _text(json, ['type']),
      width: _int(json, ['width', 'w']),
      height: _int(json, ['height', 'h']),
      duration: _num(json, ['duration']),
      thumbnailUrl: _nullableText(json, [
        'thumbnailUrl',
        'thumbnail_url',
        'thumb',
      ]),
      downloadUrl: url,
      downloadKey: _text(json, ['downloadKey', 'download_key']).isNotEmpty
          ? _text(json, ['downloadKey', 'download_key'])
          : url,
      sourceUrl: _nullableText(json, ['sourceUrl', 'source_url']),
      takenAt: _int(json, ['takenAt', 'taken_at']),
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
