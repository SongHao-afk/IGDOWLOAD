import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/instagram_webview_cleaner.dart';

class InstagramLoginPage extends StatefulWidget {
  const InstagramLoginPage({super.key, this.onLogout});

  final Future<void> Function()? onLogout;

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

  String status = 'Đang mở Instagram...';

  @override
  void initState() {
    super.initState();

    // Không tự clear cookie khi mở login nữa.
    // Muốn xoá thì bấm nút cây chổi trên AppBar.
    webViewReady = true;
    status = 'Đăng nhập Instagram rồi bấm "Lưu đăng nhập".';
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
              'Chưa lấy được phiên đăng nhập.\n'
              'Hãy đăng nhập Instagram xong rồi bấm lưu lại.';
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
      saving = true;
      status = 'Đang xoá sạch phiên đăng nhập...';
    });

    try {
      if (widget.onLogout != null) {
        await widget.onLogout!.call();
      } else {
        await InstagramWebViewCleaner.clearAll(controller: controller);
      }
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }

    if (!mounted) return;

    setState(() {
      status =
          'Đã xoá sạch phiên đăng nhập trên web và trong app.\n'
          'Hãy đăng nhập lại.';
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
        status = 'Đã nhận được phiên đăng nhập.\nBấm "Lưu đăng nhập" để lưu.';
      } else if (path.contains('/accounts/login')) {
        status = 'Đăng nhập Instagram rồi bấm "Lưu đăng nhập".';
      } else {
        status = 'Nếu đã đăng nhập xong, bấm "Lưu đăng nhập" bên dưới.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        titleSpacing: 0,
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
          'Đăng nhập Instagram',
            maxLines: 1,
            style: TextStyle(
              color: Color(0xFF24142E),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: saving || !webViewReady ? null : clearCookies,
            icon: const Icon(Icons.logout_rounded),
            color: color.primary,
            tooltip: 'Đăng xuất Instagram',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.primary.withOpacity(0.10),
              color.tertiary.withOpacity(0.08),
              color.secondary.withOpacity(0.08),
              Theme.of(context).scaffoldBackgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [
                  color.primary.withOpacity(0.18),
                  color.tertiary.withOpacity(0.16),
                  color.secondary.withOpacity(0.14),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              border: Border.all(
                color: color.primary.withOpacity(0.14),
              ),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xFF24142E),
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
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
                            'Đăng nhập xong thì bấm "Lưu đăng nhập".';
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
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.88),
                boxShadow: [
                  BoxShadow(
                    color: color.primary.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color.primary,
                        side: BorderSide(
                          color: color.primary.withOpacity(0.34),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      onPressed: saving
                          ? null
                          : () => Navigator.of(context).pop(null),
                      child: const Text('Hủy'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        gradient: LinearGradient(
                          colors: [
                            color.primary,
                            color.tertiary,
                            color.secondary,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
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
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
