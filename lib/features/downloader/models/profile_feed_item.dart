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

  bool get isVideo => isReel || type == 'video';

  bool get isCarousel => type == 'carousel';

  factory ProfileFeedItem.fromJson(Map<String, dynamic> json) {
    return ProfileFeedItem(
      id: (json['id'] ?? '').toString(),
      index: json['index'] is int
          ? json['index'] as int
          : int.tryParse('${json['index'] ?? 0}') ?? 0,
      kind: (json['kind'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      shortcode: (json['shortcode'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
      coverUrl: json['coverUrl']?.toString(),
      caption: (json['caption'] ?? '').toString(),
      takenAt: json['takenAt'] is int
          ? json['takenAt'] as int
          : int.tryParse('${json['takenAt'] ?? ''}'),
      itemCount: json['itemCount'] is int
          ? json['itemCount'] as int
          : int.tryParse('${json['itemCount'] ?? 1}') ?? 1,
      likeCount: json['likeCount'] is int
          ? json['likeCount'] as int
          : int.tryParse('${json['likeCount'] ?? ''}'),
      commentCount: json['commentCount'] is int
          ? json['commentCount'] as int
          : int.tryParse('${json['commentCount'] ?? ''}'),
      viewCount: json['viewCount'] is int
          ? json['viewCount'] as int
          : int.tryParse('${json['viewCount'] ?? ''}'),
    );
  }
}
