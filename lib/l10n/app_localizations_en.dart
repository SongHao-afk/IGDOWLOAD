// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get login => 'Log in';

  @override
  String get logout => 'Log out';

  @override
  String get understood => 'Got it';

  @override
  String get delete => 'Delete';

  @override
  String get deleteAll => 'Delete all';

  @override
  String get share => 'Share';

  @override
  String get download => 'Download';

  @override
  String get downloadAgain => 'Download again';

  @override
  String get saved => 'Downloaded';

  @override
  String get loading => 'Loading';

  @override
  String get apply => 'Apply';

  @override
  String get frequentProfilesTitle => 'Recently viewed profiles';

  @override
  String get frequentProfilesEmptyTitle => 'No profiles yet';

  @override
  String get frequentProfilesEmptyMessage =>
      'Profiles you have viewed will appear here.';

  @override
  String get account => 'Account';

  @override
  String get downloadHistoryTitle => 'Download history';

  @override
  String get downloadHistoryEmptyTitle => 'No content yet';

  @override
  String get downloadHistoryEmptyMessage =>
      'You have not downloaded any content yet';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get deleteAllHistoryTitle => 'Delete all history?';

  @override
  String get deleteAllHistoryMessage =>
      'All items in your download history will be removed from the app.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Delete $count items?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'The selected item will be removed from your download history.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count selected items will be removed from your download history.';
  }

  @override
  String get deleteOneTitle => 'Delete this item?';

  @override
  String get deleteOneMessage =>
      'This item will be removed from your download history.';

  @override
  String get cannotShareFileMissing =>
      'Cannot share. The file no longer exists on this device.';

  @override
  String get cannotShareContent => 'Cannot share this content.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Cannot save again. The file no longer exists on this device.';

  @override
  String get savedAgainToGallery => 'Saved again to gallery.';

  @override
  String get cannotSaveAgainContent => 'Cannot save this content again.';

  @override
  String get cannotOpenFileMissing =>
      'Cannot open this content. The file no longer exists on this device.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Photo';

  @override
  String get content => 'Content';

  @override
  String get justDownloaded => 'Just downloaded';

  @override
  String get heroTitle => 'Download content from Instagram';

  @override
  String get heroConnected => 'Instagram is connected.';

  @override
  String get heroDescription =>
      'Download photos, reels, and stories quickly and easily.';

  @override
  String get downloadByLink => 'Download by link';

  @override
  String get invalidLinkTitle => 'Invalid link';

  @override
  String get invalidLinkMessage =>
      'Please enter the Instagram link for the post, Reel, Story, or video you want to download.';

  @override
  String get downloadByLinkInfo1 =>
      'Use this when you already have a link to an Instagram post, Reel, Story, or Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Paste the link and the app will check the content and let you download it.';

  @override
  String get example => 'Example:';

  @override
  String get enterInstagramLink => 'Enter Instagram link';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... or /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Paste an Instagram link to check and download the content you want.';

  @override
  String get openInstagram => 'Open Instagram';

  @override
  String get getContent => 'Get content';

  @override
  String get explainFeature => 'Explain feature';

  @override
  String get downloadFromProfile => 'Download from profile';

  @override
  String get invalidProfileTitle => 'Invalid information';

  @override
  String get invalidProfileMessage =>
      'Please enter an Instagram username or profile link.';

  @override
  String get profileInfo1 =>
      'Use this when you want to view and download multiple items from an Instagram account.';

  @override
  String get profileInfo2 =>
      'Enter a username or profile link, then choose the Story, Reels, or posts you want to download.';

  @override
  String get profileInputLabel => 'Username or profile link';

  @override
  String get profileInputHint => 'Example: @username or instagram.com/username';

  @override
  String get profileCardDescription =>
      'Enter a username or profile link to view downloadable Stories, Reels, and posts.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Posts';

  @override
  String get photosPosts => 'Photos / Posts';

  @override
  String get photosVideos => 'Photos / Videos';

  @override
  String get profileSummary => 'Profile summary';

  @override
  String get storyModeHint =>
      'Enter a profile to view downloadable Stories and Highlights.';

  @override
  String get reelsModeHint => 'Enter a profile to view the Reels list.';

  @override
  String get postsModeHint => 'Enter a profile to view downloadable posts.';

  @override
  String get storyPopupTitle => 'Download Stories from profile';

  @override
  String get reelsPopupTitle => 'Download Reels from profile';

  @override
  String get postsPopupTitle => 'Download posts from profile';

  @override
  String get viewStory => 'View Story';

  @override
  String get viewReels => 'View Reels';

  @override
  String get viewPosts => 'View posts';

  @override
  String get noStoryOrHighlightAll =>
      'No Story or Highlight found. Log in if the content requires viewing permission.';

  @override
  String get noStoryOrHighlightInput =>
      'No Story or Highlight found. Enter an Instagram profile to check.';

  @override
  String get noStoryItems =>
      'There is no content to display, or you do not have permission to view this item.';

  @override
  String get noFeedAll =>
      'No posts or videos found. Log in if the content requires viewing permission.';

  @override
  String get noFeedInput =>
      'No content yet. Choose Reels or Posts, then enter a profile.';

  @override
  String get endOfContent => 'You have reached the end of the content.';

  @override
  String get loadMore => 'Load more';

  @override
  String get loadingMore => 'Loading more...';

  @override
  String get cannotShowPostContent =>
      'Cannot display the content in this post.';

  @override
  String get chooseItemToDownload => 'Choose an item to download';

  @override
  String contentCount(int count) {
    return '$count items';
  }

  @override
  String get chooseThemeColor => 'Choose theme color';

  @override
  String get themeDefault => 'Default';

  @override
  String get themeVivid => 'Vivid';

  @override
  String get themePink => 'Glossy pink';

  @override
  String get themeBlue => 'Light blue';

  @override
  String get themeRed => 'Red';

  @override
  String get themeDark => 'Dark';

  @override
  String get loginRequiredTitle => 'Login required';

  @override
  String get followRequiredTitle => 'Follow required';

  @override
  String get followRequiredMessage =>
      'The logged-in account does not have permission to view this content.';

  @override
  String get downloadSuccessMessage => 'Downloaded successfully.';

  @override
  String get viewHistory => 'View history';

  @override
  String get frequentAccessTooltip => 'Frequent access';

  @override
  String get recentDownloadsTooltip => 'Recent downloads';

  @override
  String get changeThemeTooltip => 'Change theme';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSettingTitle => 'Theme';

  @override
  String get languageSettingTitle => 'Language';

  @override
  String get chooseLanguageTitle => 'Choose your language';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Download mode';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Your Instagram account is connected.';

  @override
  String get sessionPrivatePrompt =>
      'Log in to Instagram to download content your account is allowed to view.';

  @override
  String get sessionPublicPrompt =>
      'You are downloading public content without logging in.';

  @override
  String get profileReelsListTitle => 'Reel video list';

  @override
  String get profilePostsListTitle => 'Photo / Post list';

  @override
  String get close => 'Close';

  @override
  String get instagramHome => 'Instagram home';

  @override
  String get selectThisContent => 'Select this content';

  @override
  String get manualOpeningInstagram => 'Opening Instagram...';

  @override
  String get manualInstruction =>
      'Open the post, Reel, Story, or Highlight you want to download, then tap \"Select this content\".';

  @override
  String get manualPickedContent =>
      'Content selected. Tap \"Select this content\" to continue.';

  @override
  String get manualNoDownloadableContent =>
      'No downloadable content found. Open a post, Reel, Story, or Highlight.';

  @override
  String get manualCloseToExit =>
      'To avoid losing the selected content, tap \"Close\" if you want to exit.';

  @override
  String get loginOpeningInstagram => 'Opening Instagram... Please wait.';

  @override
  String get loginInstruction =>
      'Log in to Instagram, then tap \"Save\" to finish.';

  @override
  String get loginChecking => 'Checking login...';

  @override
  String get loginCannotConfirm =>
      'Cannot confirm login.\nPlease log in to Instagram and try saving again.';

  @override
  String get loginSaveError =>
      'An error occurred while saving login information. Please try again.';

  @override
  String get loginLoggingOut => 'Logging out...';

  @override
  String get loginLoggedOut =>
      'You have logged out of Instagram.\nPlease log in again to continue.';

  @override
  String get loginSuccessPrompt => 'Login successful.\nTap \"Save\" to finish.';

  @override
  String get loginPromptOnLoginPage =>
      'Log in to Instagram, then tap \"Save\" to finish.';

  @override
  String get loginPromptSaveBottom =>
      'If you have finished logging in, tap \"Save\" below.';

  @override
  String get loginPageTitle => 'Log in to Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Opening Instagram...\nAfter logging in, tap \"Save\".';

  @override
  String get loginOpenFailed =>
      'Cannot open Instagram.\nPlease check your internet connection and try again.';

  @override
  String get profileSavedMissingUsername =>
      'Saved profile is missing a username.';

  @override
  String get openingProfile => 'Opening profile...';

  @override
  String openingUsername(String username) {
    return 'Opening @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Found $storyCount Story/Highlight items and $postCount posts.';
  }

  @override
  String get privateModeEnabled => 'Private mode enabled.';

  @override
  String get publicModeEnabled => 'Switched back to Public mode.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Cannot confirm Instagram login. Please log in again.';

  @override
  String get instagramConnected => 'Instagram account connected.';

  @override
  String get loggingOutInstagram => 'Logging out of Instagram...';

  @override
  String get instagramLoggedOut => 'You have logged out of Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Logged out of Instagram, but there was an error clearing login data.';

  @override
  String get emptyInstagramLink => 'Please enter an Instagram link.';

  @override
  String get preparingContent => 'Preparing content...';

  @override
  String get loadingContentWithAccount =>
      'Loading content with the connected account...';

  @override
  String get cannotFetchContent => 'Cannot fetch content.';

  @override
  String get noDownloadableContentFound => 'No downloadable content found.';

  @override
  String foundDownloadableContent(int count) {
    return 'Found $count downloadable items.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Cannot fetch content. Please check the link or try again.';

  @override
  String get fetchContentFailedPrivate =>
      'Cannot fetch content. Please check viewing permission or log in again.';

  @override
  String get emptyProfileInput => 'Please enter an Instagram profile.';

  @override
  String get loadingStoryHighlights => 'Loading Stories and Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'No current story or highlight found.';

  @override
  String foundStoryHighlights(int count) {
    return 'Found $count Story/Highlight items.';
  }

  @override
  String get cannotOpenContent => 'Cannot open this content.';

  @override
  String openingStoryGroup(String title) {
    return 'Opening \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Found $count items in \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Cannot open Story or Highlight. Please log in and try again.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Cannot open Story or Highlight. Please check viewing permission.';

  @override
  String get cannotDownloadContent => 'Cannot download this content.';

  @override
  String get downloadingStory => 'Downloading story...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Saved story item to album $albumName.';
  }

  @override
  String get downloadStoryFailed => 'Story download failed. Please try again.';

  @override
  String get loadingReelsPublic => 'Fetching reels...';

  @override
  String get loadingReelsPrivate => 'Loading reels...';

  @override
  String get noReelsOrPermission =>
      'No Reels found, or you do not have permission to view them.';

  @override
  String foundReels(int count) {
    return 'Found $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Cannot load Reels. Please check the profile or try again.';

  @override
  String get cannotLoadReelsPrivate =>
      'Cannot load Reels. Please check viewing permission.';

  @override
  String get loadingPostsPublic => 'Fetching photos/posts...';

  @override
  String get loadingPostsPrivate => 'Loading photos/posts...';

  @override
  String get noPostsOrPermission =>
      'No photos/posts found, or you do not have permission to view them.';

  @override
  String foundPosts(int count) {
    return 'Found $count photos/posts.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Cannot load posts. Please check the profile or try again.';

  @override
  String get cannotLoadPostsPrivate =>
      'Cannot load posts. Please check viewing permission.';

  @override
  String get cannotLoadMoreContent => 'Cannot load more content.';

  @override
  String get cannotLoadMoreProfile =>
      'Cannot load more. Please enter the profile again.';

  @override
  String get noMoreNewContent => 'No more new content.';

  @override
  String loadedMoreContent(int count) {
    return 'Loaded $count more items.';
  }

  @override
  String get loadMoreFailed => 'Load more failed. Please try again.';

  @override
  String get openingReel => 'Opening Reel...';

  @override
  String get openingPost => 'Opening post...';

  @override
  String get cannotOpenContentPermission =>
      'Cannot open this content. Please check viewing permission or try again.';

  @override
  String get downloadingContent => 'Downloading content...';

  @override
  String savedToAlbum(String albumName) {
    return 'Saved to album $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Saved content to album $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Content download failed. Tap to try again.';

  @override
  String get downloadHistoryCleared => 'Download history cleared.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Removed $count items from history.';
  }

  @override
  String get downloadConnectionSlow =>
      'Download failed due to a slow connection. Tap to try again.';

  @override
  String get downloadNetworkUnavailable =>
      'Cannot connect to the network/CDN. Check your network and try again.';

  @override
  String get downloadCancelled => 'Download cancelled.';

  @override
  String get downloadGenericError => 'Download failed. Tap to try again.';

  @override
  String downloadProgress(String percent) {
    return 'Downloading content: $percent%';
  }
}
