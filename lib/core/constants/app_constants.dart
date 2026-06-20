class AppConstants {
  static const String appName = 'IG Downloader';

  // Emulator Android: http://10.0.2.2:8000
  // Máy thật: http://IP_MAY_TINH:8000
  //
  // Backend mới mount API dưới /instagram.
  // Code repository sẽ tự nối /instagram nếu serverBaseUrl chưa có.
  static const String defaultServerBaseUrl = 'http://10.0.2.2:8000';

  static const String prefsServerBaseUrl = 'serverBaseUrl';
  static const String prefsThemeMode = 'themeMode';
  static const String prefsPrivateMode = 'privateMode';
  static const String prefsPrivateIgCookie = 'privateIgCookie';

  static const String albumName = 'IG Downloader';
}