// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get login => '登录';

  @override
  String get logout => '注销';

  @override
  String get understood => '知道了';

  @override
  String get delete => '删除';

  @override
  String get deleteAll => '全部删除';

  @override
  String get share => '分享';

  @override
  String get download => '下载';

  @override
  String get downloadAgain => '重新下载';

  @override
  String get saved => '已下载';

  @override
  String get loading => '加载';

  @override
  String get apply => '应用';

  @override
  String get frequentProfilesTitle => '最近浏览过的资料';

  @override
  String get frequentProfilesEmptyTitle => '还没有资料';

  @override
  String get frequentProfilesEmptyMessage => '你浏览过的资料会出现在这里。';

  @override
  String get account => '账户';

  @override
  String get downloadHistoryTitle => '下载历史';

  @override
  String get downloadHistoryEmptyTitle => '没有内容';

  @override
  String get downloadHistoryEmptyMessage => '您尚未下载任何内容';

  @override
  String selectedCount(int count) {
    return '$count已选择';
  }

  @override
  String get deleteAllHistoryTitle => '删除所有历史记录？';

  @override
  String get deleteAllHistoryMessage => '下载历史记录中的所有项目都将从应用程序中删除。';

  @override
  String deleteSelectedTitle(int count) {
    return '删除$count项目？';
  }

  @override
  String get deleteSelectedOneMessage => '所选项目将从你的下载历史记录中删除。';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count所选项目将从你的下载历史记录中删除。';
  }

  @override
  String get deleteOneTitle => '删除此项目？';

  @override
  String get deleteOneMessage => '此项目将从你的下载历史记录中删除。';

  @override
  String get cannotShareFileMissing => '无法共享。该设备上不再存在该文件。';

  @override
  String get cannotShareContent => '无法共享该内容。';

  @override
  String get cannotSaveAgainFileMissing => '无法再次保存。此设备上不再存在该文件。';

  @override
  String get savedAgainToGallery => '已再次保存到图库。';

  @override
  String get cannotSaveAgainContent => '无法再次保存该内容。';

  @override
  String get cannotOpenFileMissing => '无法打开该内容。此设备上不再存在该文件。';

  @override
  String get video => '视频';

  @override
  String get image => '照片';

  @override
  String get content => '内容';

  @override
  String get justDownloaded => '刚刚下载';

  @override
  String get heroTitle => '从已连接的Instagram';

  @override
  String get heroConnected => 'Instagram下载内容。';

  @override
  String get heroDescription => '快速轻松地下载照片、卷轴和故事。';

  @override
  String get downloadByLink => '通过链接下载';

  @override
  String get invalidLinkTitle => '链接无效';

  @override
  String get invalidLinkMessage => '请输入你要下载的帖子、Reel、Story或视频的Instagram链接。';

  @override
  String get downloadByLinkInfo1 =>
      '在以下情况下使用此选项您已有 Instagram 帖子、Reel、Story 或 Highlight 的链接。';

  @override
  String get downloadByLinkInfo2 => '粘贴链接，应用程序将检查内容并让您下载。';

  @override
  String get example => '例子：';

  @override
  String get enterInstagramLink => '输入 Instagram 链接';

  @override
  String get instagramLinkHint => 'https://www.instagram.com/p/... 或 /reel/...';

  @override
  String get pasteInstagramLinkHint => '粘贴 Instagram 链接以检查并下载您想要的内容。';

  @override
  String get openInstagram => '打开 Instagram';

  @override
  String get getContent => '获取内容';

  @override
  String get explainFeature => '解释功能';

  @override
  String get downloadFromProfile => '从个人资料下载';

  @override
  String get invalidProfileTitle => '无效信息';

  @override
  String get invalidProfileMessage => '请输入 Instagram 用户名或个人资料链接。';

  @override
  String get profileInfo1 => '当您想要从 Instagram 帐户查看和下载多个项目时，请使用此选项。';

  @override
  String get profileInfo2 => '输入用户名或个人资料链接，然后选择您要下载的 Story、Reel 或帖子。';

  @override
  String get profileInputLabel => '用户名或个人资料链接';

  @override
  String get profileInputHint => '示例：@username 或 instagram.com/username';

  @override
  String get profileCardDescription => '输入用户名或个人资料链接以查看可下载的 Stories、Reel 和帖子。';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => '帖子';

  @override
  String get photosPosts => '照片/帖子';

  @override
  String get photosVideos => '照片/视频';

  @override
  String get profileSummary => '简介概要';

  @override
  String get storyModeHint => '输入配置文件以查看可下载的 Stories 和 Highlight。';

  @override
  String get reelsModeHint => '输入个人资料以查看列表。';

  @override
  String get postsModeHint => '输入个人资料以查看可下载的帖子。';

  @override
  String get storyPopupTitle => '从个人资料下载 Stories';

  @override
  String get reelsPopupTitle => '从个人资料下载 Reel';

  @override
  String get postsPopupTitle => '从个人资料下载帖子';

  @override
  String get viewStory => '查看 Story';

  @override
  String get viewReels => '查看 Reels';

  @override
  String get viewPosts => '查看帖子';

  @override
  String get noStoryOrHighlightAll => '未找到 Story 或 Highlight。如果内容需要查看权限，请登录。';

  @override
  String get noStoryOrHighlightInput =>
      '未找到 Story 或 Highlight。输入 Instagram 配置文件进行检查。';

  @override
  String get noStoryItems => '没有可显示的内容，或者您​​没有查看该项目的权限。';

  @override
  String get noFeedAll => '未找到帖子或视频。如果内容需要查看权限，请登录。';

  @override
  String get noFeedInput => '还没有内容。选择Reels或帖子，然后输入个人资料。';

  @override
  String get endOfContent => '内容已结束。';

  @override
  String get loadMore => '加载更多';

  @override
  String get loadingMore => '加载更多...';

  @override
  String get cannotShowPostContent => '无法显示本帖子内容。';

  @override
  String get chooseItemToDownload => '选择要下载的项目';

  @override
  String contentCount(int count) {
    return '$count项目';
  }

  @override
  String get chooseThemeColor => '选择主题颜色';

  @override
  String get themeDefault => '默认';

  @override
  String get themeVivid => '鲜艳';

  @override
  String get themePink => '亮粉色';

  @override
  String get themeBlue => '浅蓝色';

  @override
  String get themeRed => '红色';

  @override
  String get themeDark => '深色';

  @override
  String get loginRequiredTitle => '登录必填';

  @override
  String get followRequiredTitle => '关注必填';

  @override
  String get followRequiredMessage => '所登录的帐户没有权限查看此内容。';

  @override
  String get downloadSuccessMessage => '下载成功。';

  @override
  String get viewHistory => '查看历史记录';

  @override
  String get frequentAccessTooltip => '经常访问';

  @override
  String get recentDownloadsTooltip => '最近下载';

  @override
  String get changeThemeTooltip => '更改主题';

  @override
  String get settingsTitle => '设置';

  @override
  String get themeSettingTitle => '主题';

  @override
  String get languageSettingTitle => '语言';

  @override
  String get chooseLanguageTitle => '选择语言';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => '下载模式';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => '你的Instagram帐户是已连接。';

  @override
  String get sessionPrivatePrompt => '登录 Instagram 下载允许您的帐户查看的内容。';

  @override
  String get sessionPublicPrompt => '您正在下载公共内容，而无需登录。';

  @override
  String get profileReelsListTitle => 'Reel 视频列表';

  @override
  String get profilePostsListTitle => '照片/帖子列表';

  @override
  String get close => '关闭';

  @override
  String get instagramHome => 'Instagram主页';

  @override
  String get selectThisContent => '选择此内容';

  @override
  String get manualOpeningInstagram => '打开Instagram...';

  @override
  String get manualInstruction => '打开要下载的帖子、Reel、Story或Highlight，然后点按“选择此内容”。';

  @override
  String get manualPickedContent => '选择的内容。点击“选择此内容”继续。';

  @override
  String get manualNoDownloadableContent =>
      '未找到可下载的内容。打开帖子、Reel、Story 或 Highlight。';

  @override
  String get manualCloseToExit => '为避免丢失所选内容，如果要退出，请点击“关闭”。';

  @override
  String get loginOpeningInstagram => '打开 Instagram...请稍候。';

  @override
  String get loginInstruction => '登录 Instagram，然后点击“保存”完成。';

  @override
  String get loginChecking => '正在检查登录...';

  @override
  String get loginCannotConfirm => '无法确认登录。\n请登录 Instagram 并再次尝试保存。';

  @override
  String get loginSaveError => '保存登录信息时出错。请重试。';

  @override
  String get loginLoggingOut => '正在注销...';

  @override
  String get loginLoggedOut => '您已注销Instagram。\n请重新登录才能继续。';

  @override
  String get loginSuccessPrompt => '登录成功。\n轻按“保存”即可完成。';

  @override
  String get loginPromptOnLoginPage => '登录 Instagram，然后轻按“保存”即可完成。';

  @override
  String get loginPromptSaveBottom => '如果登录完成，请轻按下面的“保存”。';

  @override
  String get loginPageTitle => '登录 Instagram';

  @override
  String get loginOpeningInstagramWithHint => '打开 Instagram...\n登录后，点击“保存”。';

  @override
  String get loginOpenFailed => '无法打开Instagram。\n请检查您的互联网连接，然后重试。';

  @override
  String get profileSavedMissingUsername => '保存的个人资料缺少用户名。';

  @override
  String get openingProfile => '打开个人资料...';

  @override
  String openingUsername(String username) {
    return '打开 @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return '找到 $storyCount Story/Highlight 项目和 $postCount 帖子。';
  }

  @override
  String get privateModeEnabled => 'Private 模式已启用。';

  @override
  String get publicModeEnabled => '切换回 Public 模式。';

  @override
  String get cannotConfirmInstagramLogin => '无法确认 Instagram 登录。请重新登录。';

  @override
  String get instagramConnected => 'Instagram 帐户已连接。';

  @override
  String get loggingOutInstagram => '正在注销 Instagram...';

  @override
  String get instagramLoggedOut => '您已注销 Instagram。';

  @override
  String get instagramLogoutCleanupFailed => '已注销 Instagram，但清除登录数据时出错。';

  @override
  String get emptyInstagramLink => '请输入 Instagram 链接。';

  @override
  String get preparingContent => '正在准备内容...';

  @override
  String get loadingContentWithAccount => '正在使用已连接的帐户加载内容...';

  @override
  String get cannotFetchContent => '无法获取内容。';

  @override
  String get noDownloadableContentFound => '未找到可下载的内容。';

  @override
  String foundDownloadableContent(int count) {
    return '已找到$count 可下载项目。';
  }

  @override
  String get fetchContentFailedPublic => ' 无法获取内容。请检查链接或重试。';

  @override
  String get fetchContentFailedPrivate => '无法获取内容。请检查查看权限或重新登录。';

  @override
  String get emptyProfileInput => '请输入 Instagram 个人资料。';

  @override
  String get loadingStoryHighlights => '正在加载 Stories 和 Highlight...';

  @override
  String get noCurrentStoryOrHighlight => '未找到当前故事或精彩片段。';

  @override
  String foundStoryHighlights(int count) {
    return '找到 $count Story/Highlight 项。';
  }

  @override
  String get cannotOpenContent => '无法打开此内容。';

  @override
  String openingStoryGroup(String title) {
    return '打开“$title”...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '在“$title”中找到 $count 项。';
  }

  @override
  String get cannotOpenStoryHighlightLogin => '无法打开 Story 或 Highlight。请登录并重试。';

  @override
  String get cannotOpenStoryHighlightPermission =>
      '无法打开 Story 或 Highlight。请检查查看权限。';

  @override
  String get cannotDownloadContent => '无法下载此内容。';

  @override
  String get downloadingStory => '正在下载故事...';

  @override
  String savedStoryToAlbum(String albumName) {
    return '已将故事项目保存到相册$albumName。';
  }

  @override
  String get downloadStoryFailed => 'Story下载失败。请重试。';

  @override
  String get loadingReelsPublic => '正在获取卷轴...';

  @override
  String get loadingReelsPrivate => '正在加载卷轴...';

  @override
  String get noReelsOrPermission => '未找到Reel，或者您无权查看它们。';

  @override
  String foundReels(int count) {
    return '找到$count Reels。';
  }

  @override
  String get cannotLoadReelsPublic => '无法加载Reels。请检查配置文件或重试。';

  @override
  String get cannotLoadReelsPrivate => '无法加载 Reel。请检查查看权限。';

  @override
  String get loadingPostsPublic => '正在获取照片/帖子...';

  @override
  String get loadingPostsPrivate => '正在加载照片/帖子...';

  @override
  String get noPostsOrPermission => '未找到照片/帖子，或者您没有查看权限。';

  @override
  String foundPosts(int count) {
    return '找到$count照片/帖子。';
  }

  @override
  String get cannotLoadPostsPublic => '无法加载帖子。请检查个人资料或重试。';

  @override
  String get cannotLoadPostsPrivate => '无法加载帖子。请检查查看权限。';

  @override
  String get cannotLoadMoreContent => '无法加载更多内容。';

  @override
  String get cannotLoadMoreProfile => '无法加载更多内容。请重新输入个人资料。';

  @override
  String get noMoreNewContent => '没有更多新内容。';

  @override
  String loadedMoreContent(int count) {
    return '已加载$count更多项目。';
  }

  @override
  String get loadMoreFailed => '加载更多失败。请重试。';

  @override
  String get openingReel => '正在打开Reel...';

  @override
  String get openingPost => '正在打开帖子...';

  @override
  String get cannotOpenContentPermission => '无法打开此内容。请检查查看权限或重试。';

  @override
  String get downloadingContent => '正在下载内容...';

  @override
  String savedToAlbum(String albumName) {
    return '已保存到相册$albumName。';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return '已将内容保存到相册$albumName。';
  }

  @override
  String get downloadContentErrorRetry => '内容下载失败。点击重试。';

  @override
  String get downloadHistoryCleared => '已清除下载历史记录。';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return '已从历史记录中删除 $count 项目。';
  }

  @override
  String get downloadConnectionSlow => '由于连接速度慢，下载失败。点击重试。';

  @override
  String get downloadNetworkUnavailable => '无法连接到网络/CDN。检查您的网络并重试。';

  @override
  String get downloadCancelled => '下载已取消。';

  @override
  String get downloadGenericError => '下载失败。点击重试。';

  @override
  String downloadProgress(String percent) {
    return '下载内容：$percent%';
  }

  @override
  String get legalLinksTitle => '隐私政策和使用条款';

  @override
  String get termsOfUse => '使用条款';

  @override
  String get privacyPolicy => '隐私政策';
}
