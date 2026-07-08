import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final hasError = errorText != null && errorText!.trim().isNotEmpty;

    final fullName = item.fullName.trim();
    final username = item.username.trim();
    final avatarUrl = item.avatarUrl.trim();

    final usernameText = username.isNotEmpty ? '@$username' : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 114,
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
                child: SizedBox(
                  height: 82,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _AvatarBox(avatarUrl: avatarUrl),
                          const SizedBox(width: 9),
                          Expanded(
                            child: SizedBox(
                              height: 24,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  fullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 15.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 20,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            usernameText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color?.withOpacity(0.62),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 76,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.tertiary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: FilledButton(
                    onPressed: isDownloading ? null : onDownload,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: isDownloading
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : Text(
                            l10n.download,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                  ),
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
}

class _AvatarBox extends StatelessWidget {
  final String avatarUrl;

  const _AvatarBox({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.16),
      ),
      child: avatarUrl.isNotEmpty
          ? Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              headers: const {
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                'Referer': 'https://www.instagram.com/',
              },
              errorBuilder: (_, __, ___) => _fallback(context),
            )
          : _fallback(context),
    );
  }

  Widget _fallback(BuildContext context) {
    return Icon(
      Icons.person_rounded,
      size: 18,
      color: Theme.of(context).colorScheme.primary,
    );
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
              headers: const {
                'User-Agent':
                    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                'Referer': 'https://www.instagram.com/',
              },
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;

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
            Center(
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
            Theme.of(context).colorScheme.tertiary.withOpacity(0.82),
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
