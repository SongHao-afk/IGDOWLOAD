// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get login => 'Oturum aç';

  @override
  String get logout => 'Oturumu kapat';

  @override
  String get understood => 'Anladım';

  @override
  String get delete => 'Sil';

  @override
  String get deleteAll => 'Tümünü sil';

  @override
  String get share => 'Paylaş';

  @override
  String get download => 'İndir';

  @override
  String get downloadAgain => 'Tekrar indir';

  @override
  String get saved => 'İndirildi';

  @override
  String get loading => 'Yükleniyor';

  @override
  String get apply => 'Uygula';

  @override
  String get frequentProfilesTitle => 'Son görüntülenen profiller';

  @override
  String get frequentProfilesEmptyTitle => 'Henüz profil yok';

  @override
  String get frequentProfilesEmptyMessage =>
      'Görüntülediğiniz profiller burada görünecektir.';

  @override
  String get account => 'Hesap';

  @override
  String get downloadHistoryTitle => 'İndir geçmiş';

  @override
  String get downloadHistoryEmptyTitle => 'Henüz içerik yok';

  @override
  String get downloadHistoryEmptyMessage =>
      'Henüz herhangi bir içerik indirmediniz';

  @override
  String selectedCount(int count) {
    return '$count seçildi';
  }

  @override
  String get deleteAllHistoryTitle => 'Tüm geçmişi sil?';

  @override
  String get deleteAllHistoryMessage =>
      'İndirme geçmişinizdeki tüm öğeler uygulamadan kaldırılacak.';

  @override
  String deleteSelectedTitle(int count) {
    return '$count öğe silinsin mi?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Seçilen öğe indirme geçmişinizden kaldırılacak.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count seçilen öğeler indirme geçmişinizden kaldırılacak.';
  }

  @override
  String get deleteOneTitle => 'Bu öğe silinsin mi?';

  @override
  String get deleteOneMessage => 'Bu öğe indirme geçmişinizden kaldırılacak.';

  @override
  String get cannotShareFileMissing =>
      'Yapılamıyor. Paylaş. Dosya artık bu cihazda mevcut değil.';

  @override
  String get cannotShareContent => 'Bu içerik paylaşılamıyor.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Tekrar kaydedilemiyor. Dosya artık bu cihazda mevcut değil.';

  @override
  String get savedAgainToGallery => 'Yeniden galeriye kaydedildi.';

  @override
  String get cannotSaveAgainContent => 'Bu içerik yeniden kaydedilemiyor.';

  @override
  String get cannotOpenFileMissing =>
      'Bu içerik açılamıyor. Dosya artık bu cihazda mevcut değil.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Fotoğraf';

  @override
  String get content => 'İçerik';

  @override
  String get justDownloaded => 'Az önce indirildi';

  @override
  String get heroTitle => 'Instagram\'den içerik indirin';

  @override
  String get heroConnected => 'Instagram bağlandı.';

  @override
  String get heroDescription =>
      'Fotoğrafları, makaraları ve hikayeleri hızlı ve kolay bir şekilde indirin.';

  @override
  String get downloadByLink => 'Bağlantıyla indirin';

  @override
  String get invalidLinkTitle => 'Geçersiz bağlantı';

  @override
  String get invalidLinkMessage =>
      'Lütfen indirmek istediğiniz gönderi, Reel, Story veya video için Instagram bağlantısını girin.';

  @override
  String get downloadByLinkInfo1 =>
      'Zaten bir Instagram gönderisine, Reel, Story veya Highlight bağlantınız varsa bunu kullanın.';

  @override
  String get downloadByLinkInfo2 =>
      'Bağlantıyı yapıştırdığınızda uygulama içeriği kontrol edecek ve indirmenize izin verecektir.';

  @override
  String get example => 'Örnek:';

  @override
  String get enterInstagramLink => 'Instagram bağlantısını girin';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... veya /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'İstediğiniz içeriği kontrol edip indirmek için bir Instagram bağlantısını yapıştırın.';

  @override
  String get openInstagram => 'Instagram\'yi açın';

  @override
  String get getContent => 'İçerik al';

  @override
  String get explainFeature => 'Özelliği açıkla';

  @override
  String get downloadFromProfile => 'Profilden indir';

  @override
  String get invalidProfileTitle => 'Geçersiz bilgi';

  @override
  String get invalidProfileMessage =>
      'Lütfen bir Instagram kullanıcı adı veya profil bağlantısı girin.';

  @override
  String get profileInfo1 =>
      'Bir Instagram hesabındaki birden fazla öğeyi görüntülemek ve indirmek istediğinizde bunu kullanın.';

  @override
  String get profileInfo2 =>
      'Bir kullanıcı adı veya profil bağlantısı girin ve ardından indirmek istediğiniz Story, Reel\'leri veya gönderileri seçin.';

  @override
  String get profileInputLabel => 'Kullanıcı adı veya profil bağlantısı';

  @override
  String get profileInputHint =>
      'Örnek: @kullanıcıadı veya instagram.com/kullanıcıadı';

  @override
  String get profileCardDescription =>
      'İndirilebilir Stories, Reel\'leri ve gönderileri görüntülemek için bir kullanıcı adı veya profil bağlantısı girin.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reel\'ler';

  @override
  String get posts => 'Gönderiler';

  @override
  String get photosPosts => 'Fotoğraflar / Gönderiler';

  @override
  String get photosVideos => 'Fotoğraflar / Videolar';

  @override
  String get profileSummary => 'Profil özeti';

  @override
  String get storyModeHint =>
      'İndirilebilir Stories ve Highlight\'leri görüntülemek için bir profil girin.';

  @override
  String get reelsModeHint =>
      'Reel listesini görüntülemek için bir profil girin.';

  @override
  String get postsModeHint =>
      'İndirilebilir gönderileri görüntülemek için bir profil girin.';

  @override
  String get storyPopupTitle => 'Stories\'yi profilden indirin';

  @override
  String get reelsPopupTitle => 'Profilden Reel\'leri indirin';

  @override
  String get postsPopupTitle => 'Profildeki gönderileri indirin';

  @override
  String get viewStory => 'Story\'yi görüntüle';

  @override
  String get viewReels => 'Reel\'leri görüntüle';

  @override
  String get viewPosts => 'Gönderileri görüntüle';

  @override
  String get noStoryOrHighlightAll =>
      'Story veya Highlight bulunamadı. İçerik görüntüleme izni gerektiriyorsa oturum açın.';

  @override
  String get noStoryOrHighlightInput =>
      'Story veya Highlight bulunamadı. Kontrol etmek için bir Instagram profili girin.';

  @override
  String get noStoryItems =>
      'Görüntülenecek içerik yok veya bu öğeyi görüntüleme izniniz yok.';

  @override
  String get noFeedAll =>
      'Hiçbir gönderi veya video bulunamadı. İçerik görüntüleme izni gerektiriyorsa oturum açın.';

  @override
  String get noFeedInput =>
      'Henüz içerik yok. Reel\'leri veya Gönderiler\'i seçin ve ardından bir profil girin.';

  @override
  String get endOfContent => 'İçeriğin sonuna ulaştınız.';

  @override
  String get loadMore => 'Daha fazlasını yükle';

  @override
  String get loadingMore => 'Daha fazlası yükleniyor...';

  @override
  String get cannotShowPostContent => 'Bu yazıdaki içerik görüntülenemiyor.';

  @override
  String get chooseItemToDownload => 'İndirilecek bir öğe seçin';

  @override
  String contentCount(int count) {
    return '$count öğeler';
  }

  @override
  String get chooseThemeColor => 'Tema rengini seçin';

  @override
  String get themeDefault => 'Varsayılan';

  @override
  String get themeVivid => 'Canlı';

  @override
  String get themePink => 'Parlak pembe';

  @override
  String get themeBlue => 'Açık mavi';

  @override
  String get themeRed => 'Kırmızı';

  @override
  String get themeDark => 'Karanlık';

  @override
  String get loginRequiredTitle => 'Giriş gerekli';

  @override
  String get followRequiredTitle => 'Takip gerekli';

  @override
  String get followRequiredMessage =>
      'Giriş yapılan hesabın bu içeriği görüntüleme izni yok.';

  @override
  String get downloadSuccessMessage => 'Başarıyla indirildi.';

  @override
  String get viewHistory => 'Geçmişi görüntüle';

  @override
  String get frequentAccessTooltip => 'Sık erişim';

  @override
  String get recentDownloadsTooltip => 'Son indirilenler';

  @override
  String get changeThemeTooltip => 'Temayı değiştir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Dil';

  @override
  String get chooseLanguageTitle => 'Dilinizi seçin';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'İndirme modu';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Instagram hesabınız bağlandı.';

  @override
  String get sessionPrivatePrompt =>
      'Hesabınızın görüntülemesine izin verilen içeriği indirmek için Instagram\'de oturum açın.';

  @override
  String get sessionPublicPrompt =>
      'Herkese açık içeriği giriş yapmadan indiriyorsunuz.';

  @override
  String get profileReelsListTitle => 'Reel video listesi';

  @override
  String get profilePostsListTitle => 'Fotoğraf / Gönderi listesi';

  @override
  String get close => 'Kapalı';

  @override
  String get instagramHome => 'Instagram ev';

  @override
  String get selectThisContent => 'Bu içeriği seç';

  @override
  String get manualOpeningInstagram => 'Instagram açılıyor...';

  @override
  String get manualInstruction =>
      'İndirmek istediğiniz gönderiyi, Reel, Story veya Highlight\'yi açın ve ardından \"Bu içeriği seç\"e dokunun.';

  @override
  String get manualPickedContent =>
      'İçerik seçildi. Devam etmek için \"Bu içeriği seç\"e dokunun.';

  @override
  String get manualNoDownloadableContent =>
      'İndirilebilir içerik bulunamadı. Bir gönderiyi açın, Reel, Story veya Highlight.';

  @override
  String get manualCloseToExit =>
      'Seçilen içeriği kaybetmemek için çıkmak istiyorsanız \"Kapat\"a dokunun.';

  @override
  String get loginOpeningInstagram => 'Instagram açılıyor... Lütfen bekleyin.';

  @override
  String get loginInstruction =>
      'Instagram\'de oturum açın ve işlemi tamamlamak için \"Kaydet\"e dokunun.';

  @override
  String get loginChecking => 'Giriş kontrol ediliyor...';

  @override
  String get loginCannotConfirm =>
      'Oturum açma işlemi onaylanamıyor.\nLütfen Instagram\'de oturum açın ve kaydetmeyi tekrar deneyin.';

  @override
  String get loginSaveError =>
      'Giriş bilgileri kaydedilirken bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get loginLoggingOut => 'Oturum kapatılıyor...';

  @override
  String get loginLoggedOut =>
      'Instagram oturumunu kapattınız.\nDevam etmek için lütfen tekrar giriş yapın.';

  @override
  String get loginSuccessPrompt =>
      'Giriş başarılı.\nBitirmek için \"Kaydet\"e dokunun.';

  @override
  String get loginPromptOnLoginPage =>
      'Instagram\'de oturum açın ve işlemi tamamlamak için \"Kaydet\"e dokunun.';

  @override
  String get loginPromptSaveBottom =>
      'Giriş yapmayı tamamladıysanız aşağıdaki \"Kaydet\"e dokunun.';

  @override
  String get loginPageTitle => 'Instagram\'de oturum açın';

  @override
  String get loginOpeningInstagramWithHint =>
      'Instagram açılıyor...\nGiriş yaptıktan sonra \"Kaydet\"e dokunun.';

  @override
  String get loginOpenFailed =>
      'Instagram açılamıyor.\nLütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get profileSavedMissingUsername =>
      'Kaydedilen profilde kullanıcı adı eksik.';

  @override
  String get openingProfile => 'Profil açılıyor...';

  @override
  String openingUsername(String username) {
    return '@$username açılıyor...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return '$storyCount Story/Highlight öğeleri ve $postCount gönderileri bulundu.';
  }

  @override
  String get privateModeEnabled => 'Private modu etkinleştirildi.';

  @override
  String get publicModeEnabled => 'Public moduna geri dönüldü.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Instagram oturum açma işlemi onaylanamıyor. Lütfen tekrar giriş yapın.';

  @override
  String get instagramConnected => 'Instagram hesap bağlandı.';

  @override
  String get loggingOutInstagram => 'Instagram oturumu kapatılıyor...';

  @override
  String get instagramLoggedOut => 'Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Oturumu kapattınız ancak oturum açma verileri temizlenirken bir hata oluştu.';

  @override
  String get emptyInstagramLink => 'Lütfen bir Instagram bağlantısı girin.';

  @override
  String get preparingContent => 'İçerik hazırlanıyor...';

  @override
  String get loadingContentWithAccount => 'Bağlı hesapla içerik yükleniyor...';

  @override
  String get cannotFetchContent => 'İçerik getirilemiyor.';

  @override
  String get noDownloadableContentFound => 'İndirilebilir içerik bulunamadı.';

  @override
  String foundDownloadableContent(int count) {
    return 'İndirilebilir $count öğeler bulundu.';
  }

  @override
  String get fetchContentFailedPublic =>
      'İçerik getirilemiyor. Lütfen bağlantıyı kontrol edin veya tekrar deneyin.';

  @override
  String get fetchContentFailedPrivate =>
      'İçerik getirilemiyor. Lütfen görüntüleme iznini kontrol edin veya tekrar giriş yapın.';

  @override
  String get emptyProfileInput => 'Lütfen bir Instagram profili girin.';

  @override
  String get loadingStoryHighlights =>
      'Stories ve Highlight\'ler yükleniyor...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Güncel hikaye veya öne çıkan bölüm bulunamadı.';

  @override
  String foundStoryHighlights(int count) {
    return '$count Story/Highlight öğeleri bulundu.';
  }

  @override
  String get cannotOpenContent => 'Bu içerik açılamıyor.';

  @override
  String openingStoryGroup(String title) {
    return '\"$title\" açılıyor...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return '\"$title\" bölümünde $count öğeleri bulundu.';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Açılamıyor Story veya Highlight. Lütfen giriş yapın ve tekrar deneyin.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Story veya Highlight açılamıyor. Lütfen görüntüleme iznini kontrol edin.';

  @override
  String get cannotDownloadContent => 'Bu içerik indirilemiyor.';

  @override
  String get downloadingStory => 'Hikaye indiriliyor...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Albüme kaydedilen hikaye öğesi $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story indirilemedi. Lütfen tekrar deneyin.';

  @override
  String get loadingReelsPublic => 'Makaralar alınıyor...';

  @override
  String get loadingReelsPrivate => 'Makaralar yükleniyor...';

  @override
  String get noReelsOrPermission =>
      'Hiçbir Reel bulunamadı veya bunları görüntüleme izniniz yok.';

  @override
  String foundReels(int count) {
    return '$count Reel\'ler bulundu.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Reel\'ler yüklenemiyor. Lütfen profili kontrol edin veya tekrar deneyin.';

  @override
  String get cannotLoadReelsPrivate =>
      'Reel\'ler yüklenemiyor. Lütfen görüntüleme iznini kontrol edin.';

  @override
  String get loadingPostsPublic => 'Fotoğraflar/yayınlar getiriliyor...';

  @override
  String get loadingPostsPrivate => 'Fotoğraflar/yayınlar yükleniyor...';

  @override
  String get noPostsOrPermission =>
      'Hiçbir fotoğraf/yayın bulunamadı veya bunları görüntüleme izniniz yok.';

  @override
  String foundPosts(int count) {
    return '$count fotoğraf/yayın bulundu.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Gönderiler yüklenemiyor. Lütfen profili kontrol edin veya tekrar deneyin.';

  @override
  String get cannotLoadPostsPrivate =>
      'Gönderiler yüklenemiyor. Lütfen görüntüleme iznini kontrol edin.';

  @override
  String get cannotLoadMoreContent => 'Daha fazla içerik yüklenemiyor.';

  @override
  String get cannotLoadMoreProfile =>
      'Daha fazlası yüklenemiyor. Lütfen profile tekrar girin.';

  @override
  String get noMoreNewContent => 'Artık yeni içerik yok.';

  @override
  String loadedMoreContent(int count) {
    return '$count öğe daha yüklendi.';
  }

  @override
  String get loadMoreFailed =>
      'Daha fazlası yüklenemedi. Lütfen tekrar deneyin.';

  @override
  String get openingReel => 'Reel açılıyor...';

  @override
  String get openingPost => 'Açılış yazısı...';

  @override
  String get cannotOpenContentPermission =>
      'Bu içerik açılamıyor. Lütfen görüntüleme iznini kontrol edin veya tekrar deneyin.';

  @override
  String get downloadingContent => 'İçerik indiriliyor...';

  @override
  String savedToAlbum(String albumName) {
    return '$albumName albümüne kaydedildi.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'İçerik $albumName albümüne kaydedildi.';
  }

  @override
  String get downloadContentErrorRetry =>
      'İçerik indirme işlemi başarısız oldu. Tekrar denemek için dokunun.';

  @override
  String get downloadHistoryCleared => 'İndirme geçmişi temizlendi.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return '$count öğeleri geçmişten kaldırıldı.';
  }

  @override
  String get downloadConnectionSlow =>
      'Yavaş bağlantı nedeniyle indirme başarısız oldu. Tekrar denemek için dokunun.';

  @override
  String get downloadNetworkUnavailable =>
      'Ağa bağlanılamıyor/CDN. Ağınızı kontrol edin ve tekrar deneyin.';

  @override
  String get downloadCancelled => 'İndirme iptal edildi.';

  @override
  String get downloadGenericError =>
      'İndirme başarısız oldu. Tekrar denemek için dokunun.';

  @override
  String downloadProgress(String percent) {
    return 'İçerik indiriliyor: $percent%';
  }
}
