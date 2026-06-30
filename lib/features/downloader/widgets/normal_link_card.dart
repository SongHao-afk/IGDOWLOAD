import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';

class NormalLinkCard extends StatelessWidget {
  const NormalLinkCard({
    super.key,
    required this.urlCtrl,
    required this.state,
    required this.cubit,
    required this.onOpenManualInstagramBrowser,
  });

  final TextEditingController urlCtrl;
  final DownloaderState state;
  final DownloaderCubit cubit;
  final Future<void> Function() onOpenManualInstagramBrowser;

  @override
  Widget build(BuildContext context) {
    return _normalLinkCard(context, state, cubit);
  }

  bool _isValidInstagramMediaUrl(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return false;

    final uri = Uri.tryParse(clean);
    if (uri == null || !uri.hasScheme || uri.host.trim().isEmpty) {
      return false;
    }

    final scheme = uri.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') return false;

    final host = uri.host.toLowerCase();
    if (host != 'instagram.com' && !host.endsWith('.instagram.com')) {
      return false;
    }

    final segments = uri.pathSegments
        .map((x) => x.trim().toLowerCase())
        .where((x) => x.isNotEmpty)
        .toList();

    if (segments.isEmpty) return false;

    const supportedRoots = {
      'p',
      'reel',
      'reels',
      'tv',
      'stories',
      's',
    };

    return supportedRoots.contains(segments.first);
  }

  Future<void> _showInvalidFormatDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final color = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          icon: Icon(
            Icons.error_outline_rounded,
            color: color.error,
            size: 32,
          ),
          title: const Text('Vui lòng nhập đúng định dạng'),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _normalLinkCard(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: [
            color.surface.withOpacity(0.99),
            color.primary.withOpacity(0.13),
            color.tertiary.withOpacity(0.10),
            color.secondary.withOpacity(0.12),
            color.surface.withOpacity(0.94),
          ],
          stops: const [0.0, 0.28, 0.52, 0.76, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.primary.withOpacity(0.20), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.secondary.withOpacity(0.13),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [
                      color.primary,
                      color.tertiary,
                      color.secondary,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: const Icon(
                  Icons.link_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Dán link lẻ',
                  style: TextStyle(
                    color: Color(0xFF171321),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          TextField(
            controller: urlCtrl,
            maxLines: 1,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Dán link Instagram',
              hintText: 'https://www.instagram.com/p/... hoặc /reel/...',
              prefixIcon: const Icon(Icons.link_rounded),
              filled: true,
              fillColor: Colors.white.withOpacity(0.92),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: color.primary.withOpacity(0.22)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: color.primary,
                  width: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Muốn tự mở story/highlight/reel trong Instagram thì bấm "Duyệt IG", mở đúng nội dung rồi lấy URL hiện tại.',
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.72),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: state.sessionBusy || state.loading
                      ? null
                      : () => onOpenManualInstagramBrowser(),
                  icon: const Icon(Icons.travel_explore_rounded),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    foregroundColor: color.primary,
                    backgroundColor: Colors.white.withOpacity(0.82),
                    side: BorderSide(
                      color: color.primary,
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  label: const Text('Duyệt IG'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        color.primary,
                        color.tertiary,
                        color.secondary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.primary.withOpacity(0.22),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    onPressed: state.loading
                        ? null
                        : () async {
                            if (!_isValidInstagramMediaUrl(urlCtrl.text)) {
                              await _showInvalidFormatDialog(context);
                              return;
                            }

                            await cubit.resolveMedia(urlCtrl.text);
                          },
                    child: state.loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Lấy nội dung',
                              maxLines: 1,
                              softWrap: false,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

