class IgMediaItem {
  final int id;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String downloadUrl;
  final String? thumbnailUrl;

  IgMediaItem({
    required this.id,
    required this.type,
    required this.downloadUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.duration,
  });

  bool get isVideo => type.toLowerCase() == 'video';

  String get previewUrl {
    final thumb = thumbnailUrl?.trim();

    if (thumb != null && thumb.isNotEmpty) {
      return thumb;
    }

    return downloadUrl;
  }

  factory IgMediaItem.fromJson(Map<String, dynamic> json) {
    return IgMediaItem(
      id: json['id'] ?? 0,
      type: json['type']?.toString() ?? 'image',
      width: json['width'],
      height: json['height'],
      duration: json['duration'],
      downloadUrl: json['downloadUrl']?.toString() ?? '',
      thumbnailUrl: json['thumbnailUrl']?.toString(),
    );
  }
}
