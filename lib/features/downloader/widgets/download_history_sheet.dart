import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../repository/download_history_repository.dart';

class DownloadHistorySheet extends StatelessWidget {
  const DownloadHistorySheet({super.key, required this.cubit});

  final DownloaderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloaderCubit, DownloaderState>(
      bloc: cubit,
      builder: (blocContext, state) {
        final items = state.downloadHistory;

        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.72,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                  child: Row(
                    children: [
                      const Icon(Icons.history_rounded),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Đã tải gần đây',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      if (items.isNotEmpty)
                        TextButton.icon(
                          onPressed: () async {
                            await cubit.clearDownloadHistory();

                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.delete_outline_rounded),
                          label: const Text('Xoá'),
                        ),
                    ],
                  ),
                ),
                if (items.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Chưa tải gì cả.\nMột lịch sử trống trơn, rất thanh tịnh.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return _downloadHistoryTile(context, item);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _downloadHistoryTile(BuildContext context, DownloadHistoryItem item) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor.withOpacity(0.92),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: item.avatarUrl.isNotEmpty
                ? NetworkImage(item.avatarUrl)
                : null,
            child: item.avatarUrl.isEmpty
                ? const Icon(Icons.person_rounded)
                : null,
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: item.thumbnailUrl.isNotEmpty
                ? Image.network(
                    item.thumbnailUrl,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return _historyThumbFallback(item);
                    },
                  )
                : _historyThumbFallback(item),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.username.isNotEmpty
                      ? '@${item.username}'
                      : 'Instagram media',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.type.toUpperCase()} · ${item.shortcode}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _historyTimeText(item.savedAt),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.55),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.check_circle_rounded, color: Colors.green),
        ],
      ),
    );
  }

  Widget _historyThumbFallback(DownloadHistoryItem item) {
    return Container(
      width: 58,
      height: 58,
      color: Colors.black.withOpacity(0.08),
      child: Icon(
        item.type == 'video' ? Icons.play_arrow_rounded : Icons.image_rounded,
      ),
    );
  }

  String _historyTimeText(String value) {
    final date = DateTime.tryParse(value);

    if (date == null) {
      return 'Vừa tải';
    }

    final local = date.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '$day/$month · $hour:$minute';
  }
}
