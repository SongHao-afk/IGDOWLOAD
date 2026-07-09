import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/instagram_webview_cleaner.dart';
import '../../../l10n/app_localizations.dart';
import 'privacy_links_page.dart';

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

  String statusKey = 'loginOpeningInstagram';

  @override
  void initState() {
    super.initState();

    // Không tự clear cookie khi mở login nữa.
    // Muốn xoá thì bấm nút cây chổi trên AppBar.
    webViewReady = true;
    statusKey = 'loginInstruction';
  }

  String _statusText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (statusKey) {
      case 'loginInstruction':
        return l10n.loginInstruction;
      case 'loginChecking':
        return l10n.loginChecking;
      case 'loginCannotConfirm':
        return l10n.loginCannotConfirm;
      case 'loginSaveError':
        return l10n.loginSaveError;
      case 'loginLoggingOut':
        return l10n.loginLoggingOut;
      case 'loginLoggedOut':
        return l10n.loginLoggedOut;
      case 'loginSuccessPrompt':
        return l10n.loginSuccessPrompt;
      case 'loginPromptOnLoginPage':
        return l10n.loginPromptOnLoginPage;
      case 'loginPromptSaveBottom':
        return l10n.loginPromptSaveBottom;
      case 'loginOpeningInstagramWithHint':
        return l10n.loginOpeningInstagramWithHint;
      case 'loginOpenFailed':
        return l10n.loginOpenFailed;
      case 'loginOpeningInstagram':
      default:
        return l10n.loginOpeningInstagram;
    }
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
      statusKey = 'loginChecking';
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
          statusKey = 'loginCannotConfirm';
        });

        return;
      }

      if (!mounted) return;

      Navigator.of(context).pop(cookieString);
    } catch (_) {
      if (!mounted) return;

      setState(() {
        saving = false;
        statusKey = 'loginSaveError';
      });
    }
  }

  Future<void> clearCookies() async {
    if (saving) return;

    setState(() {
      saving = true;
      statusKey = 'loginLoggingOut';
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
      statusKey = 'loginLoggedOut';
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
        statusKey = 'loginSuccessPrompt';
      } else if (path.contains('/accounts/login')) {
        statusKey = 'loginPromptOnLoginPage';
      } else {
        statusKey = 'loginPromptSaveBottom';
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
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.loginPageTitle,
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
            tooltip: AppLocalizations.of(context)!.logout,
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
                border: Border.all(color: color.primary.withOpacity(0.14)),
              ),
              child: Text(
                _statusText(context),
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
                      onCreateWindow:
                          (webController, createWindowAction) async {
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
                          statusKey = 'loginOpeningInstagramWithHint';
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
                          statusKey = 'loginOpenFailed';
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'By continuing, you agree to our policies.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall?.color?.withOpacity(0.72),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 4,
                      runSpacing: 0,
                      children: [
                        TextButton(
                          onPressed: () => openLegalWebView(
                            context,
                            title: AppLocalizations.of(context)!.privacyPolicy,
                            url: legalPrivacyPolicyUrl,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: color.primary,
                            visualDensity: VisualDensity.compact,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.privacyPolicy,
                          ),
                        ),
                        TextButton(
                          onPressed: () => openLegalWebView(
                            context,
                            title: AppLocalizations.of(context)!.termsOfUse,
                            url: legalTermsOfUseUrl,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: color.primary,
                            visualDensity: VisualDensity.compact,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          child: Text(AppLocalizations.of(context)!.termsOfUse),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
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
                            child: Text(AppLocalizations.of(context)!.cancel),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
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
                              label: Text(AppLocalizations.of(context)!.save),
                            ),
                          ),
                        ),
                      ],
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
