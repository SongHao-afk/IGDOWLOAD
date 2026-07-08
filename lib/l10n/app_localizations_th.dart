// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appName => 'IG Downloader';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get save => 'บันทึก';

  @override
  String get login => 'เข้าสู่ระบบ';

  @override
  String get logout => 'ออกจากระบบ';

  @override
  String get understood => 'เข้าใจแล้ว';

  @override
  String get delete => 'ลบ';

  @override
  String get deleteAll => 'ลบทั้งหมด';

  @override
  String get share => 'แบ่งปัน';

  @override
  String get download => 'ดาวน์โหลด';

  @override
  String get downloadAgain => 'ดาวน์โหลดอีกครั้ง';

  @override
  String get saved => 'ดาวน์โหลดแล้ว';

  @override
  String get loading => 'กำลังโหลด';

  @override
  String get apply => 'นำมาใช้';

  @override
  String get frequentProfilesTitle => 'โปรไฟล์ที่ดูล่าสุด';

  @override
  String get frequentProfilesEmptyTitle => 'ยังไม่มีโปรไฟล์';

  @override
  String get frequentProfilesEmptyMessage => 'โปรไฟล์ที่คุณดูจะปรากฏที่นี่';

  @override
  String get account => 'บัญชี';

  @override
  String get downloadHistoryTitle => 'ประวัติการดาวน์โหลด';

  @override
  String get downloadHistoryEmptyTitle => 'ยังไม่มีเนื้อหา';

  @override
  String get downloadHistoryEmptyMessage => 'คุณยังไม่ได้ดาวน์โหลดเนื้อหาใดๆ';

  @override
  String selectedCount(int count) {
    return '$count เลือกแล้ว';
  }

  @override
  String get deleteAllHistoryTitle => 'ลบประวัติทั้งหมดใช่ไหม';

  @override
  String get deleteAllHistoryMessage =>
      'รายการทั้งหมดในประวัติการดาวน์โหลดของคุณจะถูกลบออกจากแอป';

  @override
  String deleteSelectedTitle(int count) {
    return 'ลบ $count รายการหรือไม่';
  }

  @override
  String get deleteSelectedOneMessage =>
      'รายการที่เลือกจะถูกลบออกจากประวัติการดาวน์โหลดของคุณ';

  @override
  String deleteSelectedManyMessage(int count) {
    return '$count รายการที่เลือกจะถูกลบออกจากประวัติการดาวน์โหลดของคุณ';
  }

  @override
  String get deleteOneTitle => 'ลบรายการนี้ใช่ไหม';

  @override
  String get deleteOneMessage =>
      'รายการนี้จะถูกลบออกจากประวัติการดาวน์โหลดของคุณ';

  @override
  String get cannotShareFileMissing =>
      'ไม่สามารถแบ่งปันได้ ไฟล์ไม่มีอยู่ในอุปกรณ์นี้แล้ว';

  @override
  String get cannotShareContent => 'ไม่สามารถแบ่งปันเนื้อหานี้ได้';

  @override
  String get cannotSaveAgainFileMissing =>
      'ไม่สามารถบันทึกอีกครั้งได้ ไฟล์ไม่มีอยู่ในอุปกรณ์นี้แล้ว';

  @override
  String get savedAgainToGallery => 'บันทึกอีกครั้งในแกลเลอรี';

  @override
  String get cannotSaveAgainContent => 'ไม่สามารถบันทึกเนื้อหานี้อีกครั้ง';

  @override
  String get cannotOpenFileMissing =>
      'ไม่สามารถเปิดเนื้อหานี้ได้ ไฟล์ไม่มีอยู่ในอุปกรณ์นี้แล้ว';

  @override
  String get video => 'วีดีโอ';

  @override
  String get image => 'รูปถ่าย';

  @override
  String get content => 'เนื้อหา';

  @override
  String get justDownloaded => 'เพิ่งดาวน์โหลด';

  @override
  String get heroTitle => 'ดาวน์โหลดเนื้อหาจาก Instagram';

  @override
  String get heroConnected => 'Instagram เชื่อมต่ออยู่';

  @override
  String get heroDescription =>
      'ดาวน์โหลดรูปภาพ ม้วนฟิล์ม และเรื่องราวได้อย่างรวดเร็วและง่ายดาย';

  @override
  String get downloadByLink => 'ดาวน์โหลดได้ตามลิงค์';

  @override
  String get invalidLinkTitle => 'ลิงก์ไม่ถูกต้อง';

  @override
  String get invalidLinkMessage =>
      'โปรดป้อนลิงก์ Instagram สำหรับโพสต์ Reel Story หรือวิดีโอที่คุณต้องการดาวน์โหลด';

  @override
  String get downloadByLinkInfo1 =>
      'ใช้สิ่งนี้เมื่อคุณมีลิงก์ไปยังโพสต์ Instagram, Reel, Story หรือ Highlight อยู่แล้ว';

  @override
  String get downloadByLinkInfo2 =>
      'วางลิงก์แล้วแอปจะตรวจสอบเนื้อหาและให้คุณดาวน์โหลด';

  @override
  String get example => 'ตัวอย่าง:';

  @override
  String get enterInstagramLink => 'ป้อน Instagram ลิงก์';

  @override
  String get instagramLinkHint =>
      'https://www.instagram.com/p/... หรือ /reel/...';

  @override
  String get pasteInstagramLinkHint =>
      'วางลิงก์ Instagram เพื่อตรวจสอบและดาวน์โหลดเนื้อหาที่คุณต้องการ';

  @override
  String get openInstagram => 'เปิด Instagram';

  @override
  String get getContent => 'รับเนื้อหา';

  @override
  String get explainFeature => 'อธิบายคุณสมบัติ';

  @override
  String get downloadFromProfile => 'ดาวน์โหลดจากโปรไฟล์';

  @override
  String get invalidProfileTitle => 'ข้อมูลไม่ถูกต้อง';

  @override
  String get invalidProfileMessage =>
      'โปรดป้อน Instagram ชื่อผู้ใช้หรือลิงก์โปรไฟล์';

  @override
  String get profileInfo1 =>
      'ใช้ตัวเลือกนี้เมื่อคุณต้องการดูและดาวน์โหลดหลายรายการจากบัญชี Instagram';

  @override
  String get profileInfo2 =>
      'ป้อนชื่อผู้ใช้หรือลิงก์โปรไฟล์ จากนั้นเลือก Story Reels หรือโพสต์ที่คุณต้องการดาวน์โหลด';

  @override
  String get profileInputLabel => 'ชื่อผู้ใช้หรือลิงค์โปรไฟล์';

  @override
  String get profileInputHint =>
      'ตัวอย่าง: @username หรือ instagram.com/username';

  @override
  String get profileCardDescription =>
      'ป้อนชื่อผู้ใช้หรือลิงก์โปรไฟล์เพื่อดู Stories, Reels และโพสต์ที่ดาวน์โหลดได้';

  @override
  String get story => 'Story';

  @override
  String get storiesHighlights => 'Stories / Highlightส';

  @override
  String get reels => 'ส';

  @override
  String get posts => 'กระทู้';

  @override
  String get photosPosts => 'รูปภาพ / โพสต์';

  @override
  String get photosVideos => 'ภาพถ่าย / วิดีโอ';

  @override
  String get profileSummary => 'สรุปโปรไฟล์';

  @override
  String get storyModeHint =>
      'ป้อนโปรไฟล์เพื่อดู Stories และ Highlights ที่ดาวน์โหลดได้';

  @override
  String get reelsModeHint => 'ป้อนโปรไฟล์เพื่อดูรายการ Reel';

  @override
  String get postsModeHint => 'ป้อนโปรไฟล์เพื่อดูโพสต์ที่ดาวน์โหลดได้';

  @override
  String get storyPopupTitle => 'ดาวน์โหลด Stories จากโปรไฟล์';

  @override
  String get reelsPopupTitle => 'ดาวน์โหลดจากโปรไฟล์';

  @override
  String get postsPopupTitle => 'ดาวน์โหลดโพสต์จากโปรไฟล์';

  @override
  String get viewStory => 'ดู Story';

  @override
  String get viewReels => 'ดู Reels';

  @override
  String get viewPosts => 'ดูโพสต์';

  @override
  String get noStoryOrHighlightAll =>
      'ไม่พบ Story หรือ Highlight เข้าสู่ระบบหากเนื้อหาต้องได้รับอนุญาตในการดู';

  @override
  String get noStoryOrHighlightInput =>
      'ไม่พบ Story หรือ Highlight ป้อนโปรไฟล์ Instagram เพื่อตรวจสอบ';

  @override
  String get noStoryItems =>
      'ไม่มีเนื้อหาที่จะแสดง หรือคุณไม่ได้รับอนุญาตให้ดูรายการนี้';

  @override
  String get noFeedAll =>
      'ไม่พบโพสต์หรือวิดีโอ เข้าสู่ระบบหากเนื้อหาต้องได้รับอนุญาตในการดู';

  @override
  String get noFeedInput =>
      'ยังไม่มีเนื้อหา เลือก Reels หรือ โพสต์ จากนั้นป้อนโปรไฟล์';

  @override
  String get endOfContent => 'คุณมาถึงจุดสิ้นสุดของเนื้อหาแล้ว';

  @override
  String get loadMore => 'โหลดเพิ่ม';

  @override
  String get loadingMore => 'กำลังโหลดเพิ่มเติม...';

  @override
  String get cannotShowPostContent => 'ไม่สามารถแสดงเนื้อหาในโพสต์นี้ได้';

  @override
  String get chooseItemToDownload => 'เลือกรายการที่จะดาวน์โหลด';

  @override
  String contentCount(int count) {
    return '$count รายการ';
  }

  @override
  String get chooseThemeColor => 'เลือกสีของธีม';

  @override
  String get themeDefault => 'ค่าเริ่มต้น';

  @override
  String get themeVivid => 'สดใส';

  @override
  String get themePink => 'สีชมพูมันวาว';

  @override
  String get themeBlue => 'ฟ้าอ่อน';

  @override
  String get themeRed => 'สีแดง';

  @override
  String get themeDark => 'มืด';

  @override
  String get loginRequiredTitle => 'ต้องเข้าสู่ระบบ';

  @override
  String get followRequiredTitle => 'ต้องติดตาม';

  @override
  String get followRequiredMessage =>
      'บัญชีที่เข้าสู่ระบบไม่ได้รับอนุญาตให้ดูเนื้อหานี้';

  @override
  String get downloadSuccessMessage => 'ดาวน์โหลดสำเร็จแล้ว';

  @override
  String get viewHistory => 'ดูประวัติ';

  @override
  String get frequentAccessTooltip => 'เข้าถึงได้บ่อยครั้ง';

  @override
  String get recentDownloadsTooltip => 'ดาวน์โหลดล่าสุด';

  @override
  String get changeThemeTooltip => 'เปลี่ยนธีม';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get themeSettingTitle => 'ธีม';

  @override
  String get languageSettingTitle => 'ภาษา';

  @override
  String get chooseLanguageTitle => 'เลือกภาษาของคุณ';

  @override
  String get languageVietnameseNative => 'Ti?ng Vi?t';

  @override
  String get languageVietnameseLocal => 'Vietnamese';

  @override
  String get languageEnglishNative => 'English';

  @override
  String get languageEnglishLocal => 'English';

  @override
  String get sessionModeTitle => 'โหมดดาวน์โหลด';

  @override
  String get sessionPublicMode => 'Public';

  @override
  String get sessionPrivateMode => 'Private';

  @override
  String get sessionPrivateConnected => 'บัญชี Instagram ของคุณเชื่อมต่อแล้ว';

  @override
  String get sessionPrivatePrompt =>
      'เข้าสู่ระบบ Instagram เพื่อดาวน์โหลดเนื้อหาที่บัญชีของคุณได้รับอนุญาตให้ดู';

  @override
  String get sessionPublicPrompt =>
      'คุณกำลังดาวน์โหลดเนื้อหาสาธารณะโดยไม่ได้เข้าสู่ระบบ';

  @override
  String get profileReelsListTitle => 'Reel รายการวิดีโอ';

  @override
  String get profilePostsListTitle => 'รูปภาพ / รายการโพสต์';

  @override
  String get close => 'ปิด';

  @override
  String get instagramHome => 'Instagram บ้าน';

  @override
  String get selectThisContent => 'เลือกเนื้อหานี้';

  @override
  String get manualOpeningInstagram => 'กำลังเปิด Instagram...';

  @override
  String get manualInstruction =>
      'เปิดโพสต์ Reel, Story หรือ Highlight ที่คุณต้องการดาวน์โหลด จากนั้นแตะ \"เลือกเนื้อหานี้\"';

  @override
  String get manualPickedContent =>
      'เลือกเนื้อหาแล้ว แตะ \"เลือกเนื้อหานี้\" เพื่อดำเนินการต่อ';

  @override
  String get manualNoDownloadableContent =>
      'ไม่พบเนื้อหาที่ดาวน์โหลดได้ เปิดโพสต์ Reel, Story หรือ Highlight';

  @override
  String get manualCloseToExit =>
      'เพื่อหลีกเลี่ยงการสูญเสียเนื้อหาที่เลือก ให้แตะ \"ปิด\" หากคุณต้องการออก';

  @override
  String get loginOpeningInstagram => 'กำลังเปิด Instagram... กรุณารอสักครู่.';

  @override
  String get loginInstruction =>
      'เข้าสู่ระบบ Instagram จากนั้นแตะ \"บันทึก\" เพื่อเสร็จสิ้น';

  @override
  String get loginChecking => 'กำลังตรวจสอบการเข้าสู่ระบบ...';

  @override
  String get loginCannotConfirm =>
      'ไม่สามารถยืนยันการเข้าสู่ระบบได้\nโปรดเข้าสู่ระบบ Instagram และลองบันทึกอีกครั้ง';

  @override
  String get loginSaveError =>
      'เกิดข้อผิดพลาดขณะบันทึกข้อมูลการเข้าสู่ระบบ โปรดลองอีกครั้ง';

  @override
  String get loginLoggingOut => 'กำลังออกจากระบบ...';

  @override
  String get loginLoggedOut =>
      'คุณได้ออกจากระบบ Instagram\nกรุณาเข้าสู่ระบบอีกครั้งเพื่อดำเนินการต่อ';

  @override
  String get loginSuccessPrompt =>
      'เข้าสู่ระบบสำเร็จ\nแตะ \"บันทึก\" เพื่อเสร็จสิ้น';

  @override
  String get loginPromptOnLoginPage =>
      'เข้าสู่ระบบ Instagram จากนั้นแตะ \"บันทึก\" เพื่อเสร็จสิ้น';

  @override
  String get loginPromptSaveBottom =>
      'หากคุณเข้าสู่ระบบเสร็จแล้ว ให้แตะ \"บันทึก\" ด้านล่าง';

  @override
  String get loginPageTitle => 'เข้าสู่ระบบ Instagram';

  @override
  String get loginOpeningInstagramWithHint =>
      'กำลังเปิด Instagram...\nหลังจากเข้าสู่ระบบแล้ว ให้แตะ \"บันทึก\"';

  @override
  String get loginOpenFailed =>
      'ไม่สามารถเปิด Instagram\nโปรดตรวจสอบการเชื่อมต่ออินเทอร์เน็ตของคุณแล้วลองอีกครั้ง';

  @override
  String get profileSavedMissingUsername =>
      'โปรไฟล์ที่บันทึกไว้ไม่มีชื่อผู้ใช้';

  @override
  String get openingProfile => 'กำลังเปิดโปรไฟล์...';

  @override
  String openingUsername(String username) {
    return 'กำลังเปิด @$username...';
  }

  @override
  String foundStoryHighlightsAndPosts(int storyCount, int postCount) {
    return 'พบ $storyCount Story/Highlight รายการและ $postCount โพสต์';
  }

  @override
  String get privateModeEnabled => 'เปิดใช้งานโหมดแล้ว';

  @override
  String get publicModeEnabled => 'เปลี่ยนกลับเป็นโหมด Public';

  @override
  String get cannotConfirmInstagramLogin =>
      'ไม่สามารถยืนยัน Instagram เข้าสู่ระบบได้ กรุณาเข้าสู่ระบบอีกครั้ง';

  @override
  String get instagramConnected => 'Instagram เชื่อมต่อบัญชีแล้ว';

  @override
  String get loggingOutInstagram => 'กำลังออกจากระบบ Instagram...';

  @override
  String get instagramLoggedOut => 'คุณได้ออกจากระบบ Instagram';

  @override
  String get instagramLogoutCleanupFailed =>
      'ออกจากระบบ Instagram แต่มีข้อผิดพลาดในการล้างข้อมูลเข้าสู่ระบบ';

  @override
  String get emptyInstagramLink => 'โปรดป้อนลิงก์ Instagram';

  @override
  String get preparingContent => 'กำลังเตรียมเนื้อหา...';

  @override
  String get loadingContentWithAccount =>
      'กำลังโหลดเนื้อหาด้วยบัญชีที่เชื่อมต่อ...';

  @override
  String get cannotFetchContent => 'ไม่สามารถดึงเนื้อหาได้';

  @override
  String get noDownloadableContentFound => 'ไม่พบเนื้อหาที่ดาวน์โหลดได้';

  @override
  String foundDownloadableContent(int count) {
    return 'พบ $count รายการที่ดาวน์โหลดได้';
  }

  @override
  String get fetchContentFailedPublic =>
      'ไม่สามารถดึงเนื้อหาได้ โปรดตรวจสอบลิงก์หรือลองอีกครั้ง';

  @override
  String get fetchContentFailedPrivate =>
      'ไม่สามารถดึงเนื้อหาได้ โปรดตรวจสอบสิทธิ์ในการดูหรือเข้าสู่ระบบอีกครั้ง';

  @override
  String get emptyProfileInput => 'โปรดป้อนโปรไฟล์ Instagram';

  @override
  String get loadingStoryHighlights => 'กำลังโหลด Stories และ Highlights...';

  @override
  String get noCurrentStoryOrHighlight => 'ไม่พบเรื่องราวหรือไฮไลท์ในปัจจุบัน';

  @override
  String foundStoryHighlights(int count) {
    return 'พบ $count Story/Highlight รายการ';
  }

  @override
  String get cannotOpenContent => 'ไม่สามารถเปิดเนื้อหานี้ได้';

  @override
  String openingStoryGroup(String title) {
    return 'กำลังเปิด \"$title\"...';
  }

  @override
  String foundStoryGroupItems(int count, String title) {
    return 'พบ $count รายการใน \"$title\"';
  }

  @override
  String get cannotOpenStoryHighlightLogin =>
      'ไม่สามารถเปิด Story หรือ Highlight กรุณาเข้าสู่ระบบและลองอีกครั้ง';

  @override
  String get cannotOpenStoryHighlightPermission =>
      'ไม่สามารถเปิด Story หรือ Highlight โปรดตรวจสอบสิทธิ์ในการรับชม';

  @override
  String get cannotDownloadContent => 'ไม่สามารถดาวน์โหลดเนื้อหานี้ได้';

  @override
  String get downloadingStory => 'กำลังดาวน์โหลดเรื่องราว...';

  @override
  String savedStoryToAlbum(String albumName) {
    return 'บันทึกรายการเรื่องราวลงในอัลบั้ม $albumName';
  }

  @override
  String get downloadStoryFailed => 'การดาวน์โหลดล้มเหลว โปรดลองอีกครั้ง';

  @override
  String get loadingReelsPublic => 'กำลังดึงวงล้อ...';

  @override
  String get loadingReelsPrivate => 'กำลังโหลดม้วน...';

  @override
  String get noReelsOrPermission => 'ไม่พบ หรือคุณไม่ได้รับอนุญาตให้ดู';

  @override
  String foundReels(int count) {
    return 'พบ $count Reels.';
  }

  @override
  String get cannotLoadReelsPublic =>
      'ไม่สามารถโหลดได้ โปรดตรวจสอบโปรไฟล์หรือลองอีกครั้ง';

  @override
  String get cannotLoadReelsPrivate =>
      'ไม่สามารถโหลดได้ โปรดตรวจสอบสิทธิ์ในการรับชม';

  @override
  String get loadingPostsPublic => 'กำลังเรียกรูปภาพ/โพสต์...';

  @override
  String get loadingPostsPrivate => 'กำลังโหลดรูปภาพ/โพสต์...';

  @override
  String get noPostsOrPermission =>
      'ไม่พบรูปภาพ/โพสต์ หรือคุณไม่ได้รับอนุญาตให้ดู';

  @override
  String foundPosts(int count) {
    return 'พบ $count รูปภาพ/โพสต์';
  }

  @override
  String get cannotLoadPostsPublic =>
      'โหลดกระทู้ไม่ได้ โปรดตรวจสอบโปรไฟล์หรือลองอีกครั้ง';

  @override
  String get cannotLoadPostsPrivate =>
      'โหลดกระทู้ไม่ได้ โปรดตรวจสอบสิทธิ์ในการรับชม';

  @override
  String get cannotLoadMoreContent => 'ไม่สามารถโหลดเนื้อหาเพิ่มเติมได้';

  @override
  String get cannotLoadMoreProfile =>
      'ไม่สามารถโหลดเพิ่มเติมได้ กรุณากรอกรายละเอียดอีกครั้ง';

  @override
  String get noMoreNewContent => 'ไม่มีเนื้อหาใหม่อีกต่อไป';

  @override
  String loadedMoreContent(int count) {
    return 'โหลด $count รายการเพิ่มเติมแล้ว';
  }

  @override
  String get loadMoreFailed => 'โหลดเพิ่มเติมล้มเหลว โปรดลองอีกครั้ง';

  @override
  String get openingReel => 'กำลังเปิด Reel...';

  @override
  String get openingPost => 'กำลังเปิดโพสต์...';

  @override
  String get cannotOpenContentPermission =>
      'ไม่สามารถเปิดเนื้อหานี้ได้ โปรดตรวจสอบสิทธิ์ในการดูหรือลองอีกครั้ง';

  @override
  String get downloadingContent => 'กำลังดาวน์โหลดเนื้อหา...';

  @override
  String savedToAlbum(String albumName) {
    return 'บันทึกไว้ในอัลบั้ม $albumName';
  }

  @override
  String savedContentToAlbum(String albumName) {
    return 'เนื้อหาที่บันทึกไว้ในอัลบั้ม $albumName';
  }

  @override
  String get downloadContentErrorRetry =>
      'การดาวน์โหลดเนื้อหาล้มเหลว แตะเพื่อลองอีกครั้ง';

  @override
  String get downloadHistoryCleared => 'ล้างประวัติการดาวน์โหลดแล้ว';

  @override
  String downloadHistoryItemsRemoved(int count) {
    return 'ลบ $count รายการออกจากประวัติ';
  }

  @override
  String get downloadConnectionSlow =>
      'การดาวน์โหลดล้มเหลวเนื่องจากการเชื่อมต่อช้า แตะเพื่อลองอีกครั้ง';

  @override
  String get downloadNetworkUnavailable =>
      'ไม่สามารถเชื่อมต่อกับเครือข่าย/CDN ตรวจสอบเครือข่ายของคุณแล้วลองอีกครั้ง';

  @override
  String get downloadCancelled => 'การดาวน์โหลดถูกยกเลิก';

  @override
  String get downloadGenericError => 'การดาวน์โหลดล้มเหลว แตะเพื่อลองอีกครั้ง';

  @override
  String downloadProgress(String percent) {
    return 'กำลังดาวน์โหลดเนื้อหา: $percent%';
  }

  @override
  String get legalLinksTitle => 'นโยบายความเป็นส่วนตัวและข้อกำหนด';

  @override
  String get termsOfUse => 'ข้อกำหนดการใช้งาน';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';
}
