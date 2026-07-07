import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../repository/download_history_repository.dart';

class DownloadHistorySheet extends StatefulWidget {
  const DownloadHistorySheet({super.key, required this.cubit});

  final DownloaderCubit cubit;

  @override
  State<DownloadHistorySheet> createState() => _DownloadHistorySheetState();
}

class _DownloadHistorySheetState extends State<DownloadHistorySheet> {
  final Set<String> _selectedKeys = <String>{};

  bool get _selectionMode => _selectedKeys.isNotEmpty;

  void _toggleSelection(DownloadHistoryItem item) {
    final key = item.key.trim();
    if (key.isEmpty) return;

    setState(() {
      if (_selectedKeys.contains(key)) {
        _selectedKeys.remove(key);
      } else {
        _selectedKeys.add(key);
      }
    });
  }

  void _clearSelection() {
    if (_selectedKeys.isEmpty) return;
    setState(_selectedKeys.clear);
  }

  Future<bool> _showDeleteConfirmSheet({
    required String title,
    required String message,
    required String confirmText,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final color = Theme.of(sheetContext).colorScheme;

        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                  color: Colors.black.withOpacity(0.16),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.12),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.35,
                    color: color.onSurface.withOpacity(0.62),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    confirmText,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                  child: const Text(
                    'Huỷ',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return result == true;
  }

  Future<void> _confirmAndClearAll(BuildContext context) async {
    final ok = await _showDeleteConfirmSheet(
      title: 'Xoá tất cả lịch sử?',
      message: 'Tất cả mục trong lịch sử tải xuống sẽ bị xoá khỏi ứng dụng.',
      confirmText: 'Xoá tất cả',
    );

    if (!ok || !mounted) return;

    await widget.cubit.clearDownloadHistory();
    if (!mounted) return;

    _clearSelection();
  }

  Future<void> _confirmAndDeleteSelected(BuildContext context) async {
    final count = _selectedKeys.length;
    if (count == 0) return;

    final ok = await _showDeleteConfirmSheet(
      title: 'Xoá $count mục?',
      message: count == 1
          ? 'Mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.'
          : '$count mục đã chọn sẽ bị xoá khỏi lịch sử tải xuống.',
      confirmText: 'Xoá',
    );

    if (!ok || !mounted) return;

    final keys = Set<String>.from(_selectedKeys);
    await widget.cubit.removeDownloadHistoryItems(keys);
    if (!mounted) return;

    _clearSelection();
  }

  Future<void> _confirmAndDeleteOne(
    BuildContext context,
    DownloadHistoryItem item,
  ) async {
    final key = item.key.trim();
    if (key.isEmpty) return;

    final ok = await _showDeleteConfirmSheet(
      title: 'Xoá mục này?',
      message: 'Mục này sẽ bị xoá khỏi lịch sử tải xuống.',
      confirmText: 'Xoá',
    );

    if (!ok || !mounted) return;

    await widget.cubit.removeDownloadHistoryItems({key});
    if (!mounted) return;

    _selectedKeys.remove(key);
    setState(() {});
  }

  Future<void> _shareHistoryItem(
    BuildContext context,
    DownloadHistoryItem item,
  ) async {
    final localPath = item.localPath.trim();
    final file = File(localPath);

    if (localPath.isEmpty || !await file.exists()) {
      _showPreviewMessage(
        context,
        'Không thể chia sẻ. File không còn tồn tại trên máy.',
      );
      return;
    }

    try {
      await Share.shareXFiles([XFile(localPath)]);
    } catch (_) {
      if (!context.mounted) return;
      _showPreviewMessage(context, 'Không thể chia sẻ nội dung này.');
    }
  }

  Future<void> _saveHistoryItemAgain(
    BuildContext context,
    DownloadHistoryItem item,
  ) async {
    final localPath = item.localPath.trim();
    final file = File(localPath);

    if (localPath.isEmpty || !await file.exists()) {
      _showPreviewMessage(
        context,
        'Không thể lưu lại. File không còn tồn tại trên máy.',
      );
      return;
    }

    final isVideo = _isVideoType(item.type.trim().toLowerCase());

    try {
      if (isVideo) {
        await Gal.putVideo(localPath, album: 'IG Downloader');
      } else {
        await Gal.putImage(localPath, album: 'IG Downloader');
      }

      if (!context.mounted) return;
      _showPreviewMessage(context, 'Đã lưu lại vào thư viện.');
    } catch (_) {
      if (!context.mounted) return;
      _showPreviewMessage(context, 'Không thể lưu lại nội dung này.');
    }
  }

  void _showPreviewMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  Widget _previewActionBar({
    required BuildContext context,
    required DownloadHistoryItem item,
  }) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.fromLTRB(14, 10, 64, 0),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.58),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _previewActionButton(
                icon: Icons.ios_share_rounded,
                label: 'Chia sẻ',
                onTap: () => _shareHistoryItem(context, item),
              ),
              const SizedBox(width: 4),
              _previewActionButton(
                icon: Icons.download_rounded,
                label: 'Lưu',
                onTap: () => _saveHistoryItemAgain(context, item),
              ),
              const SizedBox(width: 4),
              _previewActionButton(
                icon: Icons.delete_outline_rounded,
                label: 'Xoá',
                isDanger: true,
                onTap: () async {
                  Navigator.of(context).pop();
                  await Future<void>.delayed(const Duration(milliseconds: 180));

                  if (!mounted) return;
                  await _confirmAndDeleteOne(this.context, item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _previewActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final color = isDanger ? Colors.redAccent : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
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
    return BlocBuilder<DownloaderCubit, DownloaderState>(
      bloc: widget.cubit,
      builder: (blocContext, state) {
        final items = state.downloadHistory;
        final color = Theme.of(context).colorScheme;

        final existingKeys = items.map((x) => x.key.trim()).toSet();
        final validSelectedCount = _selectedKeys
            .where(existingKeys.contains)
            .length;

        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.72,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              gradient: LinearGradient(
                colors: [
                  color.surface,
                  Color.alphaBlend(
                    color.primary.withOpacity(0.10),
                    color.surface,
                  ),
                  Color.alphaBlend(
                    color.tertiary.withOpacity(0.08),
                    color.surface,
                  ),
                  Color.alphaBlend(
                    color.secondary.withOpacity(0.08),
                    color.surface,
                  ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      colors: [color.primary, color.tertiary, color.secondary],
                    ),
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
                        child: Icon(
                          _selectionMode
                              ? Icons.check_circle_rounded
                              : Icons.history_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectionMode
                              ? 'Đã chọn $validSelectedCount'
                              : 'Lịch sử tải xuống',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      if (_selectionMode)
                        IconButton(
                          tooltip: 'Bỏ chọn',
                          onPressed: _clearSelection,
                          icon: const Icon(Icons.close_rounded),
                        ),
                      if (_selectionMode)
                        TextButton.icon(
                          onPressed: () => _confirmAndDeleteSelected(context),
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
                        )
                      else if (items.isNotEmpty)
                        TextButton.icon(
                          onPressed: () => _confirmAndClearAll(context),
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
                            'Xoá tất cả',
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
                                Icons.history_toggle_off_rounded,
                                size: 42,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Chưa có nội dung nào',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Bạn chưa tải nội dung nào',
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

  void _openHistoryPreview(BuildContext context, DownloadHistoryItem item) {
    final cleanType = item.type.trim().toLowerCase();
    final isVideo = _isVideoType(cleanType);
    final localPath = item.localPath.trim();
    final file = File(localPath);

    if (localPath.isEmpty || !file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Không thể mở nội dung này. File không còn tồn tại trên máy.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (previewContext) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Positioned.fill(
                child: isVideo
                    ? _HistoryVideoPreview(file: file)
                    : InteractiveViewer(
                        minScale: 0.8,
                        maxScale: 4,
                        child: Center(
                          child: Image.file(file, fit: BoxFit.contain),
                        ),
                      ),
              ),
              _previewActionBar(context: previewContext, item: item),
              Positioned(
                top: 8,
                right: 8,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.58),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(previewContext).pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _downloadHistoryTile(BuildContext context, DownloadHistoryItem item) {
    final theme = Theme.of(context);

    final cleanType = item.type.trim().toLowerCase();
    final isVideo = _isVideoType(cleanType);

    final safeUsername = _historyUsername(item);
    final safeFullName = _historyFullName(item, safeUsername);
    final safeAvatarUrl = _historyAvatarUrl(item, safeUsername);
    final safeThumbnailUrl = _historyThumbUrl(item);

    final title = safeFullName;
    final subtitle = safeUsername.isNotEmpty ? '@$safeUsername' : '';

    final typeText = _typeTagText(cleanType);
    final itemKey = item.key.trim();
    final selected = itemKey.isNotEmpty && _selectedKeys.contains(itemKey);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        if (_selectionMode) {
          _toggleSelection(item);
          return;
        }

        _openHistoryPreview(context, item);
      },
      onLongPress: () => _toggleSelection(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: selected
              ? theme.colorScheme.primary.withOpacity(0.08)
              : Colors.white.withOpacity(0.96),
          border: Border.all(
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withOpacity(0.16),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 8),
              color: theme.colorScheme.primary.withOpacity(0.08),
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
                  child: safeThumbnailUrl.isNotEmpty
                      ? Image.network(
                          safeThumbnailUrl,
                          width: 76,
                          height: 76,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                          errorBuilder: (_, __, ___) {
                            return _historyThumbFallback(
                              context,
                              item,
                              size: 76,
                            );
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
                      backgroundImage: safeAvatarUrl.isNotEmpty
                          ? NetworkImage(safeAvatarUrl)
                          : null,
                      child: safeAvatarUrl.isEmpty
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
                    SizedBox(
                      height: 19,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 16,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            color: theme.textTheme.bodySmall?.color
                                ?.withOpacity(0.72),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withOpacity(0.16),
                                theme.colorScheme.tertiary.withOpacity(0.14),
                                theme.colorScheme.secondary.withOpacity(0.13),
                              ],
                            ),
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
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: _selectionMode
                  ? Container(
                      key: ValueKey('select_$selected'),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.primary.withOpacity(0.10),
                        border: Border.all(
                          color: selected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.primary.withOpacity(0.35),
                          width: 1.4,
                        ),
                      ),
                      child: selected
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 20,
                            )
                          : null,
                    )
                  : Container(
                      key: const ValueKey('done'),
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
            ),
          ],
        ),
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

  String _historyUsername(DownloadHistoryItem item) {
    final fromSourceUrl = _usernameFromInstagramUrl(item.sourceUrl);

    if (fromSourceUrl.isNotEmpty) {
      return fromSourceUrl;
    }

    return _cleanUsername(item.username);
  }

  String _historyFullName(DownloadHistoryItem item, String safeUsername) {
    final fullName = _cleanHumanText(item.fullName);

    if (fullName.isEmpty) {
      return '';
    }

    final fromSourceUrl = _usernameFromInstagramUrl(item.sourceUrl);
    final storedUsername = _cleanUsername(item.username);

    if (fromSourceUrl.isNotEmpty) {
      if (storedUsername.isEmpty) {
        return '';
      }

      if (!_sameUsername(fromSourceUrl, storedUsername)) {
        return '';
      }
    }

    if (safeUsername.isNotEmpty && _sameUsername(fullName, safeUsername)) {
      return '';
    }

    return fullName;
  }

  String _historyAvatarUrl(DownloadHistoryItem item, String safeUsername) {
    final avatarUrl = _cleanUrl(item.avatarUrl);

    if (avatarUrl.isEmpty) {
      return '';
    }

    final fromSourceUrl = _usernameFromInstagramUrl(item.sourceUrl);
    final storedUsername = _cleanUsername(item.username);

    if (fromSourceUrl.isNotEmpty) {
      if (storedUsername.isEmpty) {
        return '';
      }

      if (!_sameUsername(fromSourceUrl, storedUsername)) {
        return '';
      }
    }

    return avatarUrl;
  }

  String _historyThumbUrl(DownloadHistoryItem item) {
    final thumbnail = _cleanUrl(item.thumbnailUrl);

    if (thumbnail.isNotEmpty) {
      return thumbnail;
    }

    final downloadUrl = _cleanUrl(item.downloadUrl);
    final cleanType = item.type.trim().toLowerCase();

    if (!_isVideoType(cleanType) && _looksLikeImageUrl(downloadUrl)) {
      return downloadUrl;
    }

    return '';
  }

  String _usernameFromInstagramUrl(String value) {
    final clean = _cleanUrl(value);

    if (clean.isEmpty) {
      return '';
    }

    Uri? uri;

    try {
      uri = Uri.parse(clean);
    } catch (_) {
      uri = null;
    }

    final segments =
        uri?.pathSegments
            .map((x) => x.trim())
            .where((x) => x.isNotEmpty)
            .toList() ??
        <String>[];

    if (segments.isEmpty) {
      return '';
    }

    final first = segments.first.toLowerCase();

    if (first == 's') {
      return '';
    }

    if (first == 'stories') {
      if (segments.length < 2) {
        return '';
      }

      final second = segments[1].toLowerCase();

      if (second == 'highlights' || second == 'highlight') {
        return '';
      }

      return _cleanUsername(segments[1]);
    }

    const reserved = {
      'p',
      'reel',
      'reels',
      'tv',
      'share',
      's',
      'stories',
      'highlight',
      'highlights',
      'explore',
      'accounts',
      'direct',
      'about',
      'developer',
      'api',
    };

    if (reserved.contains(first)) {
      return '';
    }

    final username = _cleanUsername(segments.first);

    if (username.isEmpty || reserved.contains(username.toLowerCase())) {
      return '';
    }

    return username;
  }

  bool _sameUsername(String a, String b) {
    final left = _cleanUsername(a).toLowerCase();
    final right = _cleanUsername(b).toLowerCase();

    return left.isNotEmpty && left == right;
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

  bool _looksLikeImageUrl(String value) {
    final lower = value.toLowerCase();

    return lower.contains('.jpg') ||
        lower.contains('.jpeg') ||
        lower.contains('.png') ||
        lower.contains('.webp') ||
        lower.contains('scontent') ||
        lower.contains('cdninstagram');
  }

  bool _isVideoType(String cleanType) {
    return cleanType.contains('video') ||
        cleanType.contains('reel') ||
        cleanType == 'mp4';
  }

  String _typeTagText(String cleanType) {
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

    return 'Nội dung';
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

class _HistoryVideoPreview extends StatefulWidget {
  const _HistoryVideoPreview({required this.file});

  final File file;

  @override
  State<_HistoryVideoPreview> createState() => _HistoryVideoPreviewState();
}

class _HistoryVideoPreviewState extends State<_HistoryVideoPreview> {
  late final VideoPlayerController _controller;
  bool _ready = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        if (!mounted) return;

        setState(() {
          _ready = true;
          _showControls = true;
        });

        _controller.play();
      });

    _controller.addListener(_onVideoChanged);
  }

  void _onVideoChanged() {
    if (!mounted || !_ready) return;

    setState(() {
      // Rebuild để cập nhật thời gian, progress và icon play/pause.
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoChanged);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_ready) return;

    setState(() {
      _showControls = true;

      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  String _formatDuration(Duration value) {
    final totalSeconds = value.inSeconds;
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    final value = _controller.value;
    final isPlaying = value.isPlaying;
    final position = value.position;
    final duration = value.duration;
    final safeDuration = duration.inMilliseconds <= 0
        ? const Duration(milliseconds: 1)
        : duration;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _togglePlayPause,
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),

          // Lớp tối nhẹ để controls dễ nhìn.
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _showControls || !isPlaying ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Container(color: Colors.black.withOpacity(0.10)),
            ),
          ),

          // Icon play/pause ở giữa.
          Center(
            child: AnimatedOpacity(
              opacity: _showControls || !isPlaying ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.48),
                ),
                child: Icon(
                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 44,
                ),
              ),
            ),
          ),

          // Thanh thời gian và tua video.
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.54),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.zero,
                    colors: const VideoProgressColors(
                      playedColor: Colors.white,
                      bufferedColor: Colors.white38,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDuration(position),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDuration(safeDuration),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
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
    );
  }
}
