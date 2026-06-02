class IgMediaItem {
  final int id;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String downloadUrl;

  IgMediaItem({
    required this.id,
    required this.type,
    required this.downloadUrl,
    this.width,
    this.height,
    this.duration,
  });

  bool get isVideo => type == 'video';

  factory IgMediaItem.fromJson(Map<String, dynamic> json) {
    return IgMediaItem(
      id: json['id'] ?? 0,
      type: json['type'] ?? 'image',
      width: json['width'],
      height: json['height'],
      duration: json['duration'],
      downloadUrl: json['downloadUrl'] ?? '',
    );
  }
}
