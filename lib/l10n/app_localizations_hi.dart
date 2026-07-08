// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// The translations for hi (`hi`).
class AppLocalizationsHi extends AppLocalizationsEn {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'रद्द करना';

  @override
  String get save => 'बचाना';

  @override
  String get login => 'लॉग इन करें';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get understood => 'समझ गया';

  @override
  String get delete => 'मिटाना';

  @override
  String get deleteAll => 'सभी हटा दो';

  @override
  String get share => 'शेयर करना';

  @override
  String get download => 'डाउनलोड करना';

  @override
  String get downloadAgain => 'पुनः डाउनलोड करें';

  @override
  String get saved => 'डाउनलोड';

  @override
  String get loading => 'लोड हो रहा है';

  @override
  String get apply => 'आवेदन करना';

  @override
  String get frequentProfilesTitle => 'हाल ही में देखी गई प्रोफ़ाइलें';

  @override
  String get frequentProfilesEmptyTitle => 'अभी तक कोई प्रोफ़ाइल नहीं';

  @override
  String get frequentProfilesEmptyMessage =>
      'आपके द्वारा देखी गई प्रोफ़ाइलें यहां दिखाई देंगी.';

  @override
  String get account => 'खाता';

  @override
  String get downloadHistoryTitle => 'इतिहास डाउनलोड करें';

  @override
  String get downloadHistoryEmptyTitle => 'अभी तक कोई सामग्री नहीं है';

  @override
  String get downloadHistoryEmptyMessage =>
      'आपने अभी तक कोई सामग्री डाउनलोड नहीं की है';

  @override
  String selectedCount(int count) {
    return '${count}चयनित';
  }

  @override
  String get deleteAllHistoryTitle => 'सारा इतिहास हटा दें?';

  @override
  String get deleteAllHistoryMessage =>
      'आपके डाउनलोड इतिहास के सभी आइटम ऐप से हटा दिए जाएंगे।';

  @override
  String deleteSelectedTitle(int count) {
    return '${count} आइटम हटाएँ?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'चयनित आइटम आपके डाउनलोड इतिहास से हटा दिया जाएगा।';

  @override
  String deleteSelectedManyMessage(int count) {
    return '${count} चयनित आइटम आपके डाउनलोड इतिहास से हटा दिए जाएंगे।';
  }

  @override
  String get deleteOneTitle => 'यह आइटम हटाएं?';

  @override
  String get deleteOneMessage =>
      'यह आइटम आपके डाउनलोड इतिहास से हटा दिया जाएगा.';

  @override
  String get cannotShareFileMissing =>
      'साझा नहीं कर सकते. फ़ाइल अब इस डिवाइस पर मौजूद नहीं है.';

  @override
  String get cannotShareContent => 'इस सामग्री को साझा नहीं किया जा सकता.';

  @override
  String get cannotSaveAgainFileMissing =>
      'दोबारा सहेजा नहीं जा सकता. फ़ाइल अब इस डिवाइस पर मौजूद नहीं है.';

  @override
  String get savedAgainToGallery => 'गैलरी में पुनः सहेजा गया.';

  @override
  String get cannotSaveAgainContent =>
      'इस सामग्री को दोबारा सहेजा नहीं जा सकता.';

  @override
  String get cannotOpenFileMissing =>
      'इस सामग्री को नहीं खोला जा सकता. फ़ाइल अब इस डिवाइस पर मौजूद नहीं है.';

  @override
  String get video => 'वीडियो';

  @override
  String get image => 'तस्वीर';

  @override
  String get content => 'सामग्री';

  @override
  String get justDownloaded => 'अभी डाउनलोड किया गया';

  @override
  String get heroTitle => 'Instagram से सामग्री डाउनलोड करें';

  @override
  String get heroConnected => 'Instagram जुड़ा हुआ है।';

  @override
  String get heroDescription =>
      'फ़ोटो, रील और कहानियाँ जल्दी और आसानी से डाउनलोड करें।';

  @override
  String get downloadByLink => 'लिंक से डाउनलोड करें';

  @override
  String get invalidLinkTitle => 'अमान्य लिंक';

  @override
  String get invalidLinkMessage =>
      'कृपया उस पोस्ट, Reel, Story, या वीडियो के लिए Instagram लिंक दर्ज करें जिसे आप डाउनलोड करना चाहते हैं।';

  @override
  String get downloadByLinkInfo1 =>
      'इसका उपयोग तब करें जब आपके पास पहले से ही किसी Instagram पोस्ट, Reel, Story, या Highlight का लिंक हो।';

  @override
  String get downloadByLinkInfo2 =>
      'लिंक पेस्ट करें और ऐप सामग्री की जांच करेगा और आपको इसे डाउनलोड करने देगा।';

  @override
  String get example => 'उदाहरण:';

  @override
  String get enterInstagramLink => 'Instagram लिंक दर्ज करें';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... या /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'अपनी इच्छित सामग्री को जाँचने और डाउनलोड करने के लिए एक Instagram लिंक चिपकाएँ।';

  @override
  String get openInstagram => 'Instagramखोलें';

  @override
  String get getContent => 'सामग्री लो';

  @override
  String get explainFeature => 'विशेषता स्पष्ट करें';

  @override
  String get downloadFromProfile => 'प्रोफ़ाइल से डाउनलोड करें';

  @override
  String get invalidProfileTitle => 'अमान्य जानकारी';

  @override
  String get invalidProfileMessage =>
      'कृपया एक Instagram उपयोगकर्ता नाम या प्रोफ़ाइल लिंक दर्ज करें।';

  @override
  String get profileInfo1 =>
      'जब आप किसी Instagram खाते से एकाधिक आइटम देखना और डाउनलोड करना चाहते हैं तो इसका उपयोग करें।';

  @override
  String get profileInfo2 =>
      'एक उपयोगकर्ता नाम या प्रोफ़ाइल लिंक दर्ज करें, फिर वह Story, Reelया पोस्ट चुनें जिन्हें आप डाउनलोड करना चाहते हैं।';

  @override
  String get profileInputLabel => 'उपयोगकर्ता नाम या प्रोफ़ाइल लिंक';

  @override
  String get profileInputHint => 'उदाहरण: @username या instagram.com/username';

  @override
  String get profileCardDescription =>
      'डाउनलोड करने योग्य Stories, Reelऔर पोस्ट देखने के लिए एक उपयोगकर्ता नाम या प्रोफ़ाइल लिंक दर्ज करें।';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlightएस';

  @override
  String get reels => 'Reelएस';

  @override
  String get posts => 'पदों';

  @override
  String get photosPosts => 'तस्वीरें/पोस्ट';

  @override
  String get photosVideos => 'तस्वीरें/वीडियो';

  @override
  String get profileSummary => 'प्रोफ़ाइल सारांश';

  @override
  String get storyModeHint =>
      'डाउनलोड करने योग्य Stories और Highlight देखने के लिए एक प्रोफ़ाइल दर्ज करें।';

  @override
  String get reelsModeHint =>
      'Reelकी सूची देखने के लिए एक प्रोफ़ाइल दर्ज करें।';

  @override
  String get postsModeHint =>
      'डाउनलोड करने योग्य पोस्ट देखने के लिए एक प्रोफ़ाइल दर्ज करें।';

  @override
  String get storyPopupTitle => 'प्रोफ़ाइल से Stories डाउनलोड करें';

  @override
  String get reelsPopupTitle => 'प्रोफ़ाइल से Reelडाउनलोड करें';

  @override
  String get postsPopupTitle => 'प्रोफ़ाइल से पोस्ट डाउनलोड करें';

  @override
  String get viewStory => 'देखें Story';

  @override
  String get viewReels => 'Reelदेखें';

  @override
  String get viewPosts => 'पोस्ट देखें';

  @override
  String get noStoryOrHighlightAll =>
      'कोई Story या Highlight नहीं मिला। यदि सामग्री को देखने की अनुमति की आवश्यकता है तो लॉग इन करें।';

  @override
  String get noStoryOrHighlightInput =>
      'कोई Story या Highlight नहीं मिला। जाँच करने के लिए एक Instagram प्रोफ़ाइल दर्ज करें।';

  @override
  String get noStoryItems =>
      'प्रदर्शित करने के लिए कोई सामग्री नहीं है, या आपके पास इस आइटम को देखने की अनुमति नहीं है।';

  @override
  String get noFeedAll =>
      'कोई पोस्ट या वीडियो नहीं मिला. यदि सामग्री को देखने की अनुमति की आवश्यकता है तो लॉग इन करें।';

  @override
  String get noFeedInput =>
      'अभी तक कोई सामग्री नहीं है. Reelया पोस्ट चुनें, फिर एक प्रोफ़ाइल दर्ज करें।';

  @override
  String get endOfContent => 'आप सामग्री के अंत तक पहुंच गए हैं.';

  @override
  String get loadMore => 'और लोड करें';

  @override
  String get loadingMore => 'और अधिक लोड हो रहा है...';

  @override
  String get cannotShowPostContent =>
      'इस पोस्ट में सामग्री प्रदर्शित नहीं की जा सकती.';

  @override
  String get chooseItemToDownload => 'डाउनलोड करने के लिए कोई आइटम चुनें';

  @override
  String contentCount(int count) {
    return '${count}आइटम';
  }

  @override
  String get chooseThemeColor => 'थीम रंग चुनें';

  @override
  String get themeDefault => 'गलती करना';

  @override
  String get themeVivid => 'जीवंत';

  @override
  String get themePink => 'चमकदार गुलाबी';

  @override
  String get themeBlue => 'हल्का नीला रंग';

  @override
  String get themeRed => 'लाल';

  @override
  String get themeDark => 'अँधेरा';

  @override
  String get loginRequiredTitle => 'लॉगिन आवश्यक है';

  @override
  String get followRequiredTitle => 'पालन ​​आवश्यक है';

  @override
  String get followRequiredMessage =>
      'लॉग-इन किए गए खाते को इस सामग्री को देखने की अनुमति नहीं है।';

  @override
  String get downloadSuccessMessage => 'सफलतापूर्वक डाउनलोड किया गया.';

  @override
  String get viewHistory => 'इतिहास देखें';

  @override
  String get frequentAccessTooltip => 'बार-बार पहुंच';

  @override
  String get recentDownloadsTooltip => 'हाल के डाउनलोड';

  @override
  String get changeThemeTooltip => 'विषय को परिवर्तित करें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get themeSettingTitle => 'विषय';

  @override
  String get languageSettingTitle => 'भाषा';

  @override
  String get chooseLanguageTitle => 'अपनी भाषा चुनें';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'डाउनलोड मोड';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'आपका Instagram खाता कनेक्ट हो गया है.';

  @override
  String get sessionPrivatePrompt =>
      'आपके खाते को देखने की अनुमति वाली सामग्री डाउनलोड करने के लिए Instagram में लॉग इन करें।';

  @override
  String get sessionPublicPrompt =>
      'आप लॉग इन किए बिना सार्वजनिक सामग्री डाउनलोड कर रहे हैं।';

  @override
  String get profileReelsListTitle => 'Reel वीडियो सूची';

  @override
  String get profilePostsListTitle => 'फोटो/पोस्ट सूची';

  @override
  String get close => 'बंद करना';

  @override
  String get instagramHome => 'Instagram घर';

  @override
  String get selectThisContent => 'इस सामग्री का चयन करें';

  @override
  String get manualOpeningInstagram => 'खुल रहा है...';

  @override
  String get manualInstruction =>
      'वह पोस्ट खोलें, Reel, Story, या Highlight जिसे आप डाउनलोड करना चाहते हैं, फिर "इस सामग्री का चयन करें" पर टैप करें।';

  @override
  String get manualPickedContent =>
      'सामग्री चयनित. जारी रखने के लिए "इस सामग्री का चयन करें" पर टैप करें।';

  @override
  String get manualNoDownloadableContent =>
      'कोई डाउनलोड करने योग्य सामग्री नहीं मिली. कोई पोस्ट खोलें, Reel, Story, या Highlight।';

  @override
  String get manualCloseToExit =>
      'चयनित सामग्री को खोने से बचाने के लिए, यदि आप बाहर निकलना चाहते हैं तो "बंद करें" पर टैप करें।';

  @override
  String get loginOpeningInstagram =>
      'खुल रहा है Instagram... कृपया प्रतीक्षा करें।';

  @override
  String get loginInstruction =>
      'Instagram में लॉग इन करें, फिर समाप्त करने के लिए "सहेजें" पर टैप करें।';

  @override
  String get loginChecking => 'लॉगिन जांचा जा रहा है...';

  @override
  String get loginCannotConfirm =>
      'लॉगिन की पुष्टि नहीं की जा सकती.\nकृपया Instagram में लॉग इन करें और पुनः सहेजने का प्रयास करें।';

  @override
  String get loginSaveError =>
      'लॉगिन जानकारी सहेजते समय एक त्रुटि उत्पन्न हुई. कृपया पुन: प्रयास करें।';

  @override
  String get loginLoggingOut => 'लॉग आउट हो रहा है...';

  @override
  String get loginLoggedOut =>
      'आपने Instagram से लॉग आउट कर दिया है।\nजारी रखने के लिए कृपया दोबारा लॉग इन करें।';

  @override
  String get loginSuccessPrompt =>
      'लॉग इन सफल।\nसमाप्त करने के लिए "सहेजें" पर टैप करें।';

  @override
  String get loginPromptOnLoginPage =>
      'Instagram में लॉग इन करें, फिर समाप्त करने के लिए "सहेजें" पर टैप करें।';

  @override
  String get loginPromptSaveBottom =>
      'यदि आपने लॉग इन करना समाप्त कर लिया है, तो नीचे "सहेजें" पर टैप करें।';

  @override
  String get loginPageTitle => 'Instagram में लॉग इन करें';

  @override
  String get loginOpeningInstagramWithHint =>
      'खुल रहा है...\nलॉग इन करने के बाद, "सहेजें" पर टैप करें।';

  @override
  String get loginOpenFailed =>
      'Instagram नहीं खुल सकता।\nअपने इंटरनेट कनेक्शन की जाँच करें और पुन: प्रयास करें।';

  @override
  String get profileSavedMissingUsername =>
      'सहेजी गई प्रोफ़ाइल में उपयोगकर्ता नाम गुम है.';

  @override
  String get openingProfile => 'प्रोफ़ाइल खुल रही है...';

  @override
  String openingUsername(String username) {
    return 'खुल रहा है @${username}...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return '${storyCount} Story/Highlight आइटम और ${postCount} पोस्ट मिले।';
  }

  @override
  String get privateModeEnabled => 'Privateमोड सक्षम।';

  @override
  String get publicModeEnabled => 'Public मोड पर वापस स्विच किया गया।';

  @override
  String get cannotConfirmInstagramLogin =>
      'Instagram लॉगिन की पुष्टि नहीं कर सकता। कृपया फिर भाग लें।';

  @override
  String get instagramConnected => 'Instagram खाता जुड़ा हुआ है.';

  @override
  String get loggingOutInstagram => 'Instagram से लॉग आउट हो रहा है...';

  @override
  String get instagramLoggedOut => 'आपने Instagram से लॉग आउट कर दिया है।';

  @override
  String get instagramLogoutCleanupFailed =>
      'Instagram से लॉग आउट हो गया, लेकिन लॉगिन डेटा साफ़ करने में त्रुटि हुई।';

  @override
  String get emptyInstagramLink => 'कृपया एक Instagram लिंक दर्ज करें।';

  @override
  String get preparingContent => 'सामग्री तैयार की जा रही है...';

  @override
  String get loadingContentWithAccount =>
      'कनेक्टेड खाते से सामग्री लोड हो रही है...';

  @override
  String get cannotFetchContent => 'सामग्री नहीं लायी जा सकी.';

  @override
  String get noDownloadableContentFound =>
      'कोई डाउनलोड करने योग्य सामग्री नहीं मिली.';

  @override
  String foundDownloadableContent(int count) {
    return '${count} डाउनलोड करने योग्य आइटम मिले।';
  }

  @override
  String get fetchContentFailedPublic =>
      'सामग्री नहीं लायी जा सकी. कृपया लिंक की जाँच करें या पुनः प्रयास करें।';

  @override
  String get fetchContentFailedPrivate =>
      'सामग्री नहीं लायी जा सकी. कृपया देखने की अनुमति जांचें या फिर से लॉग इन करें।';

  @override
  String get emptyProfileInput => 'कृपया एक Instagram प्रोफ़ाइल दर्ज करें।';

  @override
  String get loadingStoryHighlights => 'लोड हो रहा है Stories और Highlight...';

  @override
  String get noCurrentStoryOrHighlight =>
      'कोई वर्तमान कहानी या हाइलाइट नहीं मिला.';

  @override
  String foundStoryHighlights(int count) {
    return '${count} Story/Highlight आइटम मिले।';
  }

  @override
  String get cannotOpenContent => 'इस सामग्री को नहीं खोला जा सकता.';

  @override
  String openingStoryGroup(String title) {
    return '"${title}" खुल रहा है...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '"${title}" में ${count} आइटम मिले।';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Story या Highlight नहीं खुल सकता। कृपया पुनः लॉगिन करें और पुनः प्रयास करें।';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Story या Highlight नहीं खुल सकता। कृपया देखने की अनुमति जांचें.';

  @override
  String get cannotDownloadContent =>
      'इस सामग्री को डाउनलोड नहीं किया जा सकता.';

  @override
  String get downloadingStory => 'कहानी डाउनलोड हो रही है...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'कहानी आइटम को एल्बम में सहेजा गया ${albumName}.';
  }

  @override
  String get downloadStoryFailed =>
      'Story डाउनलोड विफल रहा. कृपया पुन: प्रयास करें।';

  @override
  String get loadingReelsPublic => 'रीलें लायी जा रही हैं...';

  @override
  String get loadingReelsPrivate => 'रीलें लोड हो रही हैं...';

  @override
  String get noReelsOrPermission =>
      'कोई Reelनहीं मिला, या आपके पास उन्हें देखने की अनुमति नहीं है।';

  @override
  String foundReels(int count) {
    return '${count} Reelमिले।';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Reels लोड नहीं कर सकता. कृपया प्रोफ़ाइल जांचें या पुनः प्रयास करें।';

  @override
  String get cannotLoadReelsPrivate =>
      'Reels लोड नहीं कर सकता. कृपया देखने की अनुमति जांचें.';

  @override
  String get loadingPostsPublic => 'फ़ोटो/पोस्ट लाये जा रहे हैं...';

  @override
  String get loadingPostsPrivate => 'फ़ोटो/पोस्ट लोड हो रहे हैं...';

  @override
  String get noPostsOrPermission =>
      'कोई फ़ोटो/पोस्ट नहीं मिला, या आपके पास उन्हें देखने की अनुमति नहीं है।';

  @override
  String foundPosts(int count) {
    return '${count} फ़ोटो/पोस्ट मिले।';
  }

  @override
  String get cannotLoadPostsPublic =>
      'पोस्ट लोड नहीं कर सकते. कृपया प्रोफ़ाइल जांचें या पुनः प्रयास करें।';

  @override
  String get cannotLoadPostsPrivate =>
      'पोस्ट लोड नहीं कर सकते. कृपया देखने की अनुमति जांचें.';

  @override
  String get cannotLoadMoreContent => 'अधिक सामग्री लोड नहीं की जा सकती.';

  @override
  String get cannotLoadMoreProfile =>
      'इससे अधिक लोड नहीं किया जा सकता. कृपया प्रोफ़ाइल दोबारा दर्ज करें.';

  @override
  String get noMoreNewContent => 'कोई और नई सामग्री नहीं.';

  @override
  String loadedMoreContent(int count) {
    return '${count} अधिक आइटम लोड किए गए।';
  }

  @override
  String get loadMoreFailed => 'अधिक लोड विफल रहा. कृपया पुन: प्रयास करें।';

  @override
  String get openingReel => 'खुल रहा है...';

  @override
  String get openingPost => 'प्रारंभिक पोस्ट...';

  @override
  String get cannotOpenContentPermission =>
      'इस सामग्री को नहीं खोला जा सकता. कृपया देखने की अनुमति जांचें या पुनः प्रयास करें।';

  @override
  String get downloadingContent => 'सामग्री डाउनलोड हो रही है...';

  @override
  String savedToAlbum(String albumName) {
    return 'एल्बम में सहेजा गया ${albumName}.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'सामग्री को एल्बम ${albumName} में सहेजा गया।';
  }

  @override
  String get downloadContentErrorRetry =>
      'सामग्री डाउनलोड विफल रहा. पुनः प्रयास करने के लिए टैप करें.';

  @override
  String get downloadHistoryCleared => 'डाउनलोड इतिहास साफ़ किया गया.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'इतिहास से ${count} आइटम हटा दिए गए।';
  }

  @override
  String get downloadConnectionSlow =>
      'धीमे कनेक्शन के कारण डाउनलोड विफल रहा. पुनः प्रयास करने के लिए टैप करें.';

  @override
  String get downloadNetworkUnavailable =>
      'नेटवर्क/CDN से कनेक्ट नहीं हो सकता। अपना नेटवर्क जाँचें और पुनः प्रयास करें।';

  @override
  String get downloadCancelled => 'डाउनलोड रद्द किया गया।';

  @override
  String get downloadGenericError =>
      'डाउनलोड विफल रहा। पुनः प्रयास करने के लिए टैप करें।';

  @override
  String downloadProgress(String percent) {
    return 'सामग्री डाउनलोड करना: ${percent}%';
  }
}
