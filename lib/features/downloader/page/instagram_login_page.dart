import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

  InAppWebViewController? controller;
  bool saving = false;
  String status = 'Đăng nhập Instagram, xong bấm "Lưu đăng nhập".';

  Future<void> saveLoginCookie() async {
    if (saving) return;

    setState(() {
      saving = true;
      status = 'Đang lấy phiên đăng nhập...';
    });

    try {
      final cookies = await CookieManager.instance().getCookies(
        url: instagramUri,
      );

      final wanted = <String>{
        'sessionid',
        'ds_user_id',
        'csrftoken',
        'mid',
        'ig_did',
        'rur',
      };

      final cookieString = cookies
          .where((cookie) {
            final value = cookie.value.toString();
            return wanted.contains(cookie.name) && value.trim().isNotEmpty;
          })
          .map((cookie) => '${cookie.name}=${cookie.value}')
          .join('; ');

      final hasSessionId = cookies.any((cookie) {
        final value = cookie.value.toString();
        return cookie.name == 'sessionid' && value.trim().isNotEmpty;
      });

      if (!hasSessionId || cookieString.trim().isEmpty) {
        setState(() {
          saving = false;
          status = 'Chưa thấy sessionid. Hãy login Instagram xong rồi lưu lại.';
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
    await CookieManager.instance().deleteAllCookies();

    if (!mounted) return;

    setState(() {
      status = 'Đã xóa cookie WebView. Hãy đăng nhập lại.';
    });

    await controller?.loadUrl(urlRequest: URLRequest(url: loginUri));
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
            onPressed: saving ? null : clearCookies,
            icon: const Icon(Icons.cleaning_services_rounded),
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
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: loginUri),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                thirdPartyCookiesEnabled: true,
                sharedCookiesEnabled: true,
                domStorageEnabled: true,
                databaseEnabled: true,
                cacheEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
              ),
              onWebViewCreated: (webController) {
                controller = webController;
              },
              onLoadStop: (webController, url) async {
                final host = url?.host ?? '';

                if (host.contains('instagram.com')) {
                  setState(() {
                    status =
                        'Nếu đã vào được Instagram, bấm "Lưu đăng nhập" bên dưới.';
                  });
                }
              },
            ),
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
                      onPressed: saving ? null : saveLoginCookie,
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
