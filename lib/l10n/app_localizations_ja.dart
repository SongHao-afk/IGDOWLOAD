// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get login => 'ログイン';

  @override
  String get logout => 'ログアウト';

  @override
  String get understood => '了解';

  @override
  String get delete => '削除';

  @override
  String get deleteAll => 'すべて削除';

  @override
  String get share => '共有';

  @override
  String get download => 'ダウンロード';

  @override
  String get downloadAgain => '再ダウンロード';

  @override
  String get saved => 'ダウンロード済み';

  @override
  String get loading => '読み込み中';

  @override
  String get apply => '適用';

  @override
  String get frequentProfilesTitle => '最近閲覧したプロフィール';

  @override
  String get frequentProfilesEmptyTitle => 'まだプロフィールがありません';

  @override
  String get frequentProfilesEmptyMessage => '閲覧したプロフィールがここに表示されます。';

  @override
  String get account => 'アカウント';

  @override
  String get downloadHistoryTitle => 'ダウンロード履歴';

  @override
  String get downloadHistoryEmptyTitle => 'コンテンツはまだありません';

  @override
  String get downloadHistoryEmptyMessage => 'コンテンツをダウンロードしていませんまだ';

  @override
  String selectedCount(int count) {
    return '$count選択済み';
  }

  @override
  String get deleteAllHistoryTitle => 'すべての履歴を削除しますか？';

  @override
  String get deleteAllHistoryMessage => 'ダウンロード履歴のすべてのアイテムがアプリから削除されます。';

  @override
  String deleteSelectedTitle(int count) {
    return '$countアイテムを削除しますか？';
  }

  @override
  String get deleteSelectedOneMessage => '選択したアイテムがダウンロード履歴から削除されます。';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count選択したアイテムがダウンロード履歴から削除されます。';
  }

  @override
  String get deleteOneTitle => 'このアイテムを削除しますか？';

  @override
  String get deleteOneMessage => 'このアイテムはダウンロード履歴から削除されます。';

  @override
  String get cannotShareFileMissing => '共有できません。ファイルはこのデバイスに存在しません。';

  @override
  String get cannotShareContent => 'このコンテンツを共有できません。';

  @override
  String get cannotSaveAgainFileMissing => '再度保存できません。ファイルはこのデバイスに存在しません。';

  @override
  String get savedAgainToGallery => 'ギャラリーに再保存されました。';

  @override
  String get cannotSaveAgainContent => 'このコンテンツを再度保存できません。';

  @override
  String get cannotOpenFileMissing => 'このコンテンツを開けません。ファイルはこのデバイスに存在しません。';

  @override
  String get video => 'ビデオ';

  @override
  String get image => '写真';

  @override
  String get content => 'コンテンツ';

  @override
  String get justDownloaded => 'ダウンロードしたばかりです';

  @override
  String get heroTitle => 'Instagram';

  @override
  String get heroConnected => 'Instagramからコンテンツをダウンロードします。';

  @override
  String get heroDescription => '写真、リール、ストーリーをすばやく簡単にダウンロードします。';

  @override
  String get downloadByLink => 'リンクでダウンロード';

  @override
  String get invalidLinkTitle => '無効なリンク';

  @override
  String get invalidLinkMessage =>
      'ダウンロードしたい投稿、、Story、またはビデオのInstagramリンクを入力してください。';

  @override
  String get downloadByLinkInfo1 =>
      'すでにリンクがある場合はこれを使用してください。 Instagram ポスト、Reel、Story、または Highlight に送信します。';

  @override
  String get downloadByLinkInfo2 =>
      'リンクを貼り付けると、アプリがコンテンツを確認してダウンロードできるようになります。';

  @override
  String get example => '例：';

  @override
  String get enterInstagramLink => 'Instagram リンクを入力してください';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... または /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Instagram リンクを貼り付けて、必要なコンテンツを確認してダウンロードします。';

  @override
  String get openInstagram => 'Instagramを開く';

  @override
  String get getContent => 'コンテンツを取得する';

  @override
  String get explainFeature => '説明機能';

  @override
  String get downloadFromProfile => 'プロフィールからダウンロード';

  @override
  String get invalidProfileTitle => '無効な情報';

  @override
  String get invalidProfileMessage => 'Instagram ユーザー名またはプロフィールのリンクを入力してください。';

  @override
  String get profileInfo1 =>
      'Instagram アカウントから複数のアイテムを表示およびダウンロードする場合にこれを使用します。';

  @override
  String get profileInfo2 =>
      'ユーザー名またはプロフィールのリンクを入力し、ダウンロードする Story、Reel、または投稿を選択します。';

  @override
  String get profileInputLabel => 'ユーザー名またはプロフィールのリンク';

  @override
  String get profileInputHint => '例: @ユーザー名またはinstagram.com/ユーザー名';

  @override
  String get profileCardDescription =>
      'ユーザー名またはプロフィール リンクを入力して、ダウンロード可能な Stories、Reel、および投稿を表示します。';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => '投稿';

  @override
  String get photosPosts => '写真・投稿';

  @override
  String get photosVideos => '写真/ビデオ';

  @override
  String get profileSummary => 'プロフィールの概要';

  @override
  String get storyModeHint =>
      'プロファイルを入力して、ダウンロード可能な Stories および Highlight を表示します。';

  @override
  String get reelsModeHint => 'プロファイルを入力してリストを表示します。';

  @override
  String get postsModeHint => 'ダウンロード可能な投稿を表示するには、プロフィールを入力してください。';

  @override
  String get storyPopupTitle => 'プロフィールからStoriesをダウンロード';

  @override
  String get reelsPopupTitle => 'プロフィールからファイルをダウンロード';

  @override
  String get postsPopupTitle => 'プロフィールから投稿をダウンロード';

  @override
  String get viewStory => 'Storyを見る';

  @override
  String get viewReels => 'Reelを表示する';

  @override
  String get viewPosts => '投稿を見る';

  @override
  String get noStoryOrHighlightAll =>
      'Story または Highlight が見つかりません。コンテンツの閲覧許可が必要な場合はログインしてください。';

  @override
  String get noStoryOrHighlightInput =>
      'Story または Highlight が見つかりません。確認する Instagram プロファイルを入力します。';

  @override
  String get noStoryItems => '表示するコンテンツがないか、このアイテムを表示する権限がありません。';

  @override
  String get noFeedAll => '投稿やビデオが見つかりませんでした。コンテンツの閲覧許可が必要な場合はログインしてください。';

  @override
  String get noFeedInput =>
      'まだコンテンツはありません。 [Reels] または [投稿] を選択し、プロフィールを入力します。';

  @override
  String get endOfContent => 'コンテンツの最後まで到達しました。';

  @override
  String get loadMore => 'さらにロードする';

  @override
  String get loadingMore => 'さらに読み込み中...';

  @override
  String get cannotShowPostContent => 'この投稿のコンテンツは表示できません。';

  @override
  String get chooseItemToDownload => 'ダウンロードするアイテムを選択してください';

  @override
  String contentCount(int count) {
    return '$countアイテム';
  }

  @override
  String get chooseThemeColor => 'テーマカラーを選択してください';

  @override
  String get themeDefault => 'デフォルト';

  @override
  String get themeVivid => '鮮やかな';

  @override
  String get themePink => '光沢のあるピンク';

  @override
  String get themeBlue => '水色';

  @override
  String get themeRed => '赤';

  @override
  String get themeDark => '暗い';

  @override
  String get loginRequiredTitle => 'ログインが必要です';

  @override
  String get followRequiredTitle => 'フォロー必須';

  @override
  String get followRequiredMessage => 'ログインしたアカウントには、このコンテンツを表示する権限がありません。';

  @override
  String get downloadSuccessMessage => '正常にダウンロードされました。';

  @override
  String get viewHistory => '履歴を見る';

  @override
  String get frequentAccessTooltip => '頻繁なアクセス';

  @override
  String get recentDownloadsTooltip => '最近のダウンロード';

  @override
  String get changeThemeTooltip => 'テーマの変更';

  @override
  String get settingsTitle => '設定';

  @override
  String get themeSettingTitle => 'テーマ';

  @override
  String get languageSettingTitle => '言語';

  @override
  String get chooseLanguageTitle => '言語を選択してください';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'ダウンロードモード';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Instagram アカウントが接続されました。';

  @override
  String get sessionPrivatePrompt =>
      'Instagram にログインして、アカウントに表示が許可されているコンテンツをダウンロードします。';

  @override
  String get sessionPublicPrompt => 'ログインせずに公開コンテンツをダウンロードしています。';

  @override
  String get profileReelsListTitle => 'Reel ビデオリスト';

  @override
  String get profilePostsListTitle => '写真・投稿一覧';

  @override
  String get close => '近い';

  @override
  String get instagramHome => 'Instagram ホーム';

  @override
  String get selectThisContent => 'このコンテンツを選択してください';

  @override
  String get manualOpeningInstagram => '開いています...';

  @override
  String get manualInstruction =>
      'ダウンロードしたい投稿、Reel、Story、または Highlight を開き、「このコンテンツを選択」をタップします。';

  @override
  String get manualPickedContent => 'コンテンツが選択されました。 「このコンテンツを選択」をタップして続行します。';

  @override
  String get manualNoDownloadableContent =>
      'ダウンロード可能なコンテンツが見つかりませんでした。投稿、Reel、Story、または Highlight を開きます。';

  @override
  String get manualCloseToExit => '選択したコンテンツが失われないように、終了する場合は「閉じる」をタップしてください。';

  @override
  String get loginOpeningInstagram => 'Instagram を開きます...お待ちください。';

  @override
  String get loginInstruction => 'Instagramにログインし、「保存」をタップして終了します。';

  @override
  String get loginChecking => 'ログインを確認しています...';

  @override
  String get loginCannotConfirm =>
      'ログインが確認できません。\nInstagram にログインし、再度保存してください。';

  @override
  String get loginSaveError => 'ログイン情報の保存中にエラーが発生しました。もう一度試してください。';

  @override
  String get loginLoggingOut => 'ログアウト中...';

  @override
  String get loginLoggedOut => 'Instagram からログアウトしました。\n続行するには再度ログインしてください。';

  @override
  String get loginSuccessPrompt => 'ログインに成功しました。\n「保存」をタップして終了します。';

  @override
  String get loginPromptOnLoginPage => 'Instagramにログインし、「保存」をタップして終了します。';

  @override
  String get loginPromptSaveBottom => 'ログインが完了したら、下の「保存」をタップしてください。';

  @override
  String get loginPageTitle => 'Instagramにログイン';

  @override
  String get loginOpeningInstagramWithHint => '開いています...\nログイン後、「保存」をタップします。';

  @override
  String get loginOpenFailed => 'Instagramを開けません。\nインターネット接続を確認して、もう一度試してください。';

  @override
  String get profileSavedMissingUsername => '保存されたプロファイルにユーザー名がありません。';

  @override
  String get openingProfile => 'プロフィールを開いています...';

  @override
  String openingUsername(String username) {
    return '@$username を開きます...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return '$storyCount Story/Highlight アイテムと $postCount 投稿が見つかりました。';
  }

  @override
  String get privateModeEnabled => 'Private モードが有効になりました。';

  @override
  String get publicModeEnabled => 'Public モードに戻りました。';

  @override
  String get cannotConfirmInstagramLogin =>
      'Instagram ログインを確認できません。再度ログインしてください。';

  @override
  String get instagramConnected => 'Instagram アカウントが接続されました。';

  @override
  String get loggingOutInstagram => 'Instagramからログアウトしています...';

  @override
  String get instagramLoggedOut => 'Instagram からログアウトしました。';

  @override
  String get instagramLogoutCleanupFailed =>
      'Instagram からログアウトしましたが、ログイン データのクリア中にエラーが発生しました。';

  @override
  String get emptyInstagramLink => 'Instagram リンクを入力してください。';

  @override
  String get preparingContent => 'コンテンツを準備しています...';

  @override
  String get loadingContentWithAccount => '接続されたアカウントでコンテンツをロードしています...';

  @override
  String get cannotFetchContent => 'コンテンツを取得できません。';

  @override
  String get noDownloadableContentFound => 'ダウンロード可能なコンテンツが見つかりませんでした。';

  @override
  String foundDownloadableContent(int count) {
    return '$count 件のダウンロード可能なアイテムが見つかりました。';
  }

  @override
  String get fetchContentFailedPublic => 'コンテンツを取得できません。リンクを確認するか、もう一度試してください。';

  @override
  String get fetchContentFailedPrivate =>
      'コンテンツを取得できません。閲覧許可を確認するか、再度ログインしてください。';

  @override
  String get emptyProfileInput => 'Instagram プロフィールを入力してください。';

  @override
  String get loadingStoryHighlights => 'Stories と Highlight を読み込み中...';

  @override
  String get noCurrentStoryOrHighlight => '現在のストーリーやハイライトは見つかりません。';

  @override
  String foundStoryHighlights(int count) {
    return '$count Story/Highlight アイテムが見つかりました。';
  }

  @override
  String get cannotOpenContent => 'このコンテンツを開けません。';

  @override
  String openingStoryGroup(String title) {
    return '「$title」を開くと…';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '「$title」で$countアイテムが見つかりました。';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Story または Highlight を開けません。ログインしてもう一度お試しください。';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Story または Highlight を開けません。閲覧許可を確認してください。';

  @override
  String get cannotDownloadContent => 'このコンテンツはダウンロードできません。';

  @override
  String get downloadingStory => 'ストーリーをダウンロード中...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'ストーリー アイテムをアルバム $albumName に保存しました。';
  }

  @override
  String get downloadStoryFailed => 'Story ダウンロードに失敗しました。もう一度試してください。';

  @override
  String get loadingReelsPublic => 'リールを取得中...';

  @override
  String get loadingReelsPrivate => 'リールを読み込み中...';

  @override
  String get noReelsOrPermission => 'Reel が見つからないか、Reel を表示する権限がありません。';

  @override
  String foundReels(int count) {
    return '$count Reelが見つかりました。';
  }

  @override
  String get cannotLoadReelsPublic => 'Reelをロードできません。プロフィールを確認するか、もう一度お試しください。';

  @override
  String get cannotLoadReelsPrivate => 'Reelをロードできません。閲覧許可を確認してください。';

  @override
  String get loadingPostsPublic => '写真/投稿を取得しています...';

  @override
  String get loadingPostsPrivate => '写真/投稿を読み込んでいます...';

  @override
  String get noPostsOrPermission => '写真/投稿が見つからないか、閲覧する権限がありません。';

  @override
  String foundPosts(int count) {
    return '$count 写真/投稿が見つかりました。';
  }

  @override
  String get cannotLoadPostsPublic => '投稿を読み込めません。プロフィールを確認するか、もう一度お試しください。';

  @override
  String get cannotLoadPostsPrivate => '投稿を読み込めません。閲覧許可を確認してください。';

  @override
  String get cannotLoadMoreContent => 'これ以上コンテンツをロードできません。';

  @override
  String get cannotLoadMoreProfile => 'これ以上ロードできません。プロフィールを再度入力してください。';

  @override
  String get noMoreNewContent => '新しいコンテンツはもうありません。';

  @override
  String loadedMoreContent(int count) {
    return '$count 件のコンテンツをさらに読み込みました。';
  }

  @override
  String get loadMoreFailed => 'さらにロードできませんでした。もう一度試してください。';

  @override
  String get openingReel => '開いています...';

  @override
  String get openingPost => '投稿を開いています...';

  @override
  String get cannotOpenContentPermission =>
      'このコンテンツを開けません。閲覧権限を確認するか、再度お試しください。';

  @override
  String get downloadingContent => 'コンテンツをダウンロード中...';

  @override
  String savedToAlbum(String albumName) {
    return 'アルバム$albumNameに保存されました。';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'コンテンツをアルバム $albumName に保存しました。';
  }

  @override
  String get downloadContentErrorRetry =>
      'コンテンツのダウンロードに失敗しました。タップしてもう一度試してください。';

  @override
  String get downloadHistoryCleared => 'ダウンロード履歴が消去されました。';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return '$count アイテムを履歴から削除しました。';
  }

  @override
  String get downloadConnectionSlow => '接続が遅いためダウンロードに失敗しました。タップしてもう一度試してください。';

  @override
  String get downloadNetworkUnavailable =>
      'ネットワーク/CDNに接続できません。ネットワークを確認して再試行してください。';

  @override
  String get downloadCancelled => 'ダウンロードはキャンセルされました。';

  @override
  String get downloadGenericError => 'ダウンロードは失敗しました。タップしてもう一度お試しください。';

  @override
  String downloadProgress(String percent) {
    return 'コンテンツをダウンロード中: $percent%';
  }

  @override
  String get legalLinksTitle => 'プライバシーポリシーと利用規約';

  @override
  String get termsOfUse => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';
}
