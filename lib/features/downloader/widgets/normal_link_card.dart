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
                      : () => cubit.resolveMedia(urlCtrl.text),
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
