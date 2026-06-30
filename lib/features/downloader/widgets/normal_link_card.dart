import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import 'glass_card.dart';

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
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: urlCtrl,
            maxLines: 1,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Dán link lẻ Instagram',
              hintText: 'https://www.instagram.com/p/... hoặc /reel/...',
              prefixIcon: Icon(Icons.link_rounded),
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
                  label: const Text('Duyệt IG'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton(
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
                      : const Text('Bú link lẻ'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
