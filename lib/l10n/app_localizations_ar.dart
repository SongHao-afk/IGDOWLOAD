// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get understood => 'فهمتها';

  @override
  String get delete => 'حذف';

  @override
  String get deleteAll => 'حذف الكل';

  @override
  String get share => 'مشاركة';

  @override
  String get download => 'تنزيل';

  @override
  String get downloadAgain => 'قم بالتنزيل مرة أخرى';

  @override
  String get saved => 'تم التنزيل';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get apply => 'تطبيق';

  @override
  String get frequentProfilesTitle => 'الملفات الشخصية التي تم عرضها مؤخرًا';

  @override
  String get frequentProfilesEmptyTitle => 'لا توجد ملفات شخصية حتى الآن';

  @override
  String get frequentProfilesEmptyMessage =>
      'ستظهر الملفات الشخصية التي شاهدتها هنا.';

  @override
  String get account => 'حساب';

  @override
  String get downloadHistoryTitle => 'تنزيل التاريخ';

  @override
  String get downloadHistoryEmptyTitle => 'لا يوجد محتوى بعد';

  @override
  String get downloadHistoryEmptyMessage => 'لم تقم بتحميل أي محتوى حتى الآن';

  @override
  String selectedCount(int count) {
    return '$count مختارة';
  }

  @override
  String get deleteAllHistoryTitle => 'هل تريد حذف السجل بأكمله؟';

  @override
  String get deleteAllHistoryMessage =>
      'ستتم إزالة كافة العناصر الموجودة في سجل التنزيل الخاص بك من التطبيق.';

  @override
  String deleteSelectedTitle(int count) {
    return 'حذف $count العناصر؟';
  }

  @override
  String get deleteSelectedOneMessage =>
      'ستتم إزالة العنصر المحدد من سجل التنزيل الخاص بك.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count ستتم إزالة العناصر المحددة من سجل التنزيل الخاص بك.';
  }

  @override
  String get deleteOneTitle => 'هل تريد حذف هذا العنصر؟';

  @override
  String get deleteOneMessage =>
      'ستتم إزالة هذا العنصر من سجل التنزيل الخاص بك.';

  @override
  String get cannotShareFileMissing =>
      'لا يمكن المشاركة. الملف لم يعد موجودا على هذا الجهاز.';

  @override
  String get cannotShareContent => 'لا يمكن مشاركة هذا المحتوى.';

  @override
  String get cannotSaveAgainFileMissing =>
      'لا يمكن الحفظ مرة أخرى. الملف لم يعد موجودا على هذا الجهاز.';

  @override
  String get savedAgainToGallery => 'تم الحفظ مرة أخرى في المعرض.';

  @override
  String get cannotSaveAgainContent => 'لا يمكن حفظ هذا المحتوى مرة أخرى.';

  @override
  String get cannotOpenFileMissing =>
      'لا يمكن فتح هذا المحتوى. الملف لم يعد موجودا على هذا الجهاز.';

  @override
  String get video => 'فيديو';

  @override
  String get image => 'صورة';

  @override
  String get content => 'محتوى';

  @override
  String get justDownloaded => 'تم تنزيله للتو';

  @override
  String get heroTitle => 'قم بتنزيل المحتوى من Instagram';

  @override
  String get heroConnected => 'Instagram متصل.';

  @override
  String get heroDescription => 'قم بتنزيل الصور والبكرات والقصص بسرعة وسهولة.';

  @override
  String get downloadByLink => 'تحميل عن طريق الرابط';

  @override
  String get invalidLinkTitle => 'رابط غير صالح';

  @override
  String get invalidLinkMessage =>
      'يرجى إدخال الرابط Instagram للمنشور أو Reel أو Story أو الفيديو الذي تريد تنزيله.';

  @override
  String get downloadByLinkInfo1 =>
      'استخدم هذا عندما يكون لديك بالفعل رابط إلى منشور أو Reel أو Story أو Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'الصق الرابط وسيقوم التطبيق بالتحقق من المحتوى ويتيح لك تنزيله.';

  @override
  String get example => 'مثال:';

  @override
  String get enterInstagramLink => 'أدخل الرابط';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... أو /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'الصق رابط Instagram للتحقق من المحتوى الذي تريده وتنزيله.';

  @override
  String get openInstagram => 'افتح Instagram';

  @override
  String get getContent => 'احصل على المحتوى';

  @override
  String get explainFeature => 'شرح الميزة';

  @override
  String get downloadFromProfile => 'تحميل من الملف الشخصي';

  @override
  String get invalidProfileTitle => 'معلومات غير صالحة';

  @override
  String get invalidProfileMessage =>
      'الرجاء إدخال اسم المستخدم أو رابط الملف الشخصي.';

  @override
  String get profileInfo1 =>
      'استخدم هذا عندما تريد عرض وتنزيل عناصر متعددة من حساب Instagram.';

  @override
  String get profileInfo2 =>
      'أدخل اسم المستخدم أو رابط الملف الشخصي، ثم اختر Story أو Reels أو المنشورات التي تريد تنزيلها.';

  @override
  String get profileInputLabel => 'اسم المستخدم أو رابط الملف الشخصي';

  @override
  String get profileInputHint => 'مثال: @username أو instagram.com/username';

  @override
  String get profileCardDescription =>
      'أدخل اسم مستخدم أو رابط ملف تعريف لعرض Stories، Reels، والمشاركات القابلة للتنزيل.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'القصص والقصص المميزة';

  @override
  String get reels => 'مقاطع Reels';

  @override
  String get posts => 'المنشورات';

  @override
  String get photosPosts => 'الصور / المشاركات';

  @override
  String get photosVideos => 'صور / فيديو';

  @override
  String get profileSummary => 'ملخص الملف الشخصي';

  @override
  String get storyModeHint =>
      'أدخل ملف تعريف لعرض Stories وHighlights القابلة للتنزيل.';

  @override
  String get reelsModeHint => 'أدخل ملف تعريف لعرض القائمة.';

  @override
  String get postsModeHint =>
      'أدخل ملفًا شخصيًا لعرض المشاركات القابلة للتنزيل.';

  @override
  String get storyPopupTitle => 'تحميل Stories من الملف الشخصي';

  @override
  String get reelsPopupTitle => 'قم بتنزيله من الملف الشخصي';

  @override
  String get postsPopupTitle => 'تنزيل المشاركات من الملف الشخصي';

  @override
  String get viewStory => 'عرض Story';

  @override
  String get viewReels => 'عرض Reels';

  @override
  String get viewPosts => 'عرض المشاركات';

  @override
  String get noStoryOrHighlightAll =>
      'لم يتم العثور على Story أو Highlight. قم بتسجيل الدخول إذا كان المحتوى يتطلب إذن المشاهدة.';

  @override
  String get noStoryOrHighlightInput =>
      'لم يتم العثور على Story أو Highlight. أدخل ملف تعريف Instagram للتحقق.';

  @override
  String get noStoryItems =>
      'لا يوجد محتوى لعرضه، أو ليس لديك الإذن لعرض هذا العنصر.';

  @override
  String get noFeedAll =>
      'لم يتم العثور على أي مشاركات أو مقاطع فيديو. قم بتسجيل الدخول إذا كان المحتوى يتطلب إذن المشاهدة.';

  @override
  String get noFeedInput =>
      'لا يوجد محتوى بعد. اختر Reels أو المنشورات، ثم أدخل ملف التعريف.';

  @override
  String get endOfContent => 'لقد وصلت إلى نهاية المحتوى.';

  @override
  String get loadMore => 'تحميل المزيد';

  @override
  String get loadingMore => 'جارٍ تحميل المزيد...';

  @override
  String get cannotShowPostContent => 'لا يمكن عرض المحتوى في هذه المشاركة.';

  @override
  String get chooseItemToDownload => 'اختر عنصرًا لتنزيله';

  @override
  String contentCount(int count) {
    return '$count العناصر';
  }

  @override
  String get chooseThemeColor => 'اختر لون الموضوع';

  @override
  String get themeDefault => 'تقصير';

  @override
  String get themeVivid => 'واضح';

  @override
  String get themePink => 'وردي لامع';

  @override
  String get themeBlue => 'أزرق فاتح';

  @override
  String get themeRed => 'أحمر';

  @override
  String get themeDark => 'مظلم';

  @override
  String get loginRequiredTitle => 'تسجيل الدخول مطلوب';

  @override
  String get followRequiredTitle => 'متابعة مطلوبة';

  @override
  String get followRequiredMessage =>
      'الحساب الذي تم تسجيل الدخول إليه ليس لديه إذن لعرض هذا المحتوى.';

  @override
  String get downloadSuccessMessage => 'تم التنزيل بنجاح.';

  @override
  String get viewHistory => 'عرض التاريخ';

  @override
  String get frequentAccessTooltip => 'الوصول المتكرر';

  @override
  String get recentDownloadsTooltip => 'التنزيلات الأخيرة';

  @override
  String get changeThemeTooltip => 'تغيير الموضوع';

  @override
  String get settingsTitle => 'إعدادات';

  @override
  String get themeSettingTitle => 'سمة';

  @override
  String get languageSettingTitle => 'لغة';

  @override
  String get chooseLanguageTitle => 'اختر لغتك';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'وضع التنزيل';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'حسابك Instagram متصل.';

  @override
  String get sessionPrivatePrompt =>
      'قم بتسجيل الدخول إلى Instagram لتنزيل المحتوى المسموح لحسابك بعرضه.';

  @override
  String get sessionPublicPrompt =>
      'أنت تقوم بتنزيل محتوى عام دون تسجيل الدخول.';

  @override
  String get profileReelsListTitle => 'قائمة مقاطع Reels';

  @override
  String get profilePostsListTitle => 'صور / قائمة المشاركة';

  @override
  String get close => 'يغلق';

  @override
  String get instagramHome => 'Instagram المنزل';

  @override
  String get selectThisContent => 'حدد هذا المحتوى';

  @override
  String get manualOpeningInstagram => 'الافتتاح Instagram...';

  @override
  String get manualInstruction =>
      'افتح المنشور، Reel، Story، أو Highlight الذي تريد تنزيله، ثم انقر فوق \"تحديد هذا المحتوى\".';

  @override
  String get manualPickedContent =>
      'تم تحديد المحتوى. اضغط على \"تحديد هذا المحتوى\" للمتابعة.';

  @override
  String get manualNoDownloadableContent =>
      'لم يتم العثور على محتوى قابل للتنزيل. افتح منشورًا أو Reel أو Story أو Highlight.';

  @override
  String get manualCloseToExit =>
      'لتجنب فقدان المحتوى المحدد، انقر فوق \"إغلاق\" إذا كنت تريد الخروج.';

  @override
  String get loginOpeningInstagram => 'جارٍ الفتح Instagram... يرجى الانتظار.';

  @override
  String get loginInstruction =>
      'قم بتسجيل الدخول إلى Instagram، ثم اضغط على \"حفظ\" للإنهاء.';

  @override
  String get loginChecking => 'جارٍ التحقق من تسجيل الدخول...';

  @override
  String get loginCannotConfirm =>
      'لا يمكن تأكيد تسجيل الدخول.\nيرجى تسجيل الدخول إلى Instagram ثم حاول الحفظ مرة أخرى.';

  @override
  String get loginSaveError =>
      'حدث خطأ أثناء حفظ معلومات تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get loginLoggingOut => 'تسجيل الخروج...';

  @override
  String get loginLoggedOut =>
      'لقد قمت بتسجيل الخروج من Instagram.\nالرجاء تسجيل الدخول مرة أخرى للمتابعة.';

  @override
  String get loginSuccessPrompt =>
      'تم تسجيل الدخول بنجاح.\nاضغط على \"حفظ\" للإنهاء.';

  @override
  String get loginPromptOnLoginPage =>
      'قم بتسجيل الدخول إلى Instagram، ثم اضغط على \"حفظ\" للإنهاء.';

  @override
  String get loginPromptSaveBottom =>
      'إذا انتهيت من تسجيل الدخول، اضغط على \"حفظ\" أدناه.';

  @override
  String get loginPageTitle => 'تسجيل الدخول إلى Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'الافتتاح Instagram...\nبعد تسجيل الدخول، اضغط على \"حفظ\".';

  @override
  String get loginOpenFailed =>
      'لا يمكن فتح Instagram.\nيرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.';

  @override
  String get profileSavedMissingUsername =>
      'الملف الشخصي المحفوظ يفتقد اسم المستخدم.';

  @override
  String get openingProfile => 'جارٍ فتح الملف الشخصي...';

  @override
  String openingUsername(String username) {
    return 'فتح @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'تم العثور على $storyCount Story/Highlight عناصر و $postCount مشاركات.';
  }

  @override
  String get privateModeEnabled => 'تم تمكين الوضع Private.';

  @override
  String get publicModeEnabled => 'تم التبديل مرة أخرى إلى الوضع Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'لا يمكن تأكيد تسجيل الدخول Instagram. الرجاء تسجيل الدخول مرة أخرى.';

  @override
  String get instagramConnected => 'Instagram الحساب متصل.';

  @override
  String get loggingOutInstagram => 'تسجيل الخروج من...';

  @override
  String get instagramLoggedOut => 'لقد قمت بتسجيل الخروج من Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'تم تسجيل الخروج من Instagram، ولكن حدث خطأ أثناء مسح بيانات تسجيل الدخول.';

  @override
  String get emptyInstagramLink => 'الرجاء إدخال رابط Instagram.';

  @override
  String get preparingContent => 'جارٍ تحضير المحتوى...';

  @override
  String get loadingContentWithAccount =>
      'جارٍ تحميل المحتوى باستخدام الحساب المتصل...';

  @override
  String get cannotFetchContent => 'لا يمكن جلب المحتوى.';

  @override
  String get noDownloadableContentFound =>
      'لم يتم العثور على محتوى قابل للتنزيل.';

  @override
  String foundDownloadableContent(int count) {
    return 'تم العثور على $count عناصر قابلة للتنزيل.';
  }

  @override
  String get fetchContentFailedPublic =>
      'لا يمكن جلب المحتوى. يرجى التحقق من الرابط أو المحاولة مرة أخرى.';

  @override
  String get fetchContentFailedPrivate =>
      'لا يمكن جلب المحتوى. يرجى التحقق من إذن المشاهدة أو تسجيل الدخول مرة أخرى.';

  @override
  String get emptyProfileInput => 'الرجاء إدخال ملف تعريف Instagram.';

  @override
  String get loadingStoryHighlights => 'جاري التحميل Stories و Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'لم يتم العثور على القصة الحالية أو أبرز الأحداث.';

  @override
  String foundStoryHighlights(int count) {
    return 'تم العثور على $count Story/Highlight العناصر.';
  }

  @override
  String get cannotOpenContent => 'لا يمكن فتح هذا المحتوى.';

  @override
  String openingStoryGroup(String title) {
    return 'فتح \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'تم العثور على $count عناصر في \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'لا يمكن فتح Story أو Highlight. الرجاء تسجيل الدخول والمحاولة مرة أخرى.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'لا يمكن فتح Story أو Highlight. يرجى التحقق من إذن المشاهدة.';

  @override
  String get cannotDownloadContent => 'لا يمكن تنزيل هذا المحتوى.';

  @override
  String get downloadingStory => 'جارٍ تنزيل القصة...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'تم حفظ عنصر القصة في الألبوم $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story فشل التنزيل. يرجى المحاولة مرة أخرى.';

  @override
  String get loadingReelsPublic => 'جارٍ جلب البكرات...';

  @override
  String get loadingReelsPrivate => 'تحميل البكرات...';

  @override
  String get noReelsOrPermission =>
      'لم يتم العثور على أي منها، أو ليس لديك إذن بمشاهدتها.';

  @override
  String foundReels(int count) {
    return 'تم العثور على $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'لا يمكن تحميل Reels. يرجى التحقق من الملف الشخصي أو المحاولة مرة أخرى.';

  @override
  String get cannotLoadReelsPrivate =>
      'لا يمكن تحميل Reels. يرجى التحقق من إذن المشاهدة.';

  @override
  String get loadingPostsPublic => 'جارٍ جلب الصور/المشاركات...';

  @override
  String get loadingPostsPrivate => 'جارٍ تحميل الصور/المشاركات...';

  @override
  String get noPostsOrPermission =>
      'لم يتم العثور على صور/منشورات، أو ليس لديك إذن بمشاهدتها.';

  @override
  String foundPosts(int count) {
    return 'تم العثور على $count الصور/المشاركات.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'لا يمكن تحميل المشاركات. يرجى التحقق من الملف الشخصي أو المحاولة مرة أخرى.';

  @override
  String get cannotLoadPostsPrivate =>
      'لا يمكن تحميل المشاركات. يرجى التحقق من إذن المشاهدة.';

  @override
  String get cannotLoadMoreContent => 'لا يمكن تحميل المزيد من المحتوى.';

  @override
  String get cannotLoadMoreProfile =>
      'لا يمكن تحميل المزيد. الرجاء إدخال الملف الشخصي مرة أخرى.';

  @override
  String get noMoreNewContent => 'لا مزيد من المحتوى الجديد.';

  @override
  String loadedMoreContent(int count) {
    return 'تم تحميل $count المزيد من العناصر.';
  }

  @override
  String get loadMoreFailed => 'فشل تحميل المزيد. يرجى المحاولة مرة أخرى.';

  @override
  String get openingReel => 'الافتتاح Reel...';

  @override
  String get openingPost => 'جارٍ فتح المشاركة...';

  @override
  String get cannotOpenContentPermission =>
      'لا يمكن فتح هذا المحتوى. يرجى التحقق من إذن المشاهدة أو المحاولة مرة أخرى.';

  @override
  String get downloadingContent => 'جارٍ تنزيل المحتوى...';

  @override
  String savedToAlbum(String albumName) {
    return 'تم الحفظ في الألبوم $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'المحتوى المحفوظ في الألبوم $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'فشل تنزيل المحتوى. انقر للمحاولة مرة أخرى.';

  @override
  String get downloadHistoryCleared => 'تم مسح سجل التنزيل.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'تمت إزالة $count العناصر من التاريخ.';
  }

  @override
  String get downloadConnectionSlow =>
      'فشل التنزيل بسبب بطء الاتصال. انقر للمحاولة مرة أخرى.';

  @override
  String get downloadNetworkUnavailable =>
      'لا يمكن الاتصال بالشبكة/CDN. تحقق من شبكتك وحاول مرة أخرى.';

  @override
  String get downloadCancelled => 'تم إلغاء التنزيل.';

  @override
  String get downloadGenericError => 'فشل التنزيل. انقر للمحاولة مرة أخرى.';

  @override
  String downloadProgress(String percent) {
    return 'تنزيل المحتوى: $percent%';
  }
}
