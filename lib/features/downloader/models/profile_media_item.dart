class ProfileMediaItem {
  final String id;
  final int index;
  final String type;
  final int? width;
  final int? height;
  final num? duration;
  final String? thumbnailUrl;
  final String downloadUrl;

  const ProfileMediaItem({
    required this.id,
    required this.index,
    required this.type,
    required this.width,
    required this.height,
    required this.duration,
    required this.thumbnailUrl,
    required this.downloadUrl,
  });

  bool get isVideo => type == 'video';

  factory ProfileMediaItem.fromJson(Map<String, dynamic> json) {
    return ProfileMediaItem(
      id: (json['id'] ?? '').toString(),
      index: json['index'] is int
          ? json['index'] as int
          : int.tryParse('${json['index'] ?? 0}') ?? 0,
      type: (json['type'] ?? 'image').toString(),
      width: json['width'] is int
          ? json['width'] as int
          : int.tryParse('${json['width'] ?? ''}'),
      height: json['height'] is int
          ? json['height'] as int
          : int.tryParse('${json['height'] ?? ''}'),
      duration: json['duration'] is num ? json['duration'] as num : null,
      thumbnailUrl: json['thumbnailUrl']?.toString(),
      downloadUrl: (json['downloadUrl'] ?? '').toString(),
    );
  }
}
