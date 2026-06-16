class ProfileStoryGroup {
  final String id;
  final String kind;
  final String title;
  final String? coverUrl;
  final int? itemCount;
  final String? userId;
  final String? username;

  const ProfileStoryGroup({
    required this.id,
    required this.kind,
    required this.title,
    this.coverUrl,
    this.itemCount,
    this.userId,
    this.username,
  });

  bool get isActiveStory => kind == 'active_story';
  bool get isHighlight => kind == 'highlight';

  factory ProfileStoryGroup.fromJson(Map<String, dynamic> json) {
    return ProfileStoryGroup(
      id: (json['id'] ?? '').toString(),
      kind: (json['kind'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      coverUrl: json['coverUrl']?.toString(),
      itemCount: json['itemCount'] is int
          ? json['itemCount'] as int
          : int.tryParse('${json['itemCount'] ?? ''}'),
      userId: json['userId']?.toString(),
      username: json['username']?.toString(),
    );
  }
}
