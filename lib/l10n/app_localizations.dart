import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fil.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fil'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('vi'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'IG Downloader'**
  String get appName;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @understood.
  ///
  /// In vi, this message translates to:
  /// **'Đã hiểu'**
  String get understood;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xoá'**
  String get delete;

  /// No description provided for @deleteAll.
  ///
  /// In vi, this message translates to:
  /// **'Xoá tất cả'**
  String get deleteAll;

  /// No description provided for @share.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ'**
  String get share;

  /// No description provided for @download.
  ///
  /// In vi, this message translates to:
  /// **'Tải'**
  String get download;

  /// No description provided for @downloadAgain.
  ///
  /// In vi, this message translates to:
  /// **'Tải lại'**
  String get downloadAgain;

  /// No description provided for @saved.
  ///
  /// In vi, this message translates to:
  /// **'Đã tải'**
  String get saved;

  /// No description provided for @loading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải'**
  String get loading;

  /// No description provided for @apply.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng'**
  String get apply;

  /// No description provided for @frequentProfilesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Trang cá nhân đã xem gần đây'**
  String get frequentProfilesTitle;

  /// No description provided for @frequentProfilesEmptyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có trang cá nhân nào'**
  String get frequentProfilesEmptyTitle;

  /// No description provided for @frequentProfilesEmptyMessage.
  ///
  /// In vi, this message translates to:
  /// **'Những trang cá nhân bạn đã xem sẽ xuất hiện tại đây.'**
  String get frequentProfilesEmptyMessage;

  /// No description provided for @account.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get account;

  /// No description provided for @downloadHistoryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử tải xuống'**
  String get downloadHistoryTitle;

  /// No description provided for @downloadHistoryEmptyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nội dung nào'**
  String get downloadHistoryEmptyTitle;

  /// No description provided for @downloadHistoryEmptyMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa tải nội dung nào'**
  String get downloadHistoryEmptyMessage;

  /// No description provided for @selectedCount.
  ///
  /// In vi, this message translates to:
  /// **'Đã chọn {count}'**
  String selectedCount(int count);

  /// No description provided for @deleteAllHistoryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xoá tất cả lịch sử?'**
  String get deleteAllHistoryTitle;

  /// No description provided for @deleteAllHistoryMessage.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả mục trong lịch sử tải xuống sẽ bị xoá khỏi ứng dụng.'**
  String get deleteAllHistoryMessage;

  /// No description provided for @deleteSelectedTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xoá {count} mục?'**
  String deleteSelectedTitle(int count);

  /// No description provided for @deleteSelectedOneMessage.
  ///
  /// In vi, this message translates to:
  /// **'Mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.'**
  String get deleteSelectedOneMessage;

  /// No description provided for @deleteSelectedManyMessage.
  ///
  /// In vi, this message translates to:
  /// **'{count} mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.'**
  String deleteSelectedManyMessage(int count);

  /// No description provided for @deleteOneTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xoá mục này?'**
  String get deleteOneTitle;

  /// No description provided for @deleteOneMessage.
  ///
  /// In vi, this message translates to:
  /// **'Mục này sẽ bị xoá khỏi lịch sử tải xuống.'**
  String get deleteOneMessage;

  /// No description provided for @cannotShareFileMissing.
  ///
  /// In vi, this message translates to:
  /// **'Không thể chia sẻ. File không còn tồn tại trên máy.'**
  String get cannotShareFileMissing;

  /// No description provided for @cannotShareContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể chia sẻ nội dung này.'**
  String get cannotShareContent;

  /// No description provided for @cannotSaveAgainFileMissing.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lưu lại. File không còn tồn tại trên máy.'**
  String get cannotSaveAgainFileMissing;

  /// No description provided for @savedAgainToGallery.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu lại vào thư viện.'**
  String get savedAgainToGallery;

  /// No description provided for @cannotSaveAgainContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lưu lại nội dung này.'**
  String get cannotSaveAgainContent;

  /// No description provided for @cannotOpenFileMissing.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở nội dung này. File không còn tồn tại trên máy.'**
  String get cannotOpenFileMissing;

  /// No description provided for @video.
  ///
  /// In vi, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @image.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh'**
  String get image;

  /// No description provided for @content.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung'**
  String get content;

  /// No description provided for @justDownloaded.
  ///
  /// In vi, this message translates to:
  /// **'Vừa tải'**
  String get justDownloaded;

  /// No description provided for @heroTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tải nội dung từ Instagram'**
  String get heroTitle;

  /// No description provided for @heroConnected.
  ///
  /// In vi, this message translates to:
  /// **'Instagram đã được kết nối.'**
  String get heroConnected;

  /// No description provided for @heroDescription.
  ///
  /// In vi, this message translates to:
  /// **'Tải ảnh, reel, story cực nhanh và đơn giản.'**
  String get heroDescription;

  /// No description provided for @downloadByLink.
  ///
  /// In vi, this message translates to:
  /// **'Tải bằng liên kết'**
  String get downloadByLink;

  /// No description provided for @invalidLinkTitle.
  ///
  /// In vi, this message translates to:
  /// **'Liên kết không hợp lệ'**
  String get invalidLinkTitle;

  /// No description provided for @invalidLinkMessage.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập liên kết Instagram của bài viết, Reel, Story hoặc video bạn muốn tải.'**
  String get invalidLinkMessage;

  /// No description provided for @downloadByLinkInfo1.
  ///
  /// In vi, this message translates to:
  /// **'Dùng khi bạn đã có liên kết của một bài viết, Reel, Story hoặc Highlight trên Instagram.'**
  String get downloadByLinkInfo1;

  /// No description provided for @downloadByLinkInfo2.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ cần dán liên kết, ứng dụng sẽ kiểm tra nội dung và cho phép bạn tải xuống.'**
  String get downloadByLinkInfo2;

  /// No description provided for @example.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ:'**
  String get example;

  /// No description provided for @enterInstagramLink.
  ///
  /// In vi, this message translates to:
  /// **'Nhập liên kết Instagram'**
  String get enterInstagramLink;

  /// No description provided for @instagramLinkHint.
  ///
  /// In vi, this message translates to:
  /// **'https://www.instagram.com/p/... hoặc /reel/...'**
  String get instagramLinkHint;

  /// No description provided for @pasteInstagramLinkHint.
  ///
  /// In vi, this message translates to:
  /// **'Dán liên kết Instagram để kiểm tra và tải nội dung bạn muốn.'**
  String get pasteInstagramLinkHint;

  /// No description provided for @openInstagram.
  ///
  /// In vi, this message translates to:
  /// **'Mở Instagram'**
  String get openInstagram;

  /// No description provided for @getContent.
  ///
  /// In vi, this message translates to:
  /// **'Lấy nội dung'**
  String get getContent;

  /// No description provided for @explainFeature.
  ///
  /// In vi, this message translates to:
  /// **'Giải thích chức năng'**
  String get explainFeature;

  /// No description provided for @downloadFromProfile.
  ///
  /// In vi, this message translates to:
  /// **'Tải từ trang cá nhân'**
  String get downloadFromProfile;

  /// No description provided for @invalidProfileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin không hợp lệ'**
  String get invalidProfileTitle;

  /// No description provided for @invalidProfileMessage.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên người dùng hoặc liên kết trang cá nhân Instagram.'**
  String get invalidProfileMessage;

  /// No description provided for @profileInfo1.
  ///
  /// In vi, this message translates to:
  /// **'Dùng khi bạn muốn xem và tải nhiều nội dung từ một tài khoản Instagram.'**
  String get profileInfo1;

  /// No description provided for @profileInfo2.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên người dùng hoặc liên kết trang cá nhân, sau đó chọn Story, Reels hoặc bài viết muốn tải.'**
  String get profileInfo2;

  /// No description provided for @profileInputLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tên người dùng hoặc liên kết trang cá nhân'**
  String get profileInputLabel;

  /// No description provided for @profileInputHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: @username hoặc instagram.com/username'**
  String get profileInputHint;

  /// No description provided for @profileCardDescription.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên người dùng hoặc liên kết trang cá nhân để xem Story, Reels và bài viết có thể tải.'**
  String get profileCardDescription;

  /// No description provided for @story.
  ///
  /// In vi, this message translates to:
  /// **'Story'**
  String get story;

  /// No description provided for @storiesHighlights.
  ///
  /// In vi, this message translates to:
  /// **'Stories / Highlights'**
  String get storiesHighlights;

  /// No description provided for @reels.
  ///
  /// In vi, this message translates to:
  /// **'Reels'**
  String get reels;

  /// No description provided for @posts.
  ///
  /// In vi, this message translates to:
  /// **'Bài viết'**
  String get posts;

  /// No description provided for @photosPosts.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh / Bài viết'**
  String get photosPosts;

  /// No description provided for @photosVideos.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh / Video'**
  String get photosVideos;

  /// No description provided for @profileSummary.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin trang cá nhân'**
  String get profileSummary;

  /// No description provided for @storyModeHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập trang cá nhân để xem Story và Highlight có thể tải.'**
  String get storyModeHint;

  /// No description provided for @reelsModeHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập trang cá nhân để xem danh sách Reels.'**
  String get reelsModeHint;

  /// No description provided for @postsModeHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập trang cá nhân để xem các bài viết có thể tải.'**
  String get postsModeHint;

  /// No description provided for @storyPopupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tải Story từ trang cá nhân'**
  String get storyPopupTitle;

  /// No description provided for @reelsPopupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tải Reels từ trang cá nhân'**
  String get reelsPopupTitle;

  /// No description provided for @postsPopupTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tải bài viết từ trang cá nhân'**
  String get postsPopupTitle;

  /// No description provided for @viewStory.
  ///
  /// In vi, this message translates to:
  /// **'Xem Story'**
  String get viewStory;

  /// No description provided for @viewReels.
  ///
  /// In vi, this message translates to:
  /// **'Xem Reels'**
  String get viewReels;

  /// No description provided for @viewPosts.
  ///
  /// In vi, this message translates to:
  /// **'Xem bài viết'**
  String get viewPosts;

  /// No description provided for @noStoryOrHighlightAll.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy Story hoặc Highlight. Hãy đăng nhập nếu nội dung cần quyền xem.'**
  String get noStoryOrHighlightAll;

  /// No description provided for @noStoryOrHighlightInput.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy Story hoặc Highlight. Hãy nhập trang cá nhân Instagram để kiểm tra.'**
  String get noStoryOrHighlightInput;

  /// No description provided for @noStoryItems.
  ///
  /// In vi, this message translates to:
  /// **'Không có nội dung để hiển thị hoặc bạn chưa có quyền xem mục này.'**
  String get noStoryItems;

  /// No description provided for @noFeedAll.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy bài viết hoặc video. Hãy đăng nhập nếu nội dung cần quyền xem.'**
  String get noFeedAll;

  /// No description provided for @noFeedInput.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nội dung. Hãy chọn Reels hoặc Bài viết rồi nhập trang cá nhân.'**
  String get noFeedInput;

  /// No description provided for @endOfContent.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã xem hết nội dung.'**
  String get endOfContent;

  /// No description provided for @loadMore.
  ///
  /// In vi, this message translates to:
  /// **'Tải thêm'**
  String get loadMore;

  /// No description provided for @loadingMore.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải thêm...'**
  String get loadingMore;

  /// No description provided for @cannotShowPostContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể hiển thị nội dung trong bài viết này.'**
  String get cannotShowPostContent;

  /// No description provided for @chooseItemToDownload.
  ///
  /// In vi, this message translates to:
  /// **'Chọn mục muốn tải'**
  String get chooseItemToDownload;

  /// No description provided for @contentCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} nội dung'**
  String contentCount(int count);

  /// No description provided for @chooseThemeColor.
  ///
  /// In vi, this message translates to:
  /// **'Chọn màu giao diện'**
  String get chooseThemeColor;

  /// No description provided for @themeDefault.
  ///
  /// In vi, this message translates to:
  /// **'Mặc định'**
  String get themeDefault;

  /// No description provided for @themeVivid.
  ///
  /// In vi, this message translates to:
  /// **'Rực rỡ'**
  String get themeVivid;

  /// No description provided for @themePink.
  ///
  /// In vi, this message translates to:
  /// **'Hồng bóng'**
  String get themePink;

  /// No description provided for @themeBlue.
  ///
  /// In vi, this message translates to:
  /// **'Xanh lam nhạt'**
  String get themeBlue;

  /// No description provided for @themeRed.
  ///
  /// In vi, this message translates to:
  /// **'Đỏ'**
  String get themeRed;

  /// No description provided for @themeDark.
  ///
  /// In vi, this message translates to:
  /// **'Tối'**
  String get themeDark;

  /// No description provided for @loginRequiredTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cần đăng nhập'**
  String get loginRequiredTitle;

  /// No description provided for @followRequiredTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cần follow người này'**
  String get followRequiredTitle;

  /// No description provided for @followRequiredMessage.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản đang đăng nhập chưa có quyền xem nội dung này.'**
  String get followRequiredMessage;

  /// No description provided for @downloadSuccessMessage.
  ///
  /// In vi, this message translates to:
  /// **'Đã tải xuống thành công.'**
  String get downloadSuccessMessage;

  /// No description provided for @viewHistory.
  ///
  /// In vi, this message translates to:
  /// **'Xem lịch sử'**
  String get viewHistory;

  /// No description provided for @frequentAccessTooltip.
  ///
  /// In vi, this message translates to:
  /// **'Truy cập thường xuyên'**
  String get frequentAccessTooltip;

  /// No description provided for @recentDownloadsTooltip.
  ///
  /// In vi, this message translates to:
  /// **'Đã tải gần đây'**
  String get recentDownloadsTooltip;

  /// No description provided for @changeThemeTooltip.
  ///
  /// In vi, this message translates to:
  /// **'Đổi giao diện'**
  String get changeThemeTooltip;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingsTitle;

  /// No description provided for @themeSettingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get themeSettingTitle;

  /// No description provided for @languageSettingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get languageSettingTitle;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ của bạn'**
  String get chooseLanguageTitle;

  /// No description provided for @languageVietnameseNative.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnameseNative;

  /// No description provided for @languageVietnameseLocal.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnameseLocal;

  /// No description provided for @languageEnglishNative.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get languageEnglishNative;

  /// No description provided for @languageEnglishLocal.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Anh'**
  String get languageEnglishLocal;

  /// No description provided for @sessionModeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chế độ tải'**
  String get sessionModeTitle;

  /// No description provided for @sessionPublicMode.
  ///
  /// In vi, this message translates to:
  /// **'Public'**
  String get sessionPublicMode;

  /// No description provided for @sessionPrivateMode.
  ///
  /// In vi, this message translates to:
  /// **'Private'**
  String get sessionPrivateMode;

  /// No description provided for @sessionPrivateConnected.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã kết nối tài khoản Instagram.'**
  String get sessionPrivateConnected;

  /// No description provided for @sessionPrivatePrompt.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập Instagram để tải nội dung mà tài khoản của bạn có quyền xem.'**
  String get sessionPrivatePrompt;

  /// No description provided for @sessionPublicPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đang tải nội dung công khai mà không cần đăng nhập.'**
  String get sessionPublicPrompt;

  /// No description provided for @profileReelsListTitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách Video Reel'**
  String get profileReelsListTitle;

  /// No description provided for @profilePostsListTitle.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách Ảnh / Bài viết'**
  String get profilePostsListTitle;

  /// No description provided for @close.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get close;

  /// No description provided for @instagramHome.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ Instagram'**
  String get instagramHome;

  /// No description provided for @selectThisContent.
  ///
  /// In vi, this message translates to:
  /// **'Chọn nội dung này'**
  String get selectThisContent;

  /// No description provided for @manualOpeningInstagram.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở Instagram...'**
  String get manualOpeningInstagram;

  /// No description provided for @manualInstruction.
  ///
  /// In vi, this message translates to:
  /// **'Mở bài viết, Reel, Story hoặc Highlight bạn muốn tải, sau đó nhấn \"Chọn nội dung này\".'**
  String get manualInstruction;

  /// No description provided for @manualPickedContent.
  ///
  /// In vi, this message translates to:
  /// **'Đã chọn được nội dung. Nhấn \"Chọn nội dung này\" để tiếp tục.'**
  String get manualPickedContent;

  /// No description provided for @manualNoDownloadableContent.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy nội dung có thể tải. Hãy mở một bài viết, Reel, Story hoặc Highlight.'**
  String get manualNoDownloadableContent;

  /// No description provided for @manualCloseToExit.
  ///
  /// In vi, this message translates to:
  /// **'Để tránh mất nội dung đang chọn, vui lòng nhấn \"Đóng\" nếu muốn thoát.'**
  String get manualCloseToExit;

  /// No description provided for @loginOpeningInstagram.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở Instagram... Vui lòng chờ.'**
  String get loginOpeningInstagram;

  /// No description provided for @loginInstruction.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập vào Instagram, sau đó nhấn \"Lưu\" để hoàn tất.'**
  String get loginInstruction;

  /// No description provided for @loginChecking.
  ///
  /// In vi, this message translates to:
  /// **'Đang xác nhận đăng nhập...'**
  String get loginChecking;

  /// No description provided for @loginCannotConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Không thể xác nhận đăng nhập.\nVui lòng đăng nhập Instagram rồi thử lưu lại.'**
  String get loginCannotConfirm;

  /// No description provided for @loginSaveError.
  ///
  /// In vi, this message translates to:
  /// **'Có lỗi xảy ra khi lưu thông tin đăng nhập. Vui lòng thử lại.'**
  String get loginSaveError;

  /// No description provided for @loginLoggingOut.
  ///
  /// In vi, this message translates to:
  /// **'Đang đăng xuất...'**
  String get loginLoggingOut;

  /// No description provided for @loginLoggedOut.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã đăng xuất khỏi Instagram.\nVui lòng đăng nhập lại để tiếp tục.'**
  String get loginLoggedOut;

  /// No description provided for @loginSuccessPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thành công.\nNhấn \"Lưu\" để hoàn tất.'**
  String get loginSuccessPrompt;

  /// No description provided for @loginPromptOnLoginPage.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập Instagram rồi bấm \"Lưu\" để hoàn tất.'**
  String get loginPromptOnLoginPage;

  /// No description provided for @loginPromptSaveBottom.
  ///
  /// In vi, this message translates to:
  /// **'Nếu đã đăng nhập xong, hãy nhấn \"Lưu\" bên dưới.'**
  String get loginPromptSaveBottom;

  /// No description provided for @loginPageTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập Instagram'**
  String get loginPageTitle;

  /// No description provided for @loginOpeningInstagramWithHint.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở Instagram...\nĐăng nhập xong thì bấm \"Lưu\".'**
  String get loginOpeningInstagramWithHint;

  /// No description provided for @loginOpenFailed.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở Instagram.\nVui lòng kiểm tra kết nối Internet và thử lại.'**
  String get loginOpenFailed;

  /// No description provided for @profileSavedMissingUsername.
  ///
  /// In vi, this message translates to:
  /// **'Profile đã lưu thiếu username.'**
  String get profileSavedMissingUsername;

  /// No description provided for @openingProfile.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở trang cá nhân...'**
  String get openingProfile;

  /// No description provided for @openingUsername.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở @{username}...'**
  String openingUsername(String username);

  /// No description provided for @foundStoryHighlightsAndPosts.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {storyCount} Story/Highlight và {postCount} bài viết.'**
  String foundStoryHighlightsAndPosts(int storyCount, int postCount);

  /// No description provided for @privateModeEnabled.
  ///
  /// In vi, this message translates to:
  /// **'Đã bật chế độ Private.'**
  String get privateModeEnabled;

  /// No description provided for @publicModeEnabled.
  ///
  /// In vi, this message translates to:
  /// **'Đã chuyển về chế độ Public.'**
  String get publicModeEnabled;

  /// No description provided for @cannotConfirmInstagramLogin.
  ///
  /// In vi, this message translates to:
  /// **'Không thể xác nhận đăng nhập Instagram. Vui lòng đăng nhập lại.'**
  String get cannotConfirmInstagramLogin;

  /// No description provided for @instagramConnected.
  ///
  /// In vi, this message translates to:
  /// **'Đã kết nối tài khoản Instagram.'**
  String get instagramConnected;

  /// No description provided for @loggingOutInstagram.
  ///
  /// In vi, this message translates to:
  /// **'Đang đăng xuất Instagram...'**
  String get loggingOutInstagram;

  /// No description provided for @instagramLoggedOut.
  ///
  /// In vi, this message translates to:
  /// **'Bạn đã đăng xuất khỏi Instagram.'**
  String get instagramLoggedOut;

  /// No description provided for @instagramLogoutCleanupFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đã đăng xuất Instagram, nhưng có lỗi khi dọn dữ liệu đăng nhập.'**
  String get instagramLogoutCleanupFailed;

  /// No description provided for @emptyInstagramLink.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập liên kết Instagram.'**
  String get emptyInstagramLink;

  /// No description provided for @preparingContent.
  ///
  /// In vi, this message translates to:
  /// **'Đang chuẩn bị nội dung...'**
  String get preparingContent;

  /// No description provided for @loadingContentWithAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải nội dung với tài khoản đã kết nối...'**
  String get loadingContentWithAccount;

  /// No description provided for @cannotFetchContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lấy nội dung.'**
  String get cannotFetchContent;

  /// No description provided for @noDownloadableContentFound.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy nội dung có thể tải.'**
  String get noDownloadableContentFound;

  /// No description provided for @foundDownloadableContent.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {count} nội dung có thể tải.'**
  String foundDownloadableContent(int count);

  /// No description provided for @fetchContentFailedPublic.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lấy nội dung. Vui lòng kiểm tra liên kết hoặc thử lại.'**
  String get fetchContentFailedPublic;

  /// No description provided for @fetchContentFailedPrivate.
  ///
  /// In vi, this message translates to:
  /// **'Không thể lấy nội dung. Vui lòng kiểm tra quyền xem hoặc đăng nhập lại.'**
  String get fetchContentFailedPrivate;

  /// No description provided for @emptyProfileInput.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập trang cá nhân Instagram.'**
  String get emptyProfileInput;

  /// No description provided for @loadingStoryHighlights.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải Story và Highlight...'**
  String get loadingStoryHighlights;

  /// No description provided for @noCurrentStoryOrHighlight.
  ///
  /// In vi, this message translates to:
  /// **'Không thấy story hiện tại hoặc tin nổi bật.'**
  String get noCurrentStoryOrHighlight;

  /// No description provided for @foundStoryHighlights.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {count} Story/Highlight.'**
  String foundStoryHighlights(int count);

  /// No description provided for @cannotOpenContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở nội dung này.'**
  String get cannotOpenContent;

  /// No description provided for @openingStoryGroup.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở \"{title}\"...'**
  String openingStoryGroup(String title);

  /// No description provided for @foundStoryGroupItems.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {count} nội dung trong \"{title}\".'**
  String foundStoryGroupItems(int count, String title);

  /// No description provided for @cannotOpenStoryHighlightLogin.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở Story hoặc Highlight. Vui lòng đăng nhập rồi thử lại.'**
  String get cannotOpenStoryHighlightLogin;

  /// No description provided for @cannotOpenStoryHighlightPermission.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở Story hoặc Highlight. Vui lòng kiểm tra quyền xem.'**
  String get cannotOpenStoryHighlightPermission;

  /// No description provided for @cannotDownloadContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải nội dung này.'**
  String get cannotDownloadContent;

  /// No description provided for @downloadingStory.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải story...'**
  String get downloadingStory;

  /// No description provided for @savedStoryToAlbum.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu story vào album {albumName}.'**
  String savedStoryToAlbum(String albumName);

  /// No description provided for @downloadStoryFailed.
  ///
  /// In vi, this message translates to:
  /// **'Tải Story thất bại. Vui lòng thử lại.'**
  String get downloadStoryFailed;

  /// No description provided for @loadingReelsPublic.
  ///
  /// In vi, this message translates to:
  /// **'Đang lấy reels...'**
  String get loadingReelsPublic;

  /// No description provided for @loadingReelsPrivate.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải reels...'**
  String get loadingReelsPrivate;

  /// No description provided for @noReelsOrPermission.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy Reels hoặc bạn chưa có quyền xem.'**
  String get noReelsOrPermission;

  /// No description provided for @foundReels.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {count} Reels.'**
  String foundReels(int count);

  /// No description provided for @cannotLoadReelsPublic.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải Reels. Vui lòng kiểm tra trang cá nhân hoặc thử lại.'**
  String get cannotLoadReelsPublic;

  /// No description provided for @cannotLoadReelsPrivate.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải Reels. Vui lòng kiểm tra quyền xem.'**
  String get cannotLoadReelsPrivate;

  /// No description provided for @loadingPostsPublic.
  ///
  /// In vi, this message translates to:
  /// **'Đang lấy ảnh/bài viết...'**
  String get loadingPostsPublic;

  /// No description provided for @loadingPostsPrivate.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải ảnh/bài viết...'**
  String get loadingPostsPrivate;

  /// No description provided for @noPostsOrPermission.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy ảnh/bài viết hoặc bạn chưa có quyền xem.'**
  String get noPostsOrPermission;

  /// No description provided for @foundPosts.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy {count} ảnh/bài viết.'**
  String foundPosts(int count);

  /// No description provided for @cannotLoadPostsPublic.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải bài viết. Vui lòng kiểm tra trang cá nhân hoặc thử lại.'**
  String get cannotLoadPostsPublic;

  /// No description provided for @cannotLoadPostsPrivate.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải bài viết. Vui lòng kiểm tra quyền xem.'**
  String get cannotLoadPostsPrivate;

  /// No description provided for @cannotLoadMoreContent.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải thêm nội dung.'**
  String get cannotLoadMoreContent;

  /// No description provided for @cannotLoadMoreProfile.
  ///
  /// In vi, this message translates to:
  /// **'Không thể tải thêm. Vui lòng nhập lại trang cá nhân.'**
  String get cannotLoadMoreProfile;

  /// No description provided for @noMoreNewContent.
  ///
  /// In vi, this message translates to:
  /// **'Không có thêm nội dung mới.'**
  String get noMoreNewContent;

  /// No description provided for @loadedMoreContent.
  ///
  /// In vi, this message translates to:
  /// **'Đã tải thêm {count} nội dung.'**
  String loadedMoreContent(int count);

  /// No description provided for @loadMoreFailed.
  ///
  /// In vi, this message translates to:
  /// **'Tải thêm thất bại. Vui lòng thử lại.'**
  String get loadMoreFailed;

  /// No description provided for @openingReel.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở Reel...'**
  String get openingReel;

  /// No description provided for @openingPost.
  ///
  /// In vi, this message translates to:
  /// **'Đang mở bài viết...'**
  String get openingPost;

  /// No description provided for @cannotOpenContentPermission.
  ///
  /// In vi, this message translates to:
  /// **'Không thể mở nội dung này. Vui lòng kiểm tra quyền xem hoặc thử lại.'**
  String get cannotOpenContentPermission;

  /// No description provided for @downloadingContent.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải nội dung...'**
  String get downloadingContent;

  /// No description provided for @savedToAlbum.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu vào album {albumName}.'**
  String savedToAlbum(String albumName);

  /// No description provided for @savedContentToAlbum.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu nội dung vào album {albumName}.'**
  String savedContentToAlbum(String albumName);

  /// No description provided for @downloadContentErrorRetry.
  ///
  /// In vi, this message translates to:
  /// **'Tải nội dung lỗi. Bấm thử lại.'**
  String get downloadContentErrorRetry;

  /// No description provided for @downloadHistoryCleared.
  ///
  /// In vi, this message translates to:
  /// **'Đã xoá lịch sử tải.'**
  String get downloadHistoryCleared;

  /// No description provided for @downloadHistoryItemsRemoved.
  ///
  /// In vi, this message translates to:
  /// **'Đã xoá {count} mục khỏi lịch sử.'**
  String downloadHistoryItemsRemoved(int count);

  /// No description provided for @downloadConnectionSlow.
  ///
  /// In vi, this message translates to:
  /// **'Tải lỗi do kết nối chậm. Bấm thử lại.'**
  String get downloadConnectionSlow;

  /// No description provided for @downloadNetworkUnavailable.
  ///
  /// In vi, this message translates to:
  /// **'Không kết nối được mạng/CDN. Kiểm tra mạng rồi thử lại.'**
  String get downloadNetworkUnavailable;

  /// No description provided for @downloadCancelled.
  ///
  /// In vi, this message translates to:
  /// **'Đã hủy tải.'**
  String get downloadCancelled;

  /// No description provided for @downloadGenericError.
  ///
  /// In vi, this message translates to:
  /// **'Tải lỗi. Bấm thử lại.'**
  String get downloadGenericError;

  /// No description provided for @downloadProgress.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải nội dung: {percent}%'**
  String downloadProgress(String percent);

  /// No description provided for @legalLinksTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách quyền riêng tư & Điều khoản'**
  String get legalLinksTitle;

  /// No description provided for @termsOfUse.
  ///
  /// In vi, this message translates to:
  /// **'Điều khoản sử dụng'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách quyền riêng tư'**
  String get privacyPolicy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fil',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'ms',
    'pt',
    'ru',
    'th',
    'tr',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fil':
      return AppLocalizationsFil();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
