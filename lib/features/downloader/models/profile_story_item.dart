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

  bool get isVideo => type == 'video';

  factory ProfileStoryItem.fromJson(Map<String, dynamic> json) {
    return ProfileStoryItem(
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
      downloadKey: (json['downloadKey'] ?? '').toString(),
      sourceUrl: json['sourceUrl']?.toString(),
      takenAt: json['takenAt'] is int
          ? json['takenAt'] as int
          : int.tryParse('${json['takenAt'] ?? ''}'),
    );
  }
}
