// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get login => 'Đăng nhập';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get understood => 'Đã hiểu';

  @override
  String get delete => 'Xoá';

  @override
  String get deleteAll => 'Xoá tất cả';

  @override
  String get share => 'Chia sẻ';

  @override
  String get download => 'Tải';

  @override
  String get downloadAgain => 'Tải lại';

  @override
  String get saved => 'Đã tải';

  @override
  String get loading => 'Đang tải';

  @override
  String get apply => 'Áp dụng';

  @override
  String get frequentProfilesTitle => 'Trang cá nhân đã xem gần đây';

  @override
  String get frequentProfilesEmptyTitle => 'Chưa có trang cá nhân nào';

  @override
  String get frequentProfilesEmptyMessage =>
      'Những trang cá nhân bạn đã xem sẽ xuất hiện tại đây.';

  @override
  String get account => 'Tài khoản';

  @override
  String get downloadHistoryTitle => 'Lịch sử tải xuống';

  @override
  String get downloadHistoryEmptyTitle => 'Chưa có nội dung nào';

  @override
  String get downloadHistoryEmptyMessage => 'Bạn chưa tải nội dung nào';

  @override
  String selectedCount(int count) {
    return 'Đã chọn $count';
  }

  @override
  String get deleteAllHistoryTitle => 'Xoá tất cả lịch sử?';

  @override
  String get deleteAllHistoryMessage =>
      'Tất cả mục trong lịch sử tải xuống sẽ bị xoá khỏi ứng dụng.';

  @override
  String deleteSelectedTitle(int count) {
    return 'Xoá $count mục?';
  }

  @override
  String get deleteSelectedOneMessage =>
      'Mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.';
  }

  @override
  String get deleteOneTitle => 'Xoá mục này?';

  @override
  String get deleteOneMessage => 'Mục này sẽ bị xoá khỏi lịch sử tải xuống.';

  @override
  String get cannotShareFileMissing =>
      'Không thể chia sẻ. File không còn tồn tại trên máy.';

  @override
  String get cannotShareContent => 'Không thể chia sẻ nội dung này.';

  @override
  String get cannotSaveAgainFileMissing =>
      'Không thể lưu lại. File không còn tồn tại trên máy.';

  @override
  String get savedAgainToGallery => 'Đã lưu lại vào thư viện.';

  @override
  String get cannotSaveAgainContent => 'Không thể lưu lại nội dung này.';

  @override
  String get cannotOpenFileMissing =>
      'Không thể mở nội dung này. File không còn tồn tại trên máy.';

  @override
  String get video => 'Video';

  @override
  String get image => 'Ảnh';

  @override
  String get content => 'Nội dung';

  @override
  String get justDownloaded => 'Vừa tải';

  @override
  String get heroTitle => 'Tải nội dung từ Instagram';

  @override
  String get heroConnected => 'Instagram đã được kết nối.';

  @override
  String get heroDescription => 'Tải ảnh, reel, story cực nhanh và đơn giản.';

  @override
  String get downloadByLink => 'Tải bằng liên kết';

  @override
  String get invalidLinkTitle => 'Liên kết không hợp lệ';

  @override
  String get invalidLinkMessage =>
      'Vui lòng nhập liên kết Instagram của bài viết, Reel, Story hoặc video bạn muốn tải.';

  @override
  String get downloadByLinkInfo1 =>
      'Dùng khi bạn đã có liên kết của một bài viết, Reel, Story hoặc Highlight trên Instagram.';

  @override
  String get downloadByLinkInfo2 =>
      'Chỉ cần dán liên kết, ứng dụng sẽ kiểm tra nội dung và cho phép bạn tải xuống.';

  @override
  String get example => 'Ví dụ:';

  @override
  String get enterInstagramLink => 'Nhập liên kết Instagram';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... hoặc /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'Dán liên kết Instagram để kiểm tra và tải nội dung bạn muốn.';

  @override
  String get openInstagram => 'Mở Instagram';

  @override
  String get getContent => 'Lấy nội dung';

  @override
  String get explainFeature => 'Giải thích chức năng';

  @override
  String get downloadFromProfile => 'Tải từ trang cá nhân';

  @override
  String get invalidProfileTitle => 'Thông tin không hợp lệ';

  @override
  String get invalidProfileMessage =>
      'Vui lòng nhập tên người dùng hoặc liên kết trang cá nhân Instagram.';

  @override
  String get profileInfo1 =>
      'Dùng khi bạn muốn xem và tải nhiều nội dung từ một tài khoản Instagram.';

  @override
  String get profileInfo2 =>
      'Nhập tên người dùng hoặc liên kết trang cá nhân, sau đó chọn Story, Reels hoặc bài viết muốn tải.';

  @override
  String get profileInputLabel => 'Tên người dùng hoặc liên kết trang cá nhân';

  @override
  String get profileInputHint => 'Ví dụ: @username hoặc instagram.com/username';

  @override
  String get profileCardDescription =>
      'Nhập tên người dùng hoặc liên kết trang cá nhân để xem Story, Reels và bài viết có thể tải.';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlights';

  @override
  String get reels => 'Reels';

  @override
  String get posts => 'Bài viết';

  @override
  String get photosPosts => 'Ảnh / Bài viết';

  @override
  String get photosVideos => 'Ảnh / Video';

  @override
  String get profileSummary => 'Tổng hợp profile';

  @override
  String get storyModeHint =>
      'Nhập trang cá nhân để xem Story và Highlight có thể tải.';

  @override
  String get reelsModeHint => 'Nhập trang cá nhân để xem danh sách Reels.';

  @override
  String get postsModeHint =>
      'Nhập trang cá nhân để xem các bài viết có thể tải.';

  @override
  String get storyPopupTitle => 'Tải Story từ trang cá nhân';

  @override
  String get reelsPopupTitle => 'Tải Reels từ trang cá nhân';

  @override
  String get postsPopupTitle => 'Tải bài viết từ trang cá nhân';

  @override
  String get viewStory => 'Xem Story';

  @override
  String get viewReels => 'Xem Reels';

  @override
  String get viewPosts => 'Xem bài viết';

  @override
  String get noStoryOrHighlightAll =>
      'Không tìm thấy Story hoặc Highlight. Hãy đăng nhập nếu nội dung cần quyền xem.';

  @override
  String get noStoryOrHighlightInput =>
      'Không tìm thấy Story hoặc Highlight. Hãy nhập trang cá nhân Instagram để kiểm tra.';

  @override
  String get noStoryItems =>
      'Không có nội dung để hiển thị hoặc bạn chưa có quyền xem mục này.';

  @override
  String get noFeedAll =>
      'Không tìm thấy bài viết hoặc video. Hãy đăng nhập nếu nội dung cần quyền xem.';

  @override
  String get noFeedInput =>
      'Chưa có nội dung. Hãy chọn Reels hoặc Bài viết rồi nhập trang cá nhân.';

  @override
  String get endOfContent => 'Bạn đã xem hết nội dung.';

  @override
  String get loadMore => 'Tải thêm';

  @override
  String get loadingMore => 'Đang tải thêm...';

  @override
  String get cannotShowPostContent =>
      'Không thể hiển thị nội dung trong bài viết này.';

  @override
  String get chooseItemToDownload => 'Chọn item để tải';

  @override
  String contentCount(int count) {
    return '$count nội dung';
  }

  @override
  String get chooseThemeColor => 'Chọn màu giao diện';

  @override
  String get themeDefault => 'Mặc định';

  @override
  String get themeVivid => 'Rực rỡ';

  @override
  String get themePink => 'Hồng bóng';

  @override
  String get themeBlue => 'Xanh lam nhạt';

  @override
  String get themeRed => 'Đỏ';

  @override
  String get themeDark => 'Tối';

  @override
  String get loginRequiredTitle => 'Cần đăng nhập';

  @override
  String get followRequiredTitle => 'Cần follow người này';

  @override
  String get followRequiredMessage =>
      'Tài khoản đang đăng nhập chưa có quyền xem nội dung này.';

  @override
  String get downloadSuccessMessage => 'Đã tải xuống thành công.';

  @override
  String get viewHistory => 'Xem lịch sử';

  @override
  String get frequentAccessTooltip => 'Truy cập thường xuyên';

  @override
  String get recentDownloadsTooltip => 'Đã tải gần đây';

  @override
  String get changeThemeTooltip => 'Đổi giao diện';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get themeSettingTitle => 'Giao diện';

  @override
  String get languageSettingTitle => 'Ngôn ngữ';

  @override
  String get chooseLanguageTitle => 'Chọn ngôn ngữ của bạn';

  @override
  String get languageVietnameseNative => 'Tiếng Việt';

  @override
  String get languageVietnameseLocal => 'Tiếng Việt';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'Tiếng Anh';

  @override
  String get sessionModeTitle => 'Chế độ tải';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'Bạn đã kết nối tài khoản Instagram.';

  @override
  String get sessionPrivatePrompt =>
      'Đăng nhập Instagram để tải nội dung mà tài khoản của bạn có quyền xem.';

  @override
  String get sessionPublicPrompt =>
      'Bạn đang tải nội dung công khai mà không cần đăng nhập.';

  @override
  String get profileReelsListTitle => 'Danh sách Video Reel';

  @override
  String get profilePostsListTitle => 'Danh sách Ảnh / Bài viết';

  @override
  String get close => 'Đóng';

  @override
  String get instagramHome => 'Trang chủ Instagram';

  @override
  String get selectThisContent => 'Chọn nội dung này';

  @override
  String get manualOpeningInstagram => 'Đang mở Instagram...';

  @override
  String get manualInstruction =>
      'Mở bài viết, Reel, Story hoặc Highlight bạn muốn tải, sau đó nhấn \"Chọn nội dung này\".';

  @override
  String get manualPickedContent =>
      'Đã chọn được nội dung. Nhấn \"Chọn nội dung này\" để tiếp tục.';

  @override
  String get manualNoDownloadableContent =>
      'Không tìm thấy nội dung có thể tải. Hãy mở một bài viết, Reel, Story hoặc Highlight.';

  @override
  String get manualCloseToExit =>
      'Để tránh mất nội dung đang chọn, vui lòng nhấn \"Đóng\" nếu muốn thoát.';

  @override
  String get loginOpeningInstagram => 'Đang mở Instagram... Vui lòng chờ.';

  @override
  String get loginInstruction =>
      'Đăng nhập vào Instagram, sau đó nhấn \"Lưu\" để hoàn tất.';

  @override
  String get loginChecking => 'Đang xác nhận đăng nhập...';

  @override
  String get loginCannotConfirm =>
      'Không thể xác nhận đăng nhập.\nVui lòng đăng nhập Instagram rồi thử lưu lại.';

  @override
  String get loginSaveError =>
      'Có lỗi xảy ra khi lưu thông tin đăng nhập. Vui lòng thử lại.';

  @override
  String get loginLoggingOut => 'Đang đăng xuất...';

  @override
  String get loginLoggedOut =>
      'Bạn đã đăng xuất khỏi Instagram.\nVui lòng đăng nhập lại để tiếp tục.';

  @override
  String get loginSuccessPrompt =>
      'Đăng nhập thành công.\nNhấn \"Lưu\" để hoàn tất.';

  @override
  String get loginPromptOnLoginPage =>
      'Đăng nhập Instagram rồi bấm \"Lưu\" để hoàn tất.';

  @override
  String get loginPromptSaveBottom =>
      'Nếu đã đăng nhập xong, hãy nhấn \"Lưu\" bên dưới.';

  @override
  String get loginPageTitle => 'Đăng nhập Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'Đang mở Instagram...\nĐăng nhập xong thì bấm \"Lưu\".';

  @override
  String get loginOpenFailed =>
      'Không thể mở Instagram.\nVui lòng kiểm tra kết nối Internet và thử lại.';

  @override
  String get profileSavedMissingUsername => 'Profile đã lưu thiếu username.';

  @override
  String get openingProfile => 'Đang mở trang cá nhân...';

  @override
  String openingUsername(String username) {
    return 'Đang mở @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'Đã tìm thấy $storyCount Story/Highlight và $postCount bài viết.';
  }

  @override
  String get privateModeEnabled => 'Đã bật chế độ Private.';

  @override
  String get publicModeEnabled => 'Đã chuyển về chế độ Public.';

  @override
  String get cannotConfirmInstagramLogin =>
      'Không thể xác nhận đăng nhập Instagram. Vui lòng đăng nhập lại.';

  @override
  String get instagramConnected => 'Đã kết nối tài khoản Instagram.';

  @override
  String get loggingOutInstagram => 'Đang đăng xuất Instagram...';

  @override
  String get instagramLoggedOut => 'Bạn đã đăng xuất khỏi Instagram.';

  @override
  String get instagramLogoutCleanupFailed =>
      'Đã đăng xuất Instagram, nhưng có lỗi khi dọn dữ liệu đăng nhập.';

  @override
  String get emptyInstagramLink => 'Vui lòng nhập liên kết Instagram.';

  @override
  String get preparingContent => 'Đang chuẩn bị nội dung...';

  @override
  String get loadingContentWithAccount =>
      'Đang tải nội dung với tài khoản đã kết nối...';

  @override
  String get cannotFetchContent => 'Không thể lấy nội dung.';

  @override
  String get noDownloadableContentFound =>
      'Không tìm thấy nội dung có thể tải.';

  @override
  String foundDownloadableContent(int count) {
    return 'Đã tìm thấy $count nội dung có thể tải.';
  }

  @override
  String get fetchContentFailedPublic =>
      'Không thể lấy nội dung. Vui lòng kiểm tra liên kết hoặc thử lại.';

  @override
  String get fetchContentFailedPrivate =>
      'Không thể lấy nội dung. Vui lòng kiểm tra quyền xem hoặc đăng nhập lại.';

  @override
  String get emptyProfileInput => 'Vui lòng nhập trang cá nhân Instagram.';

  @override
  String get loadingStoryHighlights => 'Đang tải Story và Highlight...';

  @override
  String get noCurrentStoryOrHighlight =>
      'Không thấy story hiện tại hoặc tin nổi bật.';

  @override
  String foundStoryHighlights(int count) {
    return 'Đã tìm thấy $count Story/Highlight.';
  }

  @override
  String get cannotOpenContent => 'Không thể mở nội dung này.';

  @override
  String openingStoryGroup(String title) {
    return 'Đang mở \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'Đã tìm thấy $count nội dung trong \"$title\".';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'Không thể mở Story hoặc Highlight. Vui lòng đăng nhập rồi thử lại.';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'Không thể mở Story hoặc Highlight. Vui lòng kiểm tra quyền xem.';

  @override
  String get cannotDownloadContent => 'Không thể tải nội dung này.';

  @override
  String get downloadingStory => 'Đang tải story...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'Đã lưu story item vào album $albumName.';
  }

  @override
  String get downloadStoryFailed => 'Tải Story thất bại. Vui lòng thử lại.';

  @override
  String get loadingReelsPublic => 'Đang lấy reels...';

  @override
  String get loadingReelsPrivate => 'Đang tải reels...';

  @override
  String get noReelsOrPermission =>
      'Không tìm thấy Reels hoặc bạn chưa có quyền xem.';

  @override
  String foundReels(int count) {
    return 'Đã tìm thấy $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'Không thể tải Reels. Vui lòng kiểm tra trang cá nhân hoặc thử lại.';

  @override
  String get cannotLoadReelsPrivate =>
      'Không thể tải Reels. Vui lòng kiểm tra quyền xem.';

  @override
  String get loadingPostsPublic => 'Đang lấy ảnh/bài viết...';

  @override
  String get loadingPostsPrivate => 'Đang tải ảnh/bài viết...';

  @override
  String get noPostsOrPermission =>
      'Không tìm thấy ảnh/bài viết hoặc bạn chưa có quyền xem.';

  @override
  String foundPosts(int count) {
    return 'Đã tìm thấy $count ảnh/bài viết.';
  }

  @override
  String get cannotLoadPostsPublic =>
      'Không thể tải bài viết. Vui lòng kiểm tra trang cá nhân hoặc thử lại.';

  @override
  String get cannotLoadPostsPrivate =>
      'Không thể tải bài viết. Vui lòng kiểm tra quyền xem.';

  @override
  String get cannotLoadMoreContent => 'Không thể tải thêm nội dung.';

  @override
  String get cannotLoadMoreProfile =>
      'Không thể tải thêm. Vui lòng nhập lại trang cá nhân.';

  @override
  String get noMoreNewContent => 'Không có thêm nội dung mới.';

  @override
  String loadedMoreContent(int count) {
    return 'Đã tải thêm $count nội dung.';
  }

  @override
  String get loadMoreFailed => 'Tải thêm thất bại. Vui lòng thử lại.';

  @override
  String get openingReel => 'Đang mở Reel...';

  @override
  String get openingPost => 'Đang mở bài viết...';

  @override
  String get cannotOpenContentPermission =>
      'Không thể mở nội dung này. Vui lòng kiểm tra quyền xem hoặc thử lại.';

  @override
  String get downloadingContent => 'Đang tải nội dung...';

  @override
  String savedToAlbum(String albumName) {
    return 'Đã lưu vào album $albumName.';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'Đã lưu nội dung vào album $albumName.';
  }

  @override
  String get downloadContentErrorRetry => 'Tải nội dung lỗi. Bấm thử lại.';

  @override
  String get downloadHistoryCleared => 'Đã xoá lịch sử tải.';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'Đã xoá $count mục khỏi lịch sử.';
  }

  @override
  String get downloadConnectionSlow => 'Tải lỗi do kết nối chậm. Bấm thử lại.';

  @override
  String get downloadNetworkUnavailable =>
      'Không kết nối được mạng/CDN. Kiểm tra mạng rồi thử lại.';

  @override
  String get downloadCancelled => 'Đã hủy tải.';

  @override
  String get downloadGenericError => 'Tải lỗi. Bấm thử lại.';

  @override
  String downloadProgress(String percent) {
    return 'Đang tải nội dung: $percent%';
  }
}
