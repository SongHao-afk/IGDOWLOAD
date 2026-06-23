import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/instagram_webview_cleaner.dart';

class InstagramLoginPage extends StatefulWidget {
  const InstagramLoginPage({super.key});

  @override
  State<InstagramLoginPage> createState() => _InstagramLoginPageState();
}

class _InstagramLoginPageState extends State<InstagramLoginPage> {
  static final WebUri loginUri = WebUri(
    'https://www.instagram.com/accounts/login/',
  );

  static final WebUri instagramUri = WebUri('https://www.instagram.com/');
  static final WebUri instagramHomeUri = WebUri('https://www.instagram.com/');
  static final WebUri instagramLoginUri = WebUri(
    'https://www.instagram.com/accounts/login/',
  );

  static const String _userAgent =
      'Mozilla/5.0 (Linux; Android 13; Mobile) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/124.0.0.0 Mobile Safari/537.36';

  InAppWebViewController? controller;

  bool saving = false;
  bool webViewReady = false;

  String status = 'Đang chuẩn bị WebView Instagram...';

  @override
  void initState() {
    super.initState();

    // Không tự clear cookie khi mở login nữa.
    // Muốn xoá thì bấm nút cây chổi trên AppBar.
    webViewReady = true;
    status = 'Đăng nhập Instagram, xong bấm "Lưu đăng nhập".';
  }

  Future<List<Cookie>> _getInstagramCookies() async {
    final cookieManager = CookieManager.instance();
    final result = <String, Cookie>{};

    Future<void> collect(WebUri url) async {
      try {
        final cookies = await cookieManager.getCookies(url: url);

        for (final cookie in cookies) {
          final name = cookie.name.trim();
          final value = cookie.value.toString().trim();

          if (name.isEmpty || value.isEmpty || value == 'null') {
            continue;
          }

          result[name] = cookie;
        }
      } catch (_) {
        // Kệ, thử URL khác.
      }
    }

    await collect(instagramUri);
    await collect(instagramHomeUri);
    await collect(instagramLoginUri);

    return result.values.toList();
  }

  Future<void> saveLoginCookie() async {
    if (saving) return;

    setState(() {
      saving = true;
      status = 'Đang lấy phiên đăng nhập...';
    });

    try {
      // Cho WebView/CookieManager có nhịp sync cookie.
      await Future<void>.delayed(const Duration(milliseconds: 350));

      final cookies = await _getInstagramCookies();

      final wanted = <String>{
        'sessionid',
        'ds_user_id',
        'csrftoken',
        'mid',
        'ig_did',
        'rur',
      };

      final hasSessionId = cookies.any((cookie) {
        final value = cookie.value.toString().trim();

        return cookie.name == 'sessionid' &&
            value.isNotEmpty &&
            value != 'null';
      });

      final cookieString = cookies
          .where((cookie) {
            final value = cookie.value.toString().trim();

            return wanted.contains(cookie.name) &&
                value.isNotEmpty &&
                value != 'null';
          })
          .map((cookie) => '${cookie.name}=${cookie.value}')
          .join('; ');

      if (!hasSessionId || cookieString.trim().isEmpty) {
        if (!mounted) return;

        setState(() {
          saving = false;
          status =
              'Chưa thấy sessionid.\n'
              'Hãy login Instagram xong, đợi vào home/profile rồi bấm lưu.';
        });

        return;
      }

      if (!mounted) return;

      Navigator.of(context).pop(cookieString);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        saving = false;
        status = 'Lấy phiên đăng nhập lỗi. Thử lại.';
      });
    }
  }

  Future<void> clearCookies() async {
    if (saving) return;

    setState(() {
      status = 'Đang xoá sạch cookie/cache WebView...';
    });

    await InstagramWebViewCleaner.clearAll(controller: controller);

    if (!mounted) return;

    setState(() {
      status = 'Đã xoá sạch cookie/cache WebView.\nHãy đăng nhập lại.';
    });

    await controller?.loadUrl(urlRequest: URLRequest(url: loginUri));
  }

  Future<void> _updateLoginStatus(WebUri? url) async {
    final host = url?.host ?? '';

    if (!host.contains('instagram.com')) {
      return;
    }

    final cookies = await _getInstagramCookies();

    final hasSessionId = cookies.any((cookie) {
      final value = cookie.value.toString().trim();

      return cookie.name == 'sessionid' && value.isNotEmpty && value != 'null';
    });

    if (!mounted) return;

    final path = url?.path ?? '';

    setState(() {
      if (hasSessionId) {
        status = 'Đã thấy sessionid.\nBấm "Lưu đăng nhập" để lưu phiên.';
      } else if (path.contains('/accounts/login')) {
        status = 'Đăng nhập Instagram, xong đợi vào home/profile rồi bấm lưu.';
      } else {
        status = 'Nếu đã vào được Instagram, bấm "Lưu đăng nhập" bên dưới.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập Instagram',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: saving || !webViewReady ? null : clearCookies,
            icon: const Icon(Icons.cleaning_services_rounded),
            tooltip: 'Xoá sạch WebView Instagram',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            color: color.surface,
            child: Text(
              status,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: webViewReady
                ? InAppWebView(
                    initialUrlRequest: URLRequest(url: loginUri),
                    initialSettings: InAppWebViewSettings(
                      javaScriptEnabled: true,
                      thirdPartyCookiesEnabled: true,
                      sharedCookiesEnabled: true,
                      domStorageEnabled: true,

                      // Quan trọng: không dùng incognito.
                      // Incognito làm CookieManager đọc sessionid rất hên xui.
                      incognito: false,

                      // Instagram login cần cache/storage/database hoạt động.
                      cacheEnabled: true,
                      clearCache: false,
                      databaseEnabled: true,

                      mediaPlaybackRequiresUserGesture: false,
                      supportMultipleWindows: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      useShouldOverrideUrlLoading: true,
                      userAgent: _userAgent,
                    ),
                    onWebViewCreated: (webController) {
                      controller = webController;
                    },
                    shouldOverrideUrlLoading:
                        (webController, navigationAction) async {
                          return NavigationActionPolicy.ALLOW;
                        },
                    onCreateWindow: (webController, createWindowAction) async {
                      final url = createWindowAction.request.url;

                      if (url != null) {
                        await webController.loadUrl(
                          urlRequest: URLRequest(url: url),
                        );
                      }

                      return false;
                    },
                    onLoadStart: (webController, url) {
                      final host = url?.host ?? '';

                      if (!host.contains('instagram.com')) {
                        return;
                      }

                      if (!mounted) return;

                      setState(() {
                        status =
                            'Đang mở Instagram...\n'
                            'Login xong đợi trang load vào home/profile rồi bấm lưu.';
                      });
                    },
                    onLoadStop: (webController, url) async {
                      await _updateLoginStatus(url);
                    },
                    onReceivedError: (webController, request, error) {
                      if (request.isForMainFrame == false) {
                        return;
                      }

                      if (!mounted) return;

                      setState(() {
                        status =
                            'WebView tải Instagram lỗi.\n'
                            'Kiểm tra mạng rồi thử lại.';
                      });
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: saving
                          ? null
                          : () => Navigator.of(context).pop(null),
                      child: const Text('Hủy'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: saving || !webViewReady
                          ? null
                          : saveLoginCookie,
                      icon: saving
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: color.onPrimary,
                              ),
                            )
                          : const Icon(Icons.save_rounded),
                      label: const Text('Lưu đăng nhập'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
