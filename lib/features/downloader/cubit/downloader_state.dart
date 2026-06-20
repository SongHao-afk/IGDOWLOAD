import '../../../core/constants/app_constants.dart';
import '../models/ig_media_item.dart';
import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';
import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';
import '../repository/download_history_repository.dart';

class DownloaderState {
  final String serverBaseUrl;
  final String status;
  final bool loading;
  final List<IgMediaItem> media;

  final Set<int> downloadingIds;
  final Map<int, String> downloadErrors;
  final bool downloadingAll;

  final bool privateMode;
  final String? privateIgCookie;
  final bool sessionBusy;

  // =========================
  // DOWNLOAD HISTORY
  // =========================

  final List<DownloadHistoryItem> downloadHistory;

  final Set<String> downloadedProfileMediaKeys;

  // =========================
  // PROFILE COMMON
  // =========================

  // '', 'stories', 'reels', 'posts'
  final String profileMode;

  final String profileUrl;
  final String? profileError;

  final String profileUsername;
  final String profileFullName;
  final String profileAvatarUrl;

  // =========================
  // PROFILE STORY / HIGHLIGHT
  // =========================

  final bool profileGroupsLoading;
  final bool profileItemsLoading;
  final List<ProfileStoryGroup> profileGroups;
  final ProfileStoryGroup? selectedProfileGroup;
  final List<ProfileStoryItem> profileItems;
  final Set<String> downloadingProfileKeys;

  // =========================
  // PROFILE REELS / POSTS
  // =========================

  final bool profileFeedLoading;
  final bool profileFeedLoadingMore;
  final bool profileFeedHasNextPage;
  final String? profileFeedNextCursor;

  final List<ProfileFeedItem> profileFeedItems;
  final ProfileFeedItem? selectedProfileFeedItem;

  final bool profileMediaLoading;
  final List<ProfileMediaItem> profileMediaItems;
  final Set<String> downloadingProfileMediaUrls;

  const DownloaderState({
    required this.serverBaseUrl,
    required this.status,
    required this.loading,
    required this.media,
    required this.downloadingIds,
    required this.downloadErrors,
    required this.downloadingAll,
    required this.privateMode,
    required this.privateIgCookie,
    required this.sessionBusy,
    required this.downloadHistory,
    required this.downloadedProfileMediaKeys,
    required this.profileMode,
    required this.profileUrl,
    required this.profileError,
    required this.profileUsername,
    required this.profileFullName,
    required this.profileAvatarUrl,
    required this.profileGroupsLoading,
    required this.profileItemsLoading,
    required this.profileGroups,
    required this.selectedProfileGroup,
    required this.profileItems,
    required this.downloadingProfileKeys,
    required this.profileFeedLoading,
    required this.profileFeedLoadingMore,
    required this.profileFeedHasNextPage,
    required this.profileFeedNextCursor,
    required this.profileFeedItems,
    required this.selectedProfileFeedItem,
    required this.profileMediaLoading,
    required this.profileMediaItems,
    required this.downloadingProfileMediaUrls,
  });

  factory DownloaderState.initial() {
    return const DownloaderState(
      serverBaseUrl: AppConstants.defaultServerBaseUrl,
      status: '',
      loading: false,
      media: <IgMediaItem>[],
      downloadingIds: <int>{},
      downloadErrors: <int, String>{},
      downloadingAll: false,
      privateMode: false,
      privateIgCookie: null,
      sessionBusy: false,
      downloadHistory: <DownloadHistoryItem>[],
      downloadedProfileMediaKeys: <String>{},
      profileMode: '',
      profileUrl: '',
      profileError: null,
      profileUsername: '',
      profileFullName: '',
      profileAvatarUrl: '',
      profileGroupsLoading: false,
      profileItemsLoading: false,
      profileGroups: <ProfileStoryGroup>[],
      selectedProfileGroup: null,
      profileItems: <ProfileStoryItem>[],
      downloadingProfileKeys: <String>{},
      profileFeedLoading: false,
      profileFeedLoadingMore: false,
      profileFeedHasNextPage: false,
      profileFeedNextCursor: null,
      profileFeedItems: <ProfileFeedItem>[],
      selectedProfileFeedItem: null,
      profileMediaLoading: false,
      profileMediaItems: <ProfileMediaItem>[],
      downloadingProfileMediaUrls: <String>{},
    );
  }

  bool get isAnyDownloading {
    return downloadingIds.isNotEmpty ||
        downloadingProfileKeys.isNotEmpty ||
        downloadingProfileMediaUrls.isNotEmpty ||
        downloadingAll;
  }

  bool get hasPrivateCookie {
    return privateIgCookie != null && privateIgCookie!.trim().isNotEmpty;
  }

  String? get activeIgCookie {
    if (privateMode && hasPrivateCookie) {
      return privateIgCookie;
    }

    return null;
  }

  bool get hasProfileIdentity {
    return profileUsername.trim().isNotEmpty ||
        profileFullName.trim().isNotEmpty ||
        profileAvatarUrl.trim().isNotEmpty;
  }

  DownloaderState copyWith({
    String? serverBaseUrl,
    String? status,
    bool? loading,
    List<IgMediaItem>? media,
    Set<int>? downloadingIds,
    Map<int, String>? downloadErrors,
    bool? downloadingAll,
    bool? privateMode,
    String? privateIgCookie,
    bool clearPrivateIgCookie = false,
    bool? sessionBusy,

    // Download history
    List<DownloadHistoryItem>? downloadHistory,
    Set<String>? downloadedProfileMediaKeys,

    // Profile common
    String? profileMode,
    String? profileUrl,
    String? profileError,
    bool clearProfileError = false,
    String? profileUsername,
    String? profileFullName,
    String? profileAvatarUrl,
    bool clearProfileIdentity = false,

    // Profile story/highlight
    bool? profileGroupsLoading,
    bool? profileItemsLoading,
    List<ProfileStoryGroup>? profileGroups,
    ProfileStoryGroup? selectedProfileGroup,
    bool clearSelectedProfileGroup = false,
    List<ProfileStoryItem>? profileItems,
    Set<String>? downloadingProfileKeys,

    // Profile reels/posts
    bool? profileFeedLoading,
    bool? profileFeedLoadingMore,
    bool? profileFeedHasNextPage,
    String? profileFeedNextCursor,
    bool clearProfileFeedNextCursor = false,
    List<ProfileFeedItem>? profileFeedItems,
    ProfileFeedItem? selectedProfileFeedItem,
    bool clearSelectedProfileFeedItem = false,

    bool? profileMediaLoading,
    List<ProfileMediaItem>? profileMediaItems,
    Set<String>? downloadingProfileMediaUrls,
  }) {
    return DownloaderState(
      serverBaseUrl: serverBaseUrl ?? this.serverBaseUrl,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      media: media ?? this.media,
      downloadingIds: downloadingIds ?? this.downloadingIds,
      downloadErrors: downloadErrors ?? this.downloadErrors,
      downloadingAll: downloadingAll ?? this.downloadingAll,
      privateMode: privateMode ?? this.privateMode,
      privateIgCookie: clearPrivateIgCookie
          ? null
          : privateIgCookie ?? this.privateIgCookie,
      sessionBusy: sessionBusy ?? this.sessionBusy,
      downloadHistory: downloadHistory ?? this.downloadHistory,
      downloadedProfileMediaKeys:
          downloadedProfileMediaKeys ?? this.downloadedProfileMediaKeys,
      profileMode: profileMode ?? this.profileMode,
      profileUrl: profileUrl ?? this.profileUrl,
      profileError: clearProfileError
          ? null
          : profileError ?? this.profileError,
      profileUsername: clearProfileIdentity
          ? ''
          : profileUsername ?? this.profileUsername,
      profileFullName: clearProfileIdentity
          ? ''
          : profileFullName ?? this.profileFullName,
      profileAvatarUrl: clearProfileIdentity
          ? ''
          : profileAvatarUrl ?? this.profileAvatarUrl,
      profileGroupsLoading: profileGroupsLoading ?? this.profileGroupsLoading,
      profileItemsLoading: profileItemsLoading ?? this.profileItemsLoading,
      profileGroups: profileGroups ?? this.profileGroups,
      selectedProfileGroup: clearSelectedProfileGroup
          ? null
          : selectedProfileGroup ?? this.selectedProfileGroup,
      profileItems: profileItems ?? this.profileItems,
      downloadingProfileKeys:
          downloadingProfileKeys ?? this.downloadingProfileKeys,
      profileFeedLoading: profileFeedLoading ?? this.profileFeedLoading,
      profileFeedLoadingMore:
          profileFeedLoadingMore ?? this.profileFeedLoadingMore,
      profileFeedHasNextPage:
          profileFeedHasNextPage ?? this.profileFeedHasNextPage,
      profileFeedNextCursor: clearProfileFeedNextCursor
          ? null
          : profileFeedNextCursor ?? this.profileFeedNextCursor,
      profileFeedItems: profileFeedItems ?? this.profileFeedItems,
      selectedProfileFeedItem: clearSelectedProfileFeedItem
          ? null
          : selectedProfileFeedItem ?? this.selectedProfileFeedItem,
      profileMediaLoading: profileMediaLoading ?? this.profileMediaLoading,
      profileMediaItems: profileMediaItems ?? this.profileMediaItems,
      downloadingProfileMediaUrls:
          downloadingProfileMediaUrls ?? this.downloadingProfileMediaUrls,
    );
  }
}
