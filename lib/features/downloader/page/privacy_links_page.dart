import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../l10n/app_localizations.dart';

const String legalTermsOfUseUrl =
    'https://ig-downloader-legal.vercel.app/terms-of-use';
const String legalPrivacyPolicyUrl =
    'https://ig-downloader-legal.vercel.app/privacy-policy';

void openLegalWebView(
  BuildContext context, {
  required String title,
  required String url,
}) {
  if (url.isEmpty) return;

  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) return;

  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => LegalWebViewPage(title: title, url: url),
    ),
  );
}

class PrivacyLinksPage extends StatelessWidget {
  const PrivacyLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final links = <_PrivacyLink>[
      _PrivacyLink(title: l10n.termsOfUse, url: legalTermsOfUseUrl),
      _PrivacyLink(title: l10n.privacyPolicy, url: legalPrivacyPolicyUrl),
    ];

    const backgroundColor = Colors.white;
    const textColor = Color(0xFF24142E);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
          color: textColor,
        ),
        titleSpacing: 0,
        title: Text(
          l10n.legalLinksTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFEDE8EF)),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 4),
          itemCount: links.length,
          itemBuilder: (context, index) {
            final link = links[index];

            return _PrivacyLinkTile(
              title: link.title,
              onTap: () {
                openLegalWebView(context, title: link.title, url: link.url);
              },
            );
          },
        ),
      ),
    );
  }
}

class _PrivacyLink {
  const _PrivacyLink({required this.title, required this.url});

  final String title;
  final String url;
}

class _PrivacyLinkTile extends StatelessWidget {
  const _PrivacyLinkTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF24142E),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class LegalWebViewPage extends StatefulWidget {
  const LegalWebViewPage({super.key, required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<LegalWebViewPage> createState() => _LegalWebViewPageState();
}

class _LegalWebViewPageState extends State<LegalWebViewPage> {
  InAppWebViewController? controller;
  double progress = 0;

  Future<void> _handleBackPressed() async {
    final webController = controller;

    if (webController != null && await webController.canGoBack()) {
      await webController.goBack();
      return;
    }

    if (!mounted) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white;
    const textColor = Color(0xFF24142E);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        await _handleBackPressed();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _handleBackPressed,
            icon: const Icon(Icons.arrow_back_rounded),
            color: textColor,
          ),
          titleSpacing: 0,
          title: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            child: progress < 1
                ? LinearProgressIndicator(
                    value: progress == 0 ? null : progress,
                    minHeight: 3,
                  )
                : Container(height: 1, color: const Color(0xFFEDE8EF)),
          ),
        ),
        body: SafeArea(
          top: false,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              supportZoom: false,
              transparentBackground: false,
              supportMultipleWindows: true,
              javaScriptCanOpenWindowsAutomatically: true,
              useShouldOverrideUrlLoading: true,
            ),
            onWebViewCreated: (webController) {
              controller = webController;
            },
            shouldOverrideUrlLoading: (webController, navigationAction) async {
              final url = navigationAction.request.url;
              final scheme = url?.scheme.toLowerCase();

              if (scheme == 'http' || scheme == 'https') {
                return NavigationActionPolicy.ALLOW;
              }

              return NavigationActionPolicy.CANCEL;
            },
            onCreateWindow: (webController, createWindowAction) async {
              final url = createWindowAction.request.url;

              if (url != null) {
                await webController.loadUrl(urlRequest: URLRequest(url: url));
              }

              return false;
            },
            onProgressChanged: (webController, value) {
              if (!mounted) return;

              setState(() {
                progress = value / 100;
              });
            },
          ),
        ),
      ),
    );
  }
}
