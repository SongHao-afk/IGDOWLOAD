import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../l10n/app_localizations.dart';

class PrivacyLinksPage extends StatelessWidget {
  const PrivacyLinksPage({super.key});

  static const String _termsOfUseUrl =
      'https://dilib.vn/truyen-tranh/cach-chien-thang-tran-dau-6002-chap-5.html';
  static const String _privacyPolicyUrl =
      'https://vi.wikipedia.org/wiki/Ng%C6%B0%E1%BB%9Di_%C4%91%E1%BB%93ng_t%C3%ADnh_nam';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final links = <_PrivacyLink>[
      _PrivacyLink(title: l10n.termsOfUse, url: _termsOfUseUrl),
      _PrivacyLink(title: l10n.privacyPolicy, url: _privacyPolicyUrl),
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
          l10n.privacyPolicy,
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
                _openLegalLink(context, link);
              },
            );
          },
        ),
      ),
    );
  }

  void _openLegalLink(BuildContext context, _PrivacyLink link) {
    if (link.url.isEmpty) return;

    final uri = Uri.tryParse(link.url);
    if (uri == null) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _LegalWebViewPage(title: link.title, url: link.url),
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

class _LegalWebViewPage extends StatefulWidget {
  const _LegalWebViewPage({required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<_LegalWebViewPage> createState() => _LegalWebViewPageState();
}

class _LegalWebViewPageState extends State<_LegalWebViewPage> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
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
          ),
          onProgressChanged: (controller, value) {
            if (!mounted) return;

            setState(() {
              progress = value / 100;
            });
          },
        ),
      ),
    );
  }
}
