import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InstagramWebViewCleaner {
  InstagramWebViewCleaner._();

  static final WebUri instagramUri = WebUri('https://www.instagram.com/');
  static final WebUri instagramLoginUri = WebUri(
    'https://www.instagram.com/accounts/login/',
  );

  /// Xoá sạch dữ liệu login Instagram trong WebView.
  ///
  /// Cái này dùng cho nút logout:
  /// - xoá toàn bộ cookie WebView
  /// - xoá localStorage / IndexedDB / WebSQL / WebStorage
  /// - nếu truyền controller thì xoá thêm cache WebView hiện tại
  static Future<void> clearAll({InAppWebViewController? controller}) async {
    final cookieManager = CookieManager.instance();

    // 1. Xoá cookie Instagram riêng trước.
    try {
      await cookieManager.deleteCookies(url: instagramUri);
      await cookieManager.deleteCookies(url: instagramLoginUri);
      debugPrint('✅ Deleted Instagram cookies');
    } catch (e) {
      debugPrint('⚠️ Delete Instagram cookies failed: $e');
    }

    // 2. Xoá toàn bộ cookie WebView luôn cho sạch.
    try {
      await cookieManager.deleteAllCookies();
      debugPrint('✅ Deleted all WebView cookies');
    } catch (e) {
      debugPrint('⚠️ Delete all WebView cookies failed: $e');
    }

    // 3. Xoá WebView storage: localStorage, IndexedDB, WebSQL...
    try {
      await WebStorageManager.instance().deleteAllData();
      debugPrint('✅ Deleted all WebView storage');
    } catch (e) {
      debugPrint('⚠️ Delete WebView storage failed: $e');
    }

    // 4. Xoá cache của WebView hiện tại nếu đang có controller.
    try {
      await controller?.clearCache();
      debugPrint('✅ Cleared WebView cache');
    } catch (e) {
      debugPrint('⚠️ Clear WebView cache failed: $e');
    }
  }
}
