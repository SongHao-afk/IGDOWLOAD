import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../l10n/app_localizations.dart';

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

  static const String _guardScript = r'''
(() => {
  if (window.__manualIgGuardInstalled) return;
  window.__manualIgGuardInstalled = true;

  let lastHref = '';

  function isPickableUrl(value) {
    const href = String(value || '');

    return href.includes('instagram.com/stories/highlights/') ||
           href.includes('/stories/highlights/') ||
           href.includes('instagram.com/stories/') ||
           href.includes('/stories/') ||
           href.includes('instagram.com/p/') ||
           href.includes('/p/') ||
           href.includes('instagram.com/reel/') ||
           href.includes('/reel/') ||
           href.includes('instagram.com/reels/') ||
           href.includes('/reels/') ||
           href.includes('instagram.com/tv/') ||
           href.includes('/tv/');
  }

  function callFlutter(handler, url, kind) {
    try {
      if (!window.flutter_inappwebview || !url) return;
      window.flutter_inappwebview.callHandler(handler, url, kind || '');
    } catch (e) {}
  }

  function sendCurrentUrl() {
    try {
      const href = window.location.href || '';
      if (!href || href === lastHref) return;
      lastHref = href;

      if (isPickableUrl(href)) {
        callFlutter('manualIgUrlChanged', href, 'url');
      }
    } catch (e) {}
  }

  function markInlineVideos() {
    try {
      document.querySelectorAll('video').forEach((video) => {
        video.setAttribute('playsinline', '');
        video.setAttribute('webkit-playsinline', '');
        video.playsInline = true;
      });
    } catch (e) {}
  }

  function blockFullscreenApi() {
    try {
      const keys = [
        'requestFullscreen',
        'webkitRequestFullscreen',
        'webkitEnterFullscreen',
        'mozRequestFullScreen',
        'msRequestFullscreen',
      ];

      const protos = [Element.prototype];

      try {
        if (window.HTMLVideoElement && HTMLVideoElement.prototype) {
          protos.push(HTMLVideoElement.prototype);
        }
      } catch (e) {}

      protos.forEach((proto) => {
        keys.forEach((key) => {
          try {
            if (!proto[key] || proto['__manualIgRaw_' + key]) return;
            proto['__manualIgRaw_' + key] = proto[key];

            proto[key] = function() {
              sendCurrentUrl();
              markInlineVideos();
              return Promise.resolve();
            };
          } catch (e) {}
        });
      });
    } catch (e) {}
  }

  function exitFullscreenIfNeeded() {
    try {
      if (document.fullscreenElement && document.exitFullscreen) {
        document.exitFullscreen();
      }

      if (document.webkitFullscreenElement && document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
      }
    } catch (e) {}
  }

  function injectStyle() {
    try {
      if (document.getElementById('__manual_ig_inline_style')) return;

      const style = document.createElement('style');
      style.id = '__manual_ig_inline_style';

      style.textContent = `
        video {
          object-fit: contain !important;
        }

        video::-webkit-media-controls-fullscreen-button {
          display: none !important;
        }
      `;

      document.documentElement.appendChild(style);
    } catch (e) {}
  }

  function tick() {
    blockFullscreenApi();
    exitFullscreenIfNeeded();
    injectStyle();
    markInlineVideos();
    sendCurrentUrl();
  }

  const rawPushState = history.pushState;
  const rawReplaceState = history.replaceState;

  history.pushState = function() {
    const result = rawPushState.apply(this, arguments);
    setTimeout(tick, 30);
    return result;
  };

  history.replaceState = function() {
    const result = rawReplaceState.apply(this, arguments);
    setTimeout(tick, 30);
    return result;
  };

  window.addEventListener('popstate', () => setTimeout(tick, 30), true);
  window.addEventListener('hashchange', () => setTimeout(tick, 30), true);

  document.addEventListener('fullscreenchange', tick, true);
  document.addEventListener('webkitfullscreenchange', tick, true);

  setInterval(tick, 350);
  setTimeout(tick, 50);
})();
''';

  InAppWebViewController? controller;

  bool preparing = true;
  bool loading = false;
  bool finishing = false;

  String currentUrl = '';
  String lastPickableUrl = '';
  String statusKey = 'manualOpeningInstagram';

  @override
  void initState() {
    super.initState();
    _prepareBrowser();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  String _statusText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (statusKey) {
      case 'manualInstruction':
        return l10n.manualInstruction;
      case 'manualPickedContent':
        return l10n.manualPickedContent;
      case 'manualNoDownloadableContent':
        return l10n.manualNoDownloadableContent;
      case 'manualCloseToExit':
        return l10n.manualCloseToExit;
      case 'manualOpeningInstagram':
      default:
        return l10n.manualOpeningInstagram;
    }
  }

  Future<void> _prepareBrowser() async {
    // Quan trọng cho iOS:
    // Không clear cookie/storage ở đây, để WKWebView giữ session Instagram.
    await _applyPrivateCookie(widget.privateIgCookie);

    if (!mounted) return;

    setState(() {
      preparing = false;
      statusKey = 'manualInstruction';
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
      } catch (_) {}
    }
  }

  WebUri _initialUri() {
    final raw = widget.startUrl?.trim();

    if (raw == null || raw.isEmpty) {
      return instagramHomeUri;
    }

    final parsed = WebUri(raw);

    if (parsed.scheme.isEmpty) {
      return instagramHomeUri;
    }

    return parsed;
  }

  bool _isInstagramHost(Uri uri) {
    final host = uri.host.toLowerCase();
    return host == 'instagram.com' || host.endsWith('.instagram.com');
  }

  bool _isPickableInstagramUrl(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return false;

    final uri = Uri.tryParse(clean);
    if (uri == null || !_isInstagramHost(uri)) return false;

    final path = uri.path.toLowerCase();

    return path.contains('/stories/highlights/') ||
        path.contains('/stories/') ||
        path.contains('/p/') ||
        path.contains('/reel/') ||
        path.contains('/reels/') ||
        path.contains('/tv/');
  }

  void _rememberUrl(String? value) {
    final clean = value?.trim() ?? '';
    if (clean.isEmpty) return;

    final pickable = _isPickableInstagramUrl(clean);

    if (!mounted) {
      currentUrl = clean;
      if (pickable) lastPickableUrl = clean;
      return;
    }

    if (currentUrl == clean && (!pickable || lastPickableUrl == clean)) {
      return;
    }

    setState(() {
      currentUrl = clean;

      if (pickable) {
        lastPickableUrl = clean;
        statusKey = 'manualPickedContent';
      }
    });
  }

  Future<void> _finishWithUrl(String value) async {
    final clean = value.trim();

    if (finishing) return;
    if (!_isPickableInstagramUrl(clean)) return;

    finishing = true;

    if (!mounted) return;

    Navigator.of(context).pop(clean);
  }

  Future<void> _installGuardScript(InAppWebViewController webController) async {
    await webController
        .evaluateJavascript(source: _guardScript)
        .catchError((_) {});
  }

  Future<void> _forceExitFullscreen() async {
    final webController = controller;
    if (webController == null) return;

    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    await webController
        .evaluateJavascript(
          source: r'''
(() => {
  try {
    if (document.fullscreenElement && document.exitFullscreen) {
      document.exitFullscreen();
    }

    if (document.webkitFullscreenElement && document.webkitExitFullscreen) {
      document.webkitExitFullscreen();
    }

    document.querySelectorAll('video').forEach((video) => {
      video.setAttribute('playsinline', '');
      video.setAttribute('webkit-playsinline', '');
      video.playsInline = true;
    });
  } catch (e) {}
})();
''',
        )
        .catchError((_) {});
  }

  Future<String> _getCurrentUrlSafe() async {
    final webController = controller;

    if (webController == null) {
      return currentUrl.trim();
    }

    try {
      final jsValue = await webController.evaluateJavascript(
        source: 'window.location.href',
      );

      final jsUrl = jsValue?.toString().trim() ?? '';
      if (jsUrl.startsWith('http')) return jsUrl;
    } catch (_) {}

    try {
      final url = await webController.getUrl();
      final value = url?.toString().trim() ?? '';
      if (value.isNotEmpty) return value;
    } catch (_) {}

    return currentUrl.trim();
  }

  Future<void> _pickCurrentUrl() async {
    final freshUrl = await _getCurrentUrlSafe();
    _rememberUrl(freshUrl);

    final usableFresh = _isPickableInstagramUrl(freshUrl);
    final usableLast = _isPickableInstagramUrl(lastPickableUrl);

    final value = usableFresh
        ? freshUrl.trim()
        : usableLast
        ? lastPickableUrl.trim()
        : freshUrl.trim();

    if (value.isEmpty || !_isPickableInstagramUrl(value)) {
      if (!mounted) return;

      setState(() {
        statusKey = 'manualNoDownloadableContent';
      });

      return;
    }

    await _finishWithUrl(value);
  }

  Future<bool> _handleBack() async {
    final webController = controller;

    if (webController != null) {
      final canGoBack = await webController.canGoBack().catchError(
        (_) => false,
      );

      if (canGoBack) {
        await webController.goBack().catchError((_) {});
        return false;
      }
    }

    if (!mounted) return false;

    setState(() {
      statusKey = 'manualCloseToExit';
    });

    return false;
  }

  Future<void> _goInstagramHome() async {
    await controller?.loadUrl(urlRequest: URLRequest(url: instagramHomeUri));
  }

  Future<void> _reload() async {
    await controller?.reload();
  }

  Widget _buildInfoBar(ColorScheme color) {
    return Material(
      color: color.surface,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _statusText(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              lastPickableUrl.isNotEmpty ? lastPickableUrl : currentUrl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: color.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebViewFrame(ColorScheme color) {
    if (preparing) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: _initialUri()),
          initialUserScripts: UnmodifiableListView<UserScript>([
            UserScript(
              source: _guardScript,
              injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            ),
          ]),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            thirdPartyCookiesEnabled: true,
            sharedCookiesEnabled: true,
            domStorageEnabled: true,
            incognito: false,
            cacheEnabled: true,
            clearCache: false,
            databaseEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
            supportMultipleWindows: false,
            javaScriptCanOpenWindowsAutomatically: false,
            useShouldOverrideUrlLoading: true,
            verticalScrollBarEnabled: true,
            horizontalScrollBarEnabled: false,
            transparentBackground: false,
          ),
          onWebViewCreated: (webController) {
            controller = webController;

            webController.addJavaScriptHandler(
              handlerName: 'manualIgUrlChanged',
              callback: (args) {
                if (args.isEmpty) return null;

                final value = args.first?.toString();
                _rememberUrl(value);

                return null;
              },
            );
          },
          shouldOverrideUrlLoading: (webController, navigationAction) async {
            final value = navigationAction.request.url?.toString() ?? '';

            _rememberUrl(value);

            return NavigationActionPolicy.ALLOW;
          },
          onCreateWindow: (webController, createWindowAction) async {
            final value = createWindowAction.request.url?.toString() ?? '';

            if (value.startsWith('http')) {
              _rememberUrl(value);

              await webController.loadUrl(
                urlRequest: URLRequest(url: WebUri(value)),
              );
            }

            return false;
          },
          onEnterFullscreen: (webController) async {
            controller = webController;

            final value = await _getCurrentUrlSafe();
            _rememberUrl(value);

            await _forceExitFullscreen();
          },
          onExitFullscreen: (webController) async {
            controller = webController;

            await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
          },
          onLoadStart: (webController, url) {
            controller = webController;

            final value = url?.toString() ?? '';
            _rememberUrl(value);

            if (!mounted) return;

            setState(() {
              loading = true;
            });
          },
          onLoadStop: (webController, url) async {
            controller = webController;

            await _installGuardScript(webController);
            await _forceExitFullscreen();

            final actualUrl = await webController.getUrl();
            final value = actualUrl?.toString() ?? url?.toString() ?? '';

            _rememberUrl(value);

            if (!mounted) return;

            setState(() {
              loading = false;
            });
          },
          onUpdateVisitedHistory: (webController, url, androidIsReload) async {
            controller = webController;

            await _installGuardScript(webController);

            final value = url?.toString() ?? '';
            _rememberUrl(value);
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
    );
  }

  Widget _buildBottomActions() {
    return SafeArea(
      top: false,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: preparing ? null : _pickCurrentUrl,
                  icon: const Icon(Icons.link_rounded),
                  label: Text(AppLocalizations.of(context)!.selectThisContent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: _handleBack,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Instagram',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(null),
            icon: const Icon(Icons.close_rounded),
            tooltip: AppLocalizations.of(context)!.close,
          ),
          actions: [
            IconButton(
              onPressed: preparing ? null : _goInstagramHome,
              icon: const Icon(Icons.home_rounded),
              tooltip: AppLocalizations.of(context)!.instagramHome,
            ),
            IconButton(
              onPressed: preparing ? null : _reload,
              icon: const Icon(Icons.refresh_rounded),
              tooltip: AppLocalizations.of(context)!.downloadAgain,
            ),
          ],
        ),
        body: Column(
          children: [
            _buildInfoBar(color),
            Expanded(child: _buildWebViewFrame(color)),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }
}

//
