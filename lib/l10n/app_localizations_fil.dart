// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get save => 'I-save';

  @override
  String get login => 'Mag-log in';

  @override
  String get logout => 'Log out';

  @override
  String get understood => 'Nakuha ko';

  @override
  String get delete => 'Tanggalin';

  @override
  String get deleteAll => 'Tanggalin lahat';

  @override
  String get share => 'Ibahagi';

  @override
  String get download => 'I-download';

  @override
  String get downloadAgain => 'I-download muli';

  @override
  String get saved => 'Na-download';

  @override
  String get loading => 'Naglo-load';

  @override
  String get apply => 'Mag-apply';

  @override
  String get frequentProfilesTitle => 'Kamakailang tiningnang mga profile';

  @override
  String get frequentProfilesEmptyTitle => 'Wala pang mga profile';

  @override
  String get frequentProfilesEmptyMessage =>
      'Lalabas dito ang mga profile na iyong tiningnan.';

  @override
  String get account => 'Account';

  @override
  String get downloadHistoryTitle => 'Kasaysayan ng pag-download';

  @override
  String get downloadHistoryEmptyTitle => 'Wala pang nilalaman';

  @override
  String get downloadHistoryEmptyMessage =>
      'Hindi ka pa nagda-download ng anumang nilalaman';

  @override
  String selectedCount(int count) {
    return '$count napili';
  }

  @override
  String get deleteAllHistoryTitle => 'Tanggalin ang lahat ng kasaysayan?';

  @override
  String get deleteAllHistoryMessage =>
      'Aalisin sa app ang lahat ng item sa iyong history ng pag-download.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Tanggalin ang $count item?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Ang napiling item ay aalisin sa iyong kasaysayan ng pag-download.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count aalisin ang mga napiling item mula sa iyong kasaysayan ng pag-download.';
  }

  @override
  String get deleteOneTitle => 'Tanggalin ang item na ito?';

  @override
  String get deleteOneMessage =>
      'Aalisin ang item na ito sa iyong history ng pag-download.';

  @override
  String get cannotShareFileMissing =>
      'Hindi maibahagi. Wala na ang file sa device na ito.';

  @override
  String get cannotShareContent => 'Hindi maibabahagi ang nilalamang ito.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Hindi na muling makapag-save. Wala na ang file sa device na ito.';

  @override
  String get savedAgainToGallery => 'Na-save muli sa gallery.';

  @override
  String get cannotSaveAgainContent => 'Hindi ma-save muli ang nilalamang ito.';

  @override
  String get cannotOpenFileMissing =>
      'Hindi mabuksan ang nilalamang ito. Wala na ang file sa device na ito.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Larawan';

  @override
  String get content => 'Nilalaman';

  @override
  String get justDownloaded => 'Kakadownload lang';

  @override
  String get heroTitle => 'Mag-download ng nilalaman mula sa Instagram';

  @override
  String get heroConnected => 'Instagram ay konektado.';

  @override
  String get heroDescription =>
      'Mag-download ng mga larawan, reel, at kwento nang mabilis at madali.';

  @override
  String get downloadByLink => 'I-download sa pamamagitan ng link';

  @override
  String get invalidLinkTitle => 'Di-wastong link';

  @override
  String get invalidLinkMessage =>
      'Pakipasok ang Instagram link para sa post, Reel, Story, o video na gusto mong i-download.';

  @override
  String get downloadByLinkInfo1 =>
      'Gamitin ito kapag mayroon ka nang link sa isang Instagram post, Reel, Story, o Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'I-paste ang link at susuriin ng app ang nilalaman at hahayaan kang i-download ito.';

  @override
  String get example => 'Halimbawa:';

  @override
  String get enterInstagramLink => 'Ipasok ang Instagram link';

  @override
  String get instagramLinkHint => 'https://www.instagram.com/p/... o /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Mag-paste ng Instagram link upang suriin at i-download ang nilalamang gusto mo.';

  @override
  String get openInstagram => 'Buksan Instagram';

  @override
  String get getContent => 'Kumuha ng nilalaman';

  @override
  String get explainFeature => 'Ipaliwanag ang katangian';

  @override
  String get downloadFromProfile => 'I-download mula sa profile';

  @override
  String get invalidProfileTitle => 'Di-wastong impormasyon';

  @override
  String get invalidProfileMessage =>
      'Mangyaring magpasok ng Instagram username o profile link.';

  @override
  String get profileInfo1 =>
      'Gamitin ito kapag gusto mong tingnan at i-download ang maramihang mga item mula sa isang Instagram account.';

  @override
  String get profileInfo2 =>
      'Maglagay ng username o profile link, pagkatapos ay piliin ang Story, Reels, o mga post na gusto mong i-download.';

  @override
  String get profileInputLabel => 'Username o profile link';

  @override
  String get profileInputHint =>
      'Halimbawa: @username o instagram.com/username';

  @override
  String get profileCardDescription =>
      'Maglagay ng username o profile link upang tingnan ang mga nada-download na Stories, Reels, at mga post.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Mga post';

  @override
  String get photosPosts => 'Mga Larawan / Mga Post';

  @override
  String get photosVideos => 'Mga Larawan / Video';

  @override
  String get profileSummary => 'Buod ng profile';

  @override
  String get storyModeHint =>
      'Magpasok ng profile para tingnan ang mga nada-download na Stories at Highlights.';

  @override
  String get reelsModeHint =>
      'Magpasok ng profile upang tingnan ang listahan ng Reels.';

  @override
  String get postsModeHint =>
      'Maglagay ng profile para tingnan ang mga nada-download na post.';

  @override
  String get storyPopupTitle => 'I-download ang Stories mula sa profile';

  @override
  String get reelsPopupTitle => 'I-download ang Reels mula sa profile';

  @override
  String get postsPopupTitle => 'Mag-download ng mga post mula sa profile';

  @override
  String get viewStory => 'Tingnan Story';

  @override
  String get viewReels => 'Tingnan ang mga Reels';

  @override
  String get viewPosts => 'Tingnan ang mga post';

  @override
  String get noStoryOrHighlightAll =>
      'Walang Story o Highlight nahanap. Mag-log in kung ang nilalaman ay nangangailangan ng pahintulot sa pagtingin.';

  @override
  String get noStoryOrHighlightInput =>
      'Walang Story o Highlight nahanap. Maglagay ng Instagram profile upang suriin.';

  @override
  String get noStoryItems =>
      'Walang ipapakitang nilalaman, o wala kang pahintulot na tingnan ang item na ito.';

  @override
  String get noFeedAll =>
      'Walang nakitang mga post o video. Mag-log in kung ang nilalaman ay nangangailangan ng pahintulot sa pagtingin.';

  @override
  String get noFeedInput =>
      'Wala pang nilalaman. Piliin ang Reels o Posts, pagkatapos ay magpasok ng profile.';

  @override
  String get endOfContent => 'Naabot mo na ang dulo ng nilalaman.';

  @override
  String get loadMore => 'Mag-load pa';

  @override
  String get loadingMore => 'Naglo-load ng higit pa...';

  @override
  String get cannotShowPostContent =>
      'Hindi maipakita ang nilalaman sa post na ito.';

  @override
  String get chooseItemToDownload => 'Pumili ng item na ida-download';

  @override
  String contentCount(int count) {
    return '$count aytem';
  }

  @override
  String get chooseThemeColor => 'Pumili ng kulay ng tema';

  @override
  String get themeDefault => 'Default';

  @override
  String get themeVivid => 'Matingkad';

  @override
  String get themePink => 'Makintab na kulay rosas';

  @override
  String get themeBlue => 'Banayad na asul';

  @override
  String get themeRed => 'Pula';

  @override
  String get themeDark => 'Madilim';

  @override
  String get loginRequiredTitle => 'Kinakailangan ang pag-login';

  @override
  String get followRequiredTitle => 'Kailangang sundin';

  @override
  String get followRequiredMessage =>
      'Ang naka-log-in na account ay walang pahintulot na tingnan ang nilalamang ito.';

  @override
  String get downloadSuccessMessage => 'Matagumpay na na-download.';

  @override
  String get viewHistory => 'Tingnan ang kasaysayan';

  @override
  String get frequentAccessTooltip => 'Madalas na pag-access';

  @override
  String get recentDownloadsTooltip => 'Mga kamakailang pag-download';

  @override
  String get changeThemeTooltip => 'Baguhin ang tema';

  @override
  String get settingsTitle => 'Mga setting';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Wika';

  @override
  String get chooseLanguageTitle => 'Piliin ang iyong wika';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

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
  String get sessionPrivateConnected =>
      'Nakakonekta ang iyong Instagram account.';

  @override
  String get sessionPrivatePrompt =>
      'Mag-log in sa Instagram upang mag-download ng nilalamang pinapayagang tingnan ng iyong account.';

  @override
  String get sessionPublicPrompt =>
      'Nagda-download ka ng pampublikong nilalaman nang hindi nagla-log in.';

  @override
  String get profileReelsListTitle => 'Reel listahan ng video';

  @override
  String get profilePostsListTitle => 'Larawan / Listahan ng post';

  @override
  String get close => 'Isara';

  @override
  String get instagramHome => 'Instagram bahay';

  @override
  String get selectThisContent => 'Piliin ang nilalamang ito';

  @override
  String get manualOpeningInstagram => 'Pagbubukas Instagram...';

  @override
  String get manualInstruction =>
      'Buksan ang post, Reel, Story, o Highlight gusto mong i-download, pagkatapos ay tapikin ang \"Piliin ang nilalamang ito\".';

  @override
  String get manualPickedContent =>
      'Napili ang nilalaman. I-tap ang \"Piliin ang nilalamang ito\" para magpatuloy.';

  @override
  String get manualNoDownloadableContent =>
      'Walang nakitang nada-download na nilalaman. Magbukas ng post, Reel, Story, o Highlight.';

  @override
  String get manualCloseToExit =>
      'Para maiwasang mawala ang napiling content, i-tap ang \"Isara\" kung gusto mong lumabas.';

  @override
  String get loginOpeningInstagram =>
      'Binubuksan Instagram... Mangyaring maghintay.';

  @override
  String get loginInstruction =>
      'Mag-log in sa Instagram, pagkatapos ay i-tap ang \"I-save\" upang matapos.';

  @override
  String get loginChecking => 'Sinusuri ang pag-login...';

  @override
  String get loginCannotConfirm =>
      'Hindi makumpirma ang pag-login.\nMangyaring mag-log in sa Instagram at subukang mag-save muli.';

  @override
  String get loginSaveError =>
      'Nagkaroon ng error habang sine-save ang impormasyon sa pag-log in. Pakisubukang muli.';

  @override
  String get loginLoggingOut => 'Nagla-log out...';

  @override
  String get loginLoggedOut =>
      'Nag-log out ka sa Instagram.\nMangyaring mag-log in muli upang magpatuloy.';

  @override
  String get loginSuccessPrompt =>
      'Matagumpay ang pag-log in.\nI-tap ang \"I-save\" para matapos.';

  @override
  String get loginPromptOnLoginPage =>
      'Mag-log in sa Instagram, pagkatapos ay i-tap ang \"I-save\" upang matapos.';

  @override
  String get loginPromptSaveBottom =>
      'Kung tapos ka nang mag-log in, i-tap ang \"I-save\" sa ibaba.';

  @override
  String get loginPageTitle => 'Mag-log in sa Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Pagbubukas Instagram...\nPagkatapos mag-log in, i-tap ang \"I-save\".';

  @override
  String get loginOpenFailed =>
      'Hindi mabuksan Instagram.\nPakisuri ang iyong koneksyon sa internet at subukang muli.';

  @override
  String get profileSavedMissingUsername =>
      'Walang username ang naka-save na profile.';

  @override
  String get openingProfile => 'Binubuksan ang profile...';

  @override
  String openingUsername(String username) {
    return 'Binubuksan ang @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Nakahanap ng $storyCount Story/Highlight item at $postCount post.';
  }

  @override
  String get privateModeEnabled => 'Pinagana ang Private mode.';

  @override
  String get publicModeEnabled => 'Bumalik sa Public mode.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Hindi makumpirma ang Instagram login. Mangyaring mag-log in muli.';

  @override
  String get instagramConnected => 'Instagram nakakonekta ang account.';

  @override
  String get loggingOutInstagram => 'Nagla-log out sa Instagram...';

  @override
  String get instagramLoggedOut => 'Nag-log out ka sa Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Nag-log out sa Instagram, ngunit nagkaroon ng error sa pag-clear ng data sa pag-log in.';

  @override
  String get emptyInstagramLink => 'Mangyaring magpasok ng Instagram link.';

  @override
  String get preparingContent => 'Inihahanda ang nilalaman...';

  @override
  String get loadingContentWithAccount =>
      'Naglo-load ng content gamit ang konektadong account...';

  @override
  String get cannotFetchContent => 'Hindi makakuha ng nilalaman.';

  @override
  String get noDownloadableContentFound =>
      'Walang nakitang nada-download na nilalaman.';

  @override
  String foundDownloadableContent(int count) {
    return 'Nakakita ng $count nada-download na mga item.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Hindi makakuha ng nilalaman. Pakisuri ang link o subukang muli.';

  @override
  String get fetchContentFailedPrivate =>
      'Hindi makakuha ng nilalaman. Mangyaring suriin ang pahintulot sa pagtingin o mag-log in muli.';

  @override
  String get emptyProfileInput => 'Mangyaring magpasok ng Instagram profile.';

  @override
  String get loadingStoryHighlights => 'Naglo-load ng Stories at Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Walang nakitang kasalukuyang kwento o highlight.';

  @override
  String foundStoryHighlights(int count) {
    return 'Nakakita ng $count Story/Highlight item.';
  }

  @override
  String get cannotOpenContent => 'Hindi mabuksan ang nilalamang ito.';

  @override
  String openingStoryGroup(String title) {
    return 'Binubuksan ang \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Nakakita ng $count aytem sa \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Hindi mabuksan ang Story o Highlight. Mangyaring mag-log in at subukang muli.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Hindi mabuksan ang Story o Highlight. Pakitingnan ang pahintulot sa panonood.';

  @override
  String get cannotDownloadContent => 'Hindi ma-download ang nilalamang ito.';

  @override
  String get downloadingStory => 'Nagda-download ng kuwento...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Nai-save na item ng kuwento sa album $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story Nabigo ang pag-download. Pakisubukang muli.';

  @override
  String get loadingReelsPublic => 'Pagkuha ng mga reel...';

  @override
  String get loadingReelsPrivate => 'Naglo-load ng mga reel...';

  @override
  String get noReelsOrPermission =>
      'Walang nakitang Reel, o wala kang pahintulot na tingnan ang mga ito.';

  @override
  String foundReels(int count) {
    return 'Nakahanap ng $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Hindi ma-load ang mga Reel. Pakisuri ang profile o subukang muli.';

  @override
  String get cannotLoadReelsPrivate =>
      'Hindi ma-load ang mga Reels. Pakitingnan ang pahintulot sa panonood.';

  @override
  String get loadingPostsPublic => 'Pagkuha ng mga larawan/post...';

  @override
  String get loadingPostsPrivate => 'Naglo-load ng mga larawan/post...';

  @override
  String get noPostsOrPermission =>
      'Walang nakitang mga larawan/post, o wala kang pahintulot na tingnan ang mga ito.';

  @override
  String foundPosts(int count) {
    return 'Nakahanap ng $count mga larawan/post.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Hindi ma-load ang mga post. Pakisuri ang profile o subukang muli.';

  @override
  String get cannotLoadPostsPrivate =>
      'Hindi ma-load ang mga post. Pakitingnan ang pahintulot sa panonood.';

  @override
  String get cannotLoadMoreContent =>
      'Hindi makapag-load ng higit pang nilalaman.';

  @override
  String get cannotLoadMoreProfile =>
      'Hindi makapag-load ng higit pa. Mangyaring ipasok muli ang profile.';

  @override
  String get noMoreNewContent => 'Wala nang bagong nilalaman.';

  @override
  String loadedMoreContent(int count) {
    return 'Nag-load ng $count higit pang mga item.';
  }

  @override
  String get loadMoreFailed => 'Nabigo ang pag-load. Pakisubukang muli.';

  @override
  String get openingReel => 'Pagbubukas Reel...';

  @override
  String get openingPost => 'Pagbubukas ng post...';

  @override
  String get cannotOpenContentPermission =>
      'Hindi mabuksan ang nilalamang ito. Pakitingnan ang pahintulot sa panonood o subukang muli.';

  @override
  String get downloadingContent => 'Pag-download ng nilalaman...';

  @override
  String savedToAlbum(String albumName) {
    return 'Naka-save sa album $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Naka-save na nilalaman sa album $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Nabigo ang pag-download ng nilalaman. I-tap para subukang muli.';

  @override
  String get downloadHistoryCleared => 'Na-clear ang history ng pag-download.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Inalis ang $count item sa history.';
  }

  @override
  String get downloadConnectionSlow =>
      'Nabigo ang pag-download dahil sa mabagal na koneksyon. I-tap para subukang muli.';

  @override
  String get downloadNetworkUnavailable =>
      'Hindi makakonekta sa network/CDN. Suriin ang iyong network at subukang muli.';

  @override
  String get downloadCancelled => 'Nakansela ang pag-download.';

  @override
  String get downloadGenericError =>
      'Nabigo ang pag-download. I-tap para subukang muli.';

  @override
  String downloadProgress(String percent) {
    return 'Nagda-download ng content: $percent%';
  }

  @override
  String get legalLinksTitle => 'Patakaran sa Privacy at Mga Tuntunin';

  @override
  String get termsOfUse => 'Mga Tuntunin ng Paggamit';

  @override
  String get privacyPolicy => 'Patakaran sa Privacy';
}
