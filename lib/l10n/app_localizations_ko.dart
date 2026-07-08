// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// The translations for ko (`ko`).
class AppLocalizationsKo extends AppLocalizationsEn {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get login => '로그인';

  @override
  String get logout => '로그아웃';

  @override
  String get understood => '알겠습니다';

  @override
  String get delete => '삭제';

  @override
  String get deleteAll => '모두 삭제';

  @override
  String get share => '공유';

  @override
  String get download => '다운로드';

  @override
  String get downloadAgain => '다시 다운로드';

  @override
  String get saved => '다운로드';

  @override
  String get loading => '로드 중';

  @override
  String get apply => '적용';

  @override
  String get frequentProfilesTitle => '최근에 본 프로필';

  @override
  String get frequentProfilesEmptyTitle => '아직 프로필이 없습니다';

  @override
  String get frequentProfilesEmptyMessage => '본 프로필이 여기에 표시됩니다.';

  @override
  String get account => '계정';

  @override
  String get downloadHistoryTitle => '다운로드 내역';

  @override
  String get downloadHistoryEmptyTitle => '콘텐츠 없음 아직';

  @override
  String get downloadHistoryEmptyMessage => '아직 콘텐츠를 다운로드하지 않았습니다';

  @override
  String selectedCount(int count) {
    return '${count} 선택함';
  }

  @override
  String get deleteAllHistoryTitle => '모든 기록을 삭제하시겠습니까?';

  @override
  String get deleteAllHistoryMessage => '다운로드 기록의 모든 항목이 앱에서 제거됩니다.';

  @override
  String deleteSelectedTitle(int count) {
    return '${count} 항목을 삭제하시겠습니까?';
  }

  @override
  String get deleteSelectedOneMessage => '선택한 항목이 다운로드 기록에서 제거됩니다.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '${count}선택한 항목이 다운로드 기록에서 제거됩니다.';
  }

  @override
  String get deleteOneTitle => '이 항목을 삭제하시겠습니까?';

  @override
  String get deleteOneMessage => '이 항목은 다운로드 기록에서 제거됩니다.';

  @override
  String get cannotShareFileMissing => '공유할 수 없습니다. 파일이 더 이상 이 장치에 존재하지 않습니다.';

  @override
  String get cannotShareContent => '이 콘텐츠를 공유할 수 없습니다.';

  @override
  String get cannotSaveAgainFileMissing =>
      '다시 저장할 수 없습니다. 파일이 더 이상 이 기기에 존재하지 않습니다.';

  @override
  String get savedAgainToGallery => '갤러리에 다시 저장되었습니다.';

  @override
  String get cannotSaveAgainContent => '이 콘텐츠를 다시 저장할 수 없습니다.';

  @override
  String get cannotOpenFileMissing =>
      '이 콘텐츠를 열 수 없습니다. 파일이 이 장치에 더 이상 존재하지 않습니다.';

  @override
  String get video => '동영상';

  @override
  String get image => '사진';

  @override
  String get content => '콘텐츠';

  @override
  String get justDownloaded => '방금 다운로드되었습니다';

  @override
  String get heroTitle => 'Instagram';

  @override
  String get heroConnected => 'Instagram에서 콘텐츠 다운로드가 연결되었습니다.';

  @override
  String get heroDescription => '사진, 릴, 스토리를 빠르고 쉽게 다운로드하십시오.';

  @override
  String get downloadByLink => '링크로 다운로드';

  @override
  String get invalidLinkTitle => '잘못된 링크';

  @override
  String get invalidLinkMessage =>
      '다운로드하려는 게시물, Reel, Story 또는 비디오에 대한 Instagram 링크를 입력하십시오.';

  @override
  String get downloadByLinkInfo1 =>
      '이것을 사용하십시오 Instagram 게시물, Reel, Story 또는 Highlight에 대한 링크가 이미 있는 경우.';

  @override
  String get downloadByLinkInfo2 => '링크를 붙여넣으면 앱에서 콘텐츠를 확인하고 다운로드할 수 있습니다.';

  @override
  String get example => '예:';

  @override
  String get enterInstagramLink => 'Enter Instagram link';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... 또는 /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      ' Instagram 링크를 붙여넣어 원하는 콘텐츠를 확인하고 다운로드하세요.';

  @override
  String get openInstagram => '열기 Instagram';

  @override
  String get getContent => '콘텐츠 가져오기';

  @override
  String get explainFeature => '기능 설명';

  @override
  String get downloadFromProfile => '프로필에서 다운로드';

  @override
  String get invalidProfileTitle => '잘못된 정보';

  @override
  String get invalidProfileMessage => 'Instagram를 입력하세요. 사용자 이름 또는 프로필 링크.';

  @override
  String get profileInfo1 => '이 기능은 Instagram 계정에서 여러 항목을 보고 다운로드할 때 사용합니다.';

  @override
  String get profileInfo2 =>
      '사용자 이름 또는 프로필 링크를 입력한 다음 다운로드할 Story, Reel 또는 게시물을 선택합니다.';

  @override
  String get profileInputLabel => '사용자 이름 또는 프로필 링크';

  @override
  String get profileInputHint => '예: @username 또는 instagram.com/username';

  @override
  String get profileCardDescription => '다운로드 가능한 Stories, Reel 및 게시물.';

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
  String get profileSummary => '프로필 요약';

  @override
  String get storyModeHint => '다운로드 가능한 Stories 및 Highlights를 보려면 프로필을 입력하세요.';

  @override
  String get reelsModeHint => ' Reel의 목록을 보려면 프로필을 입력하세요.';

  @override
  String get postsModeHint => '다운로드 가능한 게시물을 보려면 프로필을 입력하세요.';

  @override
  String get storyPopupTitle => 'Download Stories from 프로필';

  @override
  String get reelsPopupTitle => '프로필에서 Reel을 다운로드합니다';

  @override
  String get postsPopupTitle => '프로필에서 게시물을 다운로드합니다';

  @override
  String get viewStory => '보기 Story';

  @override
  String get viewReels => 'Reels';

  @override
  String get viewPosts => '게시물 보기';

  @override
  String get noStoryOrHighlightAll =>
      ' Story 또는 Highlight을 찾을 수 없습니다. 콘텐츠 보기 권한이 필요한 경우 로그인하세요.';

  @override
  String get noStoryOrHighlightInput =>
      ' Story 또는 Highlight이 없습니다. 확인하려면 Instagram 프로필을 입력하세요.';

  @override
  String get noStoryItems => '표시할 콘텐츠가 없거나 이 항목을 볼 수 있는 권한이 없습니다.';

  @override
  String get noFeedAll => '게시물이나 동영상이 없습니다. 콘텐츠 보기 권한이 필요한 경우 로그인하세요.';

  @override
  String get noFeedInput => '아직 콘텐츠가 없습니다. Reels 또는 게시물을 선택한 다음 프로필을 입력하세요.';

  @override
  String get endOfContent => '콘텐츠의 끝에 도달했습니다.';

  @override
  String get loadMore => '더 보기';

  @override
  String get loadingMore => '더 보기...';

  @override
  String get cannotShowPostContent => '이 게시물의 콘텐츠를 표시할 수 없습니다.';

  @override
  String get chooseItemToDownload => '다운로드할 항목을 선택하세요';

  @override
  String contentCount(int count) {
    return '${count} 항목';
  }

  @override
  String get chooseThemeColor => '테마 색상을 선택하세요';

  @override
  String get themeDefault => '기본값';

  @override
  String get themeVivid => '선명한';

  @override
  String get themePink => '광택 핑크';

  @override
  String get themeBlue => '연한 파란색';

  @override
  String get themeRed => '빨간색';

  @override
  String get themeDark => '어두운';

  @override
  String get loginRequiredTitle => '로그인 필수';

  @override
  String get followRequiredTitle => '팔로우 필수';

  @override
  String get followRequiredMessage => '로그인된 계정에는 이 콘텐츠를 볼 수 있는 권한이 없습니다.';

  @override
  String get downloadSuccessMessage => '다운로드가 완료되었습니다.';

  @override
  String get viewHistory => '기록 보기';

  @override
  String get frequentAccessTooltip => '자주 액세스';

  @override
  String get recentDownloadsTooltip => '최근 다운로드';

  @override
  String get changeThemeTooltip => '테마 변경';

  @override
  String get settingsTitle => '설정';

  @override
  String get themeSettingTitle => '테마';

  @override
  String get languageSettingTitle => '언어';

  @override
  String get chooseLanguageTitle => '언어를 선택하세요';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => '다운로드 모드';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => '귀하의 Instagram 계정은 다음과 같습니다. 연결되었습니다.';

  @override
  String get sessionPrivatePrompt =>
      ' Instagram에 로그인하여 귀하의 계정에서 볼 수 있는 콘텐츠를 다운로드하십시오.';

  @override
  String get sessionPublicPrompt => '로그인하지 않고 공개 콘텐츠를 다운로드하고 있습니다.';

  @override
  String get profileReelsListTitle => 'Reel 동영상 목록';

  @override
  String get profilePostsListTitle => '사진/게시물 목록';

  @override
  String get close => '닫기';

  @override
  String get instagramHome => 'Instagram 홈';

  @override
  String get selectThisContent => '이 콘텐츠 선택';

  @override
  String get manualOpeningInstagram => '열기 Instagram...';

  @override
  String get manualInstruction =>
      '다운로드하려는 게시물, Reel, Story 또는 Highlight를 연 다음 "이 항목 선택 콘텐츠".';

  @override
  String get manualPickedContent => '콘텐츠가 선택되었습니다. 계속하려면 "이 콘텐츠 선택"을 탭하세요.';

  @override
  String get manualNoDownloadableContent =>
      '다운로드 가능한 콘텐츠가 없습니다. Reel, Story 또는 Highlight 게시물을 엽니다.';

  @override
  String get manualCloseToExit => '선택한 콘텐츠를 잃지 않으려면 종료하려면 "닫기"를 탭하세요.';

  @override
  String get loginOpeningInstagram => 'Instagram 여는 중... 잠시 기다려 주세요.';

  @override
  String get loginInstruction => 'Instagram에 로그인한 다음 "저장"을 탭하여 완료하세요.';

  @override
  String get loginChecking => '로그인 확인 중...';

  @override
  String get loginCannotConfirm =>
      '로그인을 확인할 수 없습니다.\nInstagram에 로그인한 후 다시 저장해 보세요.';

  @override
  String get loginSaveError => '로그인 정보를 저장하는 중 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get loginLoggingOut => '로그아웃 중...';

  @override
  String get loginLoggedOut => 'Instagram에서 로그아웃했습니다.\n계속하려면 다시 로그인하십시오.';

  @override
  String get loginSuccessPrompt => '로그인에 성공했습니다.\n완료하려면 "저장"을 탭하세요.';

  @override
  String get loginPromptOnLoginPage => ' Instagram에 로그인한 다음 "저장"을 탭하여 완료하세요.';

  @override
  String get loginPromptSaveBottom => '로그인이 완료되면 아래의 "저장"을 탭하세요.';

  @override
  String get loginPageTitle => ' Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      '에 로그인 Instagram열기...\n로그인한 후 "저장"을 탭하세요.';

  @override
  String get loginOpenFailed => '열 수 없습니다 Instagram.\n인터넷 연결을 확인하고 다시 시도하십시오.';

  @override
  String get profileSavedMissingUsername => '저장된 프로필에 사용자 이름이 없습니다.';

  @override
  String get openingProfile => '프로필을 여는 중...';

  @override
  String openingUsername(String username) {
    return '@${username}를 여는 중...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return ' ${storyCount} Story/Highlight 항목 및 ${postCount} 게시물을 찾았습니다.';
  }

  @override
  String get privateModeEnabled => 'Private 모드가 활성화되었습니다.';

  @override
  String get publicModeEnabled => 'Public 모드로 다시 전환되었습니다.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Instagram 로그인을 확인할 수 없습니다. 다시 로그인해 주세요.';

  @override
  String get instagramConnected => 'Instagram 계정이 연결되었습니다.';

  @override
  String get loggingOutInstagram => ' Instagram에서 로그아웃하는 중...';

  @override
  String get instagramLoggedOut => ' Instagram에서 로그아웃했습니다.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Instagram에서 로그아웃했지만 로그인 데이터를 삭제하는 중 오류가 발생했습니다.';

  @override
  String get emptyInstagramLink => ' Instagram 링크를 입력하세요.';

  @override
  String get preparingContent => '콘텐츠 준비 중...';

  @override
  String get loadingContentWithAccount => '연결된 계정으로 콘텐츠 로드 중...';

  @override
  String get cannotFetchContent => '콘텐츠를 가져올 수 없습니다.';

  @override
  String get noDownloadableContentFound => '다운로드 가능한 콘텐츠를 찾을 수 없습니다.';

  @override
  String foundDownloadableContent(int count) {
    return '찾았습니다. ${count} 다운로드 가능한 항목.';
  }

  @override
  String get fetchContentFailedPublic =>
      '콘텐츠를 가져올 수 없습니다. 링크를 확인하거나 다시 시도해 주세요.';

  @override
  String get fetchContentFailedPrivate =>
      '콘텐츠를 가져올 수 없습니다. 보기 권한을 확인하거나 다시 로그인하세요.';

  @override
  String get emptyProfileInput => ' Instagram 프로필을 입력하세요.';

  @override
  String get loadingStoryHighlights => ' Stories 및 Highlight 로드 중...';

  @override
  String get noCurrentStoryOrHighlight => '현재 스토리나 하이라이트를 찾을 수 없습니다.';

  @override
  String foundStoryHighlights(int count) {
    return ' ${count} Story/Highlight 항목을 찾았습니다.';
  }

  @override
  String get cannotOpenContent => ' 이 콘텐츠를 열 수 없습니다.';

  @override
  String openingStoryGroup(String title) {
    return '"${title}" 여는 중...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '"${title}"에서 ${count} 항목을 찾았습니다.';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Story 또는 Highlight을 열 수 없습니다. 로그인한 후 다시 시도해 주세요.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Story 또는 Highlight을 열 수 없습니다. 시청 권한을 확인해 주세요.';

  @override
  String get cannotDownloadContent => '이 콘텐츠를 다운로드할 수 없습니다.';

  @override
  String get downloadingStory => '스토리 다운로드 중...';

  @override
  String savedStoryToAlbum(String albumName) {
    return '스토리 항목을 앨범 ${albumName}에 저장했습니다.';
  }

  @override
  String get downloadStoryFailed => 'Story 다운로드에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get loadingReelsPublic => '릴을 가져오는 중...';

  @override
  String get loadingReelsPrivate => '릴 로드 중...';

  @override
  String get noReelsOrPermission => '해당 항목을 찾을 수 없거나 해당 항목을 볼 수 있는 권한이 없습니다.';

  @override
  String foundReels(int count) {
    return '${count} Reel을 찾았습니다.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Reel을 로드할 수 없습니다. 프로필을 확인하거나 다시 시도해 주세요.';

  @override
  String get cannotLoadReelsPrivate => 'Reel을 로드할 수 없습니다. 시청 권한을 확인해 주세요.';

  @override
  String get loadingPostsPublic => '사진/게시물 가져오는 중...';

  @override
  String get loadingPostsPrivate => '사진/게시물 로드 중...';

  @override
  String get noPostsOrPermission =>
      '사진/게시물을 찾을 수 없거나 해당 사진/게시물을 볼 수 있는 권한이 없습니다.';

  @override
  String foundPosts(int count) {
    return '${count} 사진/게시물을 찾았습니다.';
  }

  @override
  String get cannotLoadPostsPublic => '게시물을 로드할 수 없습니다. 프로필을 확인하거나 다시 시도해 주세요.';

  @override
  String get cannotLoadPostsPrivate => '게시물을 로드할 수 없습니다. 시청 권한을 확인해 주세요.';

  @override
  String get cannotLoadMoreContent => '더 많은 콘텐츠를 로드할 수 없습니다.';

  @override
  String get cannotLoadMoreProfile => '더 이상 로드할 수 없습니다. 프로필을 다시 입력해주세요.';

  @override
  String get noMoreNewContent => '더 이상 새로운 콘텐츠가 없습니다.';

  @override
  String loadedMoreContent(int count) {
    return '${count}개 이상의 항목을 로드했습니다.';
  }

  @override
  String get loadMoreFailed => '추가 로드에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get openingReel => 'Reel를 여는 중...';

  @override
  String get openingPost => '게시물을 여는 중...';

  @override
  String get cannotOpenContentPermission =>
      '이 콘텐츠를 열 수 없습니다. 보기 권한을 확인하거나 다시 시도해 주세요.';

  @override
  String get downloadingContent => '콘텐츠 다운로드 중...';

  @override
  String savedToAlbum(String albumName) {
    return '앨범 ${albumName}에 저장되었습니다.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return '콘텐츠를 앨범 ${albumName}에 저장했습니다.';
  }

  @override
  String get downloadContentErrorRetry => '콘텐츠 다운로드에 실패했습니다. 다시 시도하려면 탭하세요.';

  @override
  String get downloadHistoryCleared => '다운로드 기록이 삭제되었습니다.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return '기록에서 ${count} 항목을 제거했습니다.';
  }

  @override
  String get downloadConnectionSlow => '연결 속도가 느려 다운로드에 실패했습니다. 다시 시도하려면 탭하세요.';

  @override
  String get downloadNetworkUnavailable =>
      '네트워크에 연결할 수 없습니다/CDN. 네트워크를 확인하고 다시 시도하세요.';

  @override
  String get downloadCancelled => '다운로드가 취소되었습니다.';

  @override
  String get downloadGenericError => '다운로드에 실패했습니다. 다시 시도하려면 탭하세요.';

  @override
  String downloadProgress(String percent) {
    return '콘텐츠 다운로드 중: ${percent}%';
  }
}
