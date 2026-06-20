import 'package:flutter/material.dart';

import '../models/ig_media_item.dart';

class MediaCard extends StatelessWidget {
  final IgMediaItem item;
  final VoidCallback? onDownload;
  final bool isDownloading;
  final String? errorText;

  const MediaCard({
    super.key,
    required this.item,
    required this.onDownload,
    this.isDownloading = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.trim().isNotEmpty;
    final ownerText = _ownerText(item);
    final mediaInfoText = _mediaInfoText(item);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: hasError ? 8 : 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface.withOpacity(0.96),
                Theme.of(context).colorScheme.primary.withOpacity(0.16),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              _PreviewBox(item: item),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_typeLabel(item)} #${item.id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    if (ownerText.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        ownerText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      mediaInfoText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall?.color?.withOpacity(0.68),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 76,
                height: 44,
                child: FilledButton(
                  onPressed: isDownloading ? null : onDownload,
                  style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                  child: isDownloading
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Tải'),
                ),
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }

  String _ownerText(IgMediaItem item) {
    final username = _cleanUsername(item.username);
    final fullName = item.fullName?.trim() ?? '';

    if (username.isNotEmpty) {
      return username;
    }

    if (fullName.isNotEmpty) {
      return fullName;
    }

    return '';
  }

  String _mediaInfoText(IgMediaItem item) {
    return _typeLabelVi(item);
  }

  String _typeLabel(IgMediaItem item) {
    final clean = item.type.trim().toLowerCase();

    if (clean == 'video' || clean == 'reel' || clean == 'mp4') {
      return 'VIDEO';
    }

    if (clean == 'photo' ||
        clean == 'image' ||
        clean == 'jpg' ||
        clean == 'jpeg' ||
        clean == 'png' ||
        clean == 'webp') {
      return 'PHOTO';
    }

    if (clean == 'carousel') {
      return 'CAROUSEL';
    }

    return clean.isEmpty ? 'MEDIA' : clean.toUpperCase();
  }

  String _typeLabelVi(IgMediaItem item) {
    final clean = item.type.trim().toLowerCase();

    if (clean == 'video' || clean == 'reel' || clean == 'mp4') {
      return 'Video';
    }

    if (clean == 'photo' ||
        clean == 'image' ||
        clean == 'jpg' ||
        clean == 'jpeg' ||
        clean == 'png' ||
        clean == 'webp') {
      return 'Ảnh';
    }

    if (clean == 'carousel') {
      return 'Bộ ảnh';
    }

    return clean.isEmpty ? 'Media' : clean;
  }

  String _cleanUsername(String? value) {
    final raw = value?.trim() ?? '';

    if (raw.isEmpty) {
      return '';
    }

    return raw.replaceFirst(RegExp(r'^@+'), '');
  }
}

class _PreviewBox extends StatelessWidget {
  final IgMediaItem item;

  const _PreviewBox({required this.item});

  @override
  Widget build(BuildContext context) {
    final isVideo = item.isVideo;
    final previewUrl = item.previewUrl.trim();

    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.18),
        border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (previewUrl.isNotEmpty)
            Image.network(
              previewUrl,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }

                return Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) {
                return _fallback(
                  context,
                  isVideo
                      ? Icons.play_arrow_rounded
                      : Icons.broken_image_rounded,
                );
              },
            )
          else
            _fallback(
              context,
              isVideo ? Icons.play_arrow_rounded : Icons.broken_image_rounded,
            ),
          if (isVideo)
            Container(
              color: Colors.black.withOpacity(0.12),
              child: Center(
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.86),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _fallback(BuildContext context, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.95),
            Theme.of(context).colorScheme.secondary.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 36),
    );
  }
}
