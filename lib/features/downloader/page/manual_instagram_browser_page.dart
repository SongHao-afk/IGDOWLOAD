import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/instagram_webview_cleaner.dart';

class ManualInstagramBrowserPage extends StatefulWidget {
  final String? startUrl;
  final String privateIgCookie;

  const ManualInstagramBrowserPage({
    super.key,
    this.startUrl,
    required this.privateIgCookie,
  });

  @override
  State<ManualInstagramBrowserPage> createState() =>
      _ManualInstagramBrowserPageState();
}

class _ManualInstagramBrowserPageState
    extends State<ManualInstagramBrowserPage> {
  static final WebUri instagramHomeUri = WebUri('https://www.instagram.com/');

  InAppWebViewController? controller;

  bool preparing = true;
  bool loading = false;

  String currentUrl = '';
  String status = 'Đang mở trình duyệt Instagram sạch...';

  @override
  void initState() {
    super.initState();
    _prepareBrowser();
  }

  Future<void> _prepareBrowser() async {
    // Tạo cảm giác "browser mới":
    // xoá sạch WebView cũ rồi nhét lại cookie private đang lưu.
    await InstagramWebViewCleaner.clearAll();

    await _applyPrivateCookie(widget.privateIgCookie);

    if (!mounted) return;

    setState(() {
      preparing = false;
      status =
          'Mở Instagram, vào bài/story/reel cần tải rồi bấm "Lấy URL này".';
    });
  }

  Future<void> _applyPrivateCookie(String cookieString) async {
    final clean = cookieString.trim();
    if (clean.isEmpty) return;

    final cookieManager = CookieManager.instance();

    final parts = clean
        .split(';')
        .map((e) => e.trim())
        .where((e) => e.contains('='))
        .toList();

    for (final part in parts) {
      final index = part.indexOf('=');
      if (index <= 0) continue;

      final name = part.substring(0, index).trim();
      final value = part.substring(index + 1).trim();

      if (name.isEmpty || value.isEmpty) continue;

      try {
        await cookieManager.setCookie(
          url: instagramHomeUri,
          name: name,
          value: value,
          domain: '.instagram.com',
          path: '/',
          isSecure: true,
          isHttpOnly: false,
        );
      } catch (_) {
        // Kệ. Cookie nào set lỗi thì bỏ qua, đừng cho app chết vì một cái cookie dở hơi.
      }
    }
  }

  WebUri _initialUri() {
    final raw = widget.startUrl?.trim();

    if (raw == null || raw.isEmpty) {
      return instagramHomeUri;
    }

    final parsed = WebUri(raw);

    if (parsed.scheme.isEmpty) {
      return WebUri('https://www.instagram.com/');
    }

    return parsed;
  }

  Future<void> _pickCurrentUrl() async {
    final url = await controller?.getUrl();
    final value = url?.toString().trim() ?? currentUrl.trim();

    if (value.isEmpty) {
      if (!mounted) return;
      setState(() {
        status = 'Chưa lấy được URL hiện tại.';
      });
      return;
    }

    if (!mounted) return;
    Navigator.of(context).pop(value);
  }

  Future<void> _goInstagramHome() async {
    await controller?.loadUrl(urlRequest: URLRequest(url: instagramHomeUri));
  }

  Future<void> _reload() async {
    await controller?.reload();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Duyệt Instagram',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: preparing ? null : _goInstagramHome,
            icon: const Icon(Icons.home_rounded),
            tooltip: 'Instagram home',
          ),
          IconButton(
            onPressed: preparing ? null : _reload,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Tải lại',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            color: color.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                if (currentUrl.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    currentUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: preparing
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: [
                      InAppWebView(
                        initialUrlRequest: URLRequest(url: _initialUri()),
                        initialSettings: InAppWebViewSettings(
                          javaScriptEnabled: true,
                          thirdPartyCookiesEnabled: true,
                          sharedCookiesEnabled: true,
                          domStorageEnabled: true,

                          // Manual browser đã clear trước khi mở,
                          // nên không cần incognito vội.
                          // Bật incognito đôi khi làm cookie khó dùng hơn.
                          incognito: false,

                          cacheEnabled: false,
                          clearCache: true,
                          databaseEnabled: false,
                          mediaPlaybackRequiresUserGesture: false,
                        ),
                        onWebViewCreated: (webController) {
                          controller = webController;
                        },
                        onLoadStart: (webController, url) {
                          setState(() {
                            loading = true;
                            currentUrl = url?.toString() ?? currentUrl;
                          });
                        },
                        onLoadStop: (webController, url) async {
                          final actualUrl = await webController.getUrl();

                          if (!mounted) return;

                          setState(() {
                            loading = false;
                            currentUrl =
                                actualUrl?.toString() ?? url?.toString() ?? '';
                            status =
                                'Mở đúng nội dung cần tải rồi bấm "Lấy URL này".';
                          });
                        },
                        onUpdateVisitedHistory:
                            (webController, url, androidIsReload) {
                              if (!mounted) return;

                              setState(() {
                                currentUrl = url?.toString() ?? currentUrl;
                              });
                            },
                      ),
                      if (loading)
                        const Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(minHeight: 2),
                        ),
                    ],
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
                      onPressed: () => Navigator.of(context).pop(null),
                      child: const Text('Hủy'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FilledButton.icon(
                      onPressed: preparing ? null : _pickCurrentUrl,
                      icon: const Icon(Icons.link_rounded),
                      label: const Text('Lấy URL này'),
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
