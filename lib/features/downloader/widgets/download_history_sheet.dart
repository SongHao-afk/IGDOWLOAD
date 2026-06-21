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
                const SizedBox(height: 6),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.28),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.12),
                        ),
                        child: Icon(
                          Icons.history_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
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
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                          ),
                          label: const Text(
                            'Xoá',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                    ],
                  ),
                ),
                if (items.isEmpty)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 82,
                              height: 82,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withOpacity(0.10),
                              ),
                              child: Icon(
                                Icons.history_toggle_off_rounded,
                                size: 42,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Chưa tải gì cả',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Một lịch sử trống trơn, rất thanh tịnh. Tải gì đó rồi quay lại đây.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.35,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color?.withOpacity(0.65),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
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
    final theme = Theme.of(context);

    final username = _cleanUsername(item.username);
    final fullName = _cleanHumanText(item.fullName);
    final avatarUrl = _cleanUrl(item.avatarUrl);
    final thumbnailUrl = _cleanUrl(item.thumbnailUrl);

    final cleanType = item.type.trim().toLowerCase();
    final isVideo = _isVideoType(cleanType);

    final title = username.isNotEmpty
        ? '@$username'
        : fullName.isNotEmpty
        ? fullName
        : 'Instagram media';

    final subtitle = _historySubtitle(
      username: username,
      fullName: fullName,
      cleanType: cleanType,
    );

    final typeText = _typeTagText(cleanType);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.cardColor.withOpacity(0.96),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: thumbnailUrl.isNotEmpty
                    ? Image.network(
                        thumbnailUrl,
                        width: 76,
                        height: 76,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        errorBuilder: (_, __, ___) {
                          return _historyThumbFallback(context, item, size: 76);
                        },
                      )
                    : _historyThumbFallback(context, item, size: 76),
              ),
              if (isVideo)
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.48),
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              Positioned(
                right: -7,
                bottom: -7,
                child: Container(
                  padding: const EdgeInsets.all(2.4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.12),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: theme.colorScheme.primary.withOpacity(
                      0.14,
                    ),
                    backgroundImage: avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : null,
                    child: avatarUrl.isEmpty
                        ? Icon(
                            Icons.person_rounded,
                            size: 19,
                            color: theme.colorScheme.primary,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.2,
                      color: theme.textTheme.bodySmall?.color?.withOpacity(
                        0.72,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: theme.colorScheme.primary.withOpacity(0.10),
                        ),
                        child: Text(
                          typeText,
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w900,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _historyTimeText(item.savedAt),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.textTheme.bodySmall?.color
                                ?.withOpacity(0.55),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withOpacity(0.12),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyThumbFallback(
    BuildContext context,
    DownloadHistoryItem item, {
    double size = 58,
  }) {
    final theme = Theme.of(context);

    final cleanType = item.type.trim().toLowerCase();
    final isVideo = _isVideoType(cleanType);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.primary.withOpacity(0.08),
      ),
      child: Icon(
        isVideo ? Icons.play_arrow_rounded : Icons.image_rounded,
        size: size * 0.42,
        color: theme.colorScheme.primary.withOpacity(0.85),
      ),
    );
  }

  String _historySubtitle({
    required String username,
    required String fullName,
    required String cleanType,
  }) {
    if (username.isNotEmpty && fullName.isNotEmpty) {
      return fullName;
    }

    if (username.isEmpty && fullName.isNotEmpty) {
      return _typeLabelVi(cleanType);
    }

    return _typeLabelVi(cleanType);
  }

  String _cleanUsername(String value) {
    final clean = value.trim().replaceFirst(RegExp(r'^@+'), '');

    if (_isGarbageText(clean)) {
      return '';
    }

    return clean;
  }

  String _cleanHumanText(String value) {
    final clean = value.trim();

    if (_isGarbageText(clean)) {
      return '';
    }

    return clean;
  }

  String _cleanUrl(String value) {
    final clean = value.trim();

    if (clean.isEmpty || clean == 'null') {
      return '';
    }

    final lower = clean.toLowerCase();

    if (!lower.startsWith('http://') && !lower.startsWith('https://')) {
      return '';
    }

    return clean;
  }

  bool _isGarbageText(String value) {
    final clean = value.trim();

    if (clean.isEmpty || clean == 'null') {
      return true;
    }

    final lower = clean.toLowerCase();

    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return true;
    }

    if (lower.contains('instagram.') || lower.contains('cdninstagram')) {
      return true;
    }

    if (lower.startsWith('instagram_')) {
      return true;
    }

    if (lower.endsWith('.mp4') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp')) {
      return true;
    }

    return false;
  }

  bool _isVideoType(String cleanType) {
    return cleanType.contains('video') ||
        cleanType.contains('reel') ||
        cleanType == 'mp4';
  }

  String _typeTagText(String cleanType) {
    if (_isVideoType(cleanType)) {
      return 'VIDEO';
    }

    if (cleanType.contains('photo') ||
        cleanType.contains('image') ||
        cleanType == 'jpg' ||
        cleanType == 'jpeg' ||
        cleanType == 'png' ||
        cleanType == 'webp') {
      return 'PHOTO';
    }

    return cleanType.isNotEmpty ? cleanType.toUpperCase() : 'MEDIA';
  }

  String _typeLabelVi(String cleanType) {
    if (_isVideoType(cleanType)) {
      return 'Video';
    }

    if (cleanType.contains('photo') ||
        cleanType.contains('image') ||
        cleanType == 'jpg' ||
        cleanType == 'jpeg' ||
        cleanType == 'png' ||
        cleanType == 'webp') {
      return 'Ảnh';
    }

    return 'Media';
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
