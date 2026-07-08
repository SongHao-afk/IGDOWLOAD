// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Membatalkan';

  @override
  String get save => 'Menyimpan';

  @override
  String get login => 'Masuk';

  @override
  String get logout => 'Keluar';

  @override
  String get understood => 'Mengerti';

  @override
  String get delete => 'Menghapus';

  @override
  String get deleteAll => 'Hapus semua';

  @override
  String get share => 'Membagikan';

  @override
  String get download => 'Unduh';

  @override
  String get downloadAgain => 'Unduh lagi';

  @override
  String get saved => 'Diunduh';

  @override
  String get loading => 'Memuat';

  @override
  String get apply => 'Menerapkan';

  @override
  String get frequentProfilesTitle => 'Profil yang baru dilihat';

  @override
  String get frequentProfilesEmptyTitle => 'Belum ada profil';

  @override
  String get frequentProfilesEmptyMessage =>
      'Profil yang Anda lihat akan muncul di sini.';

  @override
  String get account => 'Akun';

  @override
  String get downloadHistoryTitle => 'Unduh riwayat';

  @override
  String get downloadHistoryEmptyTitle => 'Belum ada konten';

  @override
  String get downloadHistoryEmptyMessage =>
      'Anda belum mengunduh konten apa pun';

  @override
  String selectedCount(int count) {
    return '$count dipilih';
  }

  @override
  String get deleteAllHistoryTitle => 'Hapus semua riwayat?';

  @override
  String get deleteAllHistoryMessage =>
      'Semua item dalam riwayat unduhan Anda akan dihapus dari aplikasi.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Hapus $count item?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Item yang dipilih akan dihapus dari riwayat unduhan Anda.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count item yang dipilih akan dihapus dari riwayat unduhan Anda.';
  }

  @override
  String get deleteOneTitle => 'Hapus item ini?';

  @override
  String get deleteOneMessage =>
      'Item ini akan dihapus dari riwayat unduhan Anda.';

  @override
  String get cannotShareFileMissing =>
      'Tidak dapat berbagi. File tersebut sudah tidak ada lagi di perangkat ini.';

  @override
  String get cannotShareContent => 'Tidak dapat membagikan konten ini.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Tidak dapat menyimpan lagi. File tersebut sudah tidak ada lagi di perangkat ini.';

  @override
  String get savedAgainToGallery => 'Disimpan lagi ke galeri.';

  @override
  String get cannotSaveAgainContent => 'Tidak dapat menyimpan konten ini lagi.';

  @override
  String get cannotOpenFileMissing =>
      'Tidak dapat membuka konten ini. File tersebut sudah tidak ada lagi di perangkat ini.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Foto';

  @override
  String get content => 'Isi';

  @override
  String get justDownloaded => 'Baru saja diunduh';

  @override
  String get heroTitle => 'Unduh konten dari Instagram';

  @override
  String get heroConnected => 'Instagram terhubung.';

  @override
  String get heroDescription =>
      'Unduh foto, gulungan, dan cerita dengan cepat dan mudah.';

  @override
  String get downloadByLink => 'Unduh melalui tautan';

  @override
  String get invalidLinkTitle => 'Tautan tidak valid';

  @override
  String get invalidLinkMessage =>
      'Silakan masukkan tautan Instagram untuk postingan, Reel, Story, atau video yang ingin Anda unduh.';

  @override
  String get downloadByLinkInfo1 =>
      'Gunakan ini bila Anda sudah memiliki link ke postingan Instagram, Reel, Story, atau Highlight.';

  @override
  String get downloadByLinkInfo2 =>
      'Tempel tautannya dan aplikasi akan memeriksa kontennya dan membiarkan Anda mengunduhnya.';

  @override
  String get example => 'Contoh:';

  @override
  String get enterInstagramLink => 'Masukkan tautan Instagram';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... atau /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Tempelkan tautan Instagram untuk memeriksa dan mengunduh konten yang Anda inginkan.';

  @override
  String get openInstagram => 'Buka Instagram';

  @override
  String get getContent => 'Dapatkan konten';

  @override
  String get explainFeature => 'Jelaskan fitur';

  @override
  String get downloadFromProfile => 'Unduh dari profil';

  @override
  String get invalidProfileTitle => 'Informasi tidak valid';

  @override
  String get invalidProfileMessage =>
      'Silakan masukkan nama pengguna atau tautan profil Instagram.';

  @override
  String get profileInfo1 =>
      'Gunakan ini saat Anda ingin melihat dan mengunduh beberapa item dari akun Instagram.';

  @override
  String get profileInfo2 =>
      'Masukkan nama pengguna atau tautan profil, lalu pilih Story, Reels, atau postingan yang ingin Anda unduh.';

  @override
  String get profileInputLabel => 'Nama pengguna atau tautan profil';

  @override
  String get profileInputHint =>
      'Contoh: @namapengguna atau instagram.com/namapengguna';

  @override
  String get profileCardDescription =>
      'Masukkan nama pengguna atau tautan profil untuk melihat Stories, Reels, dan postingan yang dapat diunduh.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Postingan';

  @override
  String get photosPosts => 'Foto / Postingan';

  @override
  String get photosVideos => 'Foto / Video';

  @override
  String get profileSummary => 'Ringkasan profil';

  @override
  String get storyModeHint =>
      'Masukkan profil untuk melihat Stories dan Highlights yang dapat diunduh.';

  @override
  String get reelsModeHint => 'Masukkan profil untuk melihat daftar Reel.';

  @override
  String get postsModeHint =>
      'Masukkan profil untuk melihat postingan yang dapat diunduh.';

  @override
  String get storyPopupTitle => 'Unduh Stories dari profil';

  @override
  String get reelsPopupTitle => 'Unduh Reels dari profil';

  @override
  String get postsPopupTitle => 'Unduh postingan dari profil';

  @override
  String get viewStory => 'Lihat Story';

  @override
  String get viewReels => 'Lihat Reels';

  @override
  String get viewPosts => 'Lihat postingan';

  @override
  String get noStoryOrHighlightAll =>
      'Tidak ditemukan Story atau Highlight. Masuk jika konten memerlukan izin melihat.';

  @override
  String get noStoryOrHighlightInput =>
      'Tidak ditemukan Story atau Highlight. Masukkan profil Instagram untuk diperiksa.';

  @override
  String get noStoryItems =>
      'Tidak ada konten untuk ditampilkan, atau Anda tidak memiliki izin untuk melihat item ini.';

  @override
  String get noFeedAll =>
      'Tidak ada postingan atau video yang ditemukan. Masuk jika konten memerlukan izin melihat.';

  @override
  String get noFeedInput =>
      'Belum ada konten. Pilih Reels atau Postingan, lalu masukkan profil.';

  @override
  String get endOfContent => 'Anda telah mencapai akhir konten.';

  @override
  String get loadMore => 'Muat lebih banyak';

  @override
  String get loadingMore => 'Memuat lebih banyak...';

  @override
  String get cannotShowPostContent =>
      'Tidak dapat menampilkan konten dalam postingan ini.';

  @override
  String get chooseItemToDownload => 'Pilih item untuk diunduh';

  @override
  String contentCount(int count) {
    return '$count item';
  }

  @override
  String get chooseThemeColor => 'Pilih warna tema';

  @override
  String get themeDefault => 'Bawaan';

  @override
  String get themeVivid => 'Jelas';

  @override
  String get themePink => 'Merah muda mengkilap';

  @override
  String get themeBlue => 'Biru muda';

  @override
  String get themeRed => 'Merah';

  @override
  String get themeDark => 'Gelap';

  @override
  String get loginRequiredTitle => 'Diperlukan login';

  @override
  String get followRequiredTitle => 'Ikuti diperlukan';

  @override
  String get followRequiredMessage =>
      'Akun yang masuk tidak memiliki izin untuk melihat konten ini.';

  @override
  String get downloadSuccessMessage => 'Berhasil diunduh.';

  @override
  String get viewHistory => 'Lihat sejarah';

  @override
  String get frequentAccessTooltip => 'Akses yang sering';

  @override
  String get recentDownloadsTooltip => 'Unduhan terbaru';

  @override
  String get changeThemeTooltip => 'Ubah tema';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get themeSettingTitle => 'Tema';

  @override
  String get languageSettingTitle => 'Bahasa';

  @override
  String get chooseLanguageTitle => 'Pilih bahasa Anda';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'Modus pengunduhan';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Akun Instagram Anda terhubung.';

  @override
  String get sessionPrivatePrompt =>
      'Masuk ke Instagram untuk mengunduh konten yang boleh dilihat oleh akun Anda.';

  @override
  String get sessionPublicPrompt => 'Anda mengunduh konten publik tanpa login.';

  @override
  String get profileReelsListTitle => 'Reel daftar video';

  @override
  String get profilePostsListTitle => 'Daftar Foto / Posting';

  @override
  String get close => 'Menutup';

  @override
  String get instagramHome => 'Instagram rumah';

  @override
  String get selectThisContent => 'Pilih konten ini';

  @override
  String get manualOpeningInstagram => 'Pembukaan Instagram...';

  @override
  String get manualInstruction =>
      'Buka postingan, Reel, Story, atau Highlight yang ingin Anda unduh, lalu ketuk \"Pilih konten ini\".';

  @override
  String get manualPickedContent =>
      'Konten dipilih. Ketuk \"Pilih konten ini\" untuk melanjutkan.';

  @override
  String get manualNoDownloadableContent =>
      'Tidak ditemukan konten yang dapat diunduh. Buka postingan, Reel, Story, atau Highlight.';

  @override
  String get manualCloseToExit =>
      'Untuk menghindari kehilangan konten yang dipilih, ketuk \"Tutup\" jika Anda ingin keluar.';

  @override
  String get loginOpeningInstagram => 'Membuka Instagram... Harap tunggu.';

  @override
  String get loginInstruction =>
      'Masuk ke Instagram, lalu ketuk \"Simpan\" untuk menyelesaikan.';

  @override
  String get loginChecking => 'Memeriksa login...';

  @override
  String get loginCannotConfirm =>
      'Tidak dapat mengonfirmasi login.\nSilakan masuk ke Instagram dan coba simpan lagi.';

  @override
  String get loginSaveError =>
      'Terjadi kesalahan saat menyimpan informasi login. Silakan coba lagi.';

  @override
  String get loginLoggingOut => 'Keluar...';

  @override
  String get loginLoggedOut =>
      'Anda telah keluar dari Instagram.\nSilakan login lagi untuk melanjutkan.';

  @override
  String get loginSuccessPrompt =>
      'Login berhasil.\nKetuk \"Simpan\" untuk menyelesaikan.';

  @override
  String get loginPromptOnLoginPage =>
      'Masuk ke Instagram, lalu ketuk \"Simpan\" untuk menyelesaikan.';

  @override
  String get loginPromptSaveBottom =>
      'Jika Anda sudah selesai masuk, ketuk \"Simpan\" di bawah.';

  @override
  String get loginPageTitle => 'Masuk ke Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Membuka Instagram...\nSetelah masuk, ketuk \"Simpan\".';

  @override
  String get loginOpenFailed =>
      'Tidak dapat membuka Instagram.\nSilakan periksa koneksi internet Anda dan coba lagi.';

  @override
  String get profileSavedMissingUsername =>
      'Profil yang disimpan tidak memiliki nama pengguna.';

  @override
  String get openingProfile => 'Membuka profil...';

  @override
  String openingUsername(String username) {
    return 'Membuka @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Ditemukan $storyCount Story/Highlight item dan $postCount kiriman.';
  }

  @override
  String get privateModeEnabled => 'Private mode diaktifkan.';

  @override
  String get publicModeEnabled => 'Beralih kembali ke mode Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Tidak dapat mengonfirmasi Instagram login. Silakan masuk lagi.';

  @override
  String get instagramConnected => 'Instagram akun terhubung.';

  @override
  String get loggingOutInstagram => 'Keluar dari Instagram...';

  @override
  String get instagramLoggedOut => 'Anda telah keluar dari Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Keluar dari Instagram, namun terjadi kesalahan saat menghapus data login.';

  @override
  String get emptyInstagramLink => 'Silakan masukkan tautan Instagram.';

  @override
  String get preparingContent => 'Mempersiapkan konten...';

  @override
  String get loadingContentWithAccount =>
      'Memuat konten dengan akun yang terhubung...';

  @override
  String get cannotFetchContent => 'Tidak dapat mengambil konten.';

  @override
  String get noDownloadableContentFound =>
      'Tidak ditemukan konten yang dapat diunduh.';

  @override
  String foundDownloadableContent(int count) {
    return 'Ditemukan $count item yang dapat diunduh.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Tidak dapat mengambil konten. Silakan periksa tautannya atau coba lagi.';

  @override
  String get fetchContentFailedPrivate =>
      'Tidak dapat mengambil konten. Silakan periksa izin melihat atau masuk lagi.';

  @override
  String get emptyProfileInput => 'Silakan masukkan profil Instagram.';

  @override
  String get loadingStoryHighlights => 'Memuat Stories dan Highlights...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Tidak ada berita atau sorotan terkini yang ditemukan.';

  @override
  String foundStoryHighlights(int count) {
    return 'Ditemukan $count Story/Highlight item.';
  }

  @override
  String get cannotOpenContent => 'Tidak dapat membuka konten ini.';

  @override
  String openingStoryGroup(String title) {
    return 'Membuka \"$title\"....';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Ditemukan $count item di \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Tidak dapat membuka Story atau Highlight. Silakan masuk dan coba lagi.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Tidak dapat membuka Story atau Highlight. Silakan periksa izin melihat.';

  @override
  String get cannotDownloadContent => 'Tidak dapat mengunduh konten ini.';

  @override
  String get downloadingStory => 'Mengunduh cerita...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Item cerita yang disimpan ke album $albumName.';
  }

  @override
  String get downloadStoryFailed =>
      'Story pengunduhan gagal. Silakan coba lagi.';

  @override
  String get loadingReelsPublic => 'Mengambil gulungan...';

  @override
  String get loadingReelsPrivate => 'Memuat gulungan...';

  @override
  String get noReelsOrPermission =>
      'Tidak ada Reelyang ditemukan, atau Anda tidak memiliki izin untuk melihatnya.';

  @override
  String foundReels(int count) {
    return 'Ditemukan $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Tidak dapat memuat Reels. Silakan periksa profil atau coba lagi.';

  @override
  String get cannotLoadReelsPrivate =>
      'Tidak dapat memuat Reels. Silakan periksa izin melihat.';

  @override
  String get loadingPostsPublic => 'Mengambil foto/postingan...';

  @override
  String get loadingPostsPrivate => 'Memuat foto/postingan...';

  @override
  String get noPostsOrPermission =>
      'Foto/postingan tidak ditemukan, atau Anda tidak memiliki izin untuk melihatnya.';

  @override
  String foundPosts(int count) {
    return 'Ditemukan $count foto/postingan.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Tidak dapat memuat postingan. Silakan periksa profil atau coba lagi.';

  @override
  String get cannotLoadPostsPrivate =>
      'Tidak dapat memuat postingan. Silakan periksa izin melihat.';

  @override
  String get cannotLoadMoreContent => 'Tidak dapat memuat konten lainnya.';

  @override
  String get cannotLoadMoreProfile =>
      'Tidak dapat memuat lebih banyak. Silakan masuk ke profil lagi.';

  @override
  String get noMoreNewContent => 'Tidak ada lagi konten baru.';

  @override
  String loadedMoreContent(int count) {
    return 'Dimuat $count item lainnya.';
  }

  @override
  String get loadMoreFailed => 'Gagal memuat lebih banyak. Silakan coba lagi.';

  @override
  String get openingReel => 'Membuka Reel...';

  @override
  String get openingPost => 'Membuka postingan...';

  @override
  String get cannotOpenContentPermission =>
      'Tidak dapat membuka konten ini. Silakan periksa izin melihat atau coba lagi.';

  @override
  String get downloadingContent => 'Mengunduh konten...';

  @override
  String savedToAlbum(String albumName) {
    return 'Disimpan ke album $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Konten yang disimpan ke album $albumName.';
  }

  @override
  String get downloadContentErrorRetry =>
      'Pengunduhan konten gagal. Ketuk untuk mencoba lagi.';

  @override
  String get downloadHistoryCleared => 'Riwayat unduhan dihapus.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Menghapus $count item dari riwayat.';
  }

  @override
  String get downloadConnectionSlow =>
      'Pengunduhan gagal karena koneksi lambat. Ketuk untuk mencoba lagi.';

  @override
  String get downloadNetworkUnavailable =>
      'Tidak dapat terhubung ke jaringan/CDN. Periksa jaringan Anda dan coba lagi.';

  @override
  String get downloadCancelled => 'Pengunduhan dibatalkan.';

  @override
  String get downloadGenericError =>
      'Pengunduhan gagal. Ketuk untuk mencoba lagi.';

  @override
  String downloadProgress(String percent) {
    return 'Mengunduh konten: $percent%';
  }

  @override
  String get legalLinksTitle => 'Kebijakan Privasi & Ketentuan';

  @override
  String get termsOfUse => 'Ketentuan Penggunaan';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';
}
