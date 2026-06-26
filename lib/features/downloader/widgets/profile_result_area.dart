import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';
import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';
import 'glass_card.dart';

class ProfileResultArea extends StatelessWidget {
  const ProfileResultArea({
    super.key,
    required this.state,
    required this.cubit,
  });

  final DownloaderState state;
  final DownloaderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return _profileResultArea(context, state, cubit);
  }

  Widget _profileResultArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileMode == 'stories') {
      return _storyResultArea(context, state, cubit);
    }

    if (state.profileMode == 'all') {
      return _allProfileResultArea(context, state, cubit);
    }

    if (state.profileMode == 'reels' || state.profileMode == 'posts') {
      return _feedResultArea(context, state, cubit);
    }

    return const SizedBox.shrink();
  }

  Widget _storyResultArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context: context,
            icon: Icons.auto_stories_rounded,
            title: 'Stories / Highlights',
          ),
          const SizedBox(height: 12),
          _profileGroupsList(context, state, cubit),
          const SizedBox(height: 14),
          _profileStoryItemsGrid(context, state, cubit),
        ],
      ),
    );
  }

  Widget _feedResultArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    final title = state.profileMode == 'reels'
        ? 'Danh sách Video Reel'
        : 'Danh sách Ảnh / Bài viết';

    final icon = state.profileMode == 'reels'
        ? Icons.movie_creation_rounded
        : Icons.photo_library_rounded;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(context: context, icon: icon, title: title),
          const SizedBox(height: 12),
          _profileFeedGrid(context, state, cubit),
          const SizedBox(height: 12),
          _loadMoreProfileFeedButton(context, state, cubit),
          const SizedBox(height: 14),
          _profileMediaGrid(context, state, cubit),
        ],
      ),
    );
  }

  Widget _allProfileResultArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            context: context,
            icon: Icons.person_pin_circle_rounded,
            title: state.profileUsername.trim().isEmpty
                ? 'Tổng hợp profile'
                : '@${state.profileUsername}',
          ),
          const SizedBox(height: 14),
          _sectionTitle(
            context: context,
            icon: Icons.auto_stories_rounded,
            title: 'Stories / Highlights',
          ),
          const SizedBox(height: 12),
          _profileGroupsList(context, state, cubit),
          const SizedBox(height: 14),
          _profileStoryItemsGrid(context, state, cubit),
          const SizedBox(height: 18),
          _sectionTitle(
            context: context,
            icon: Icons.photo_library_rounded,
            title: 'Ảnh / Video',
          ),
          const SizedBox(height: 12),
          _profileFeedGrid(context, state, cubit),
          const SizedBox(height: 14),
          _profileMediaGrid(context, state, cubit),
        ],
      ),
    );
  }

  Widget _sectionTitle({
    required BuildContext context,
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }

  Widget _profileGroupsList(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileGroupsLoading) {
      return const SizedBox(
        height: 132,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.profileGroups.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          state.profileMode == 'all'
              ? 'Chưa có story/highlight hoặc session không có quyền xem.'
              : 'Chưa có story/highlight. Bấm Stories rồi dán link profile.',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return SizedBox(
      height: 136,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.profileGroups.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final group = state.profileGroups[index];
          final selected = state.selectedProfileGroup?.id == group.id;

          return _profileGroupCircle(
            context: context,
            group: group,
            selected: selected,
            onTap: () => cubit.loadProfileStoryGroupItems(group),
          );
        },
      ),
    );
  }

  Widget _profileGroupCircle({
    required BuildContext context,
    required ProfileStoryGroup group,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SizedBox(
        width: 86,
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: selected ? 3 : 2,
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.withOpacity(0.65),
                ),
              ),
              child: ClipOval(
                child: group.coverUrl == null || group.coverUrl!.isEmpty
                    ? Container(
                        color: Colors.black26,
                        child: Icon(
                          group.isActiveStory
                              ? Icons.play_circle_fill_rounded
                              : Icons.auto_stories_rounded,
                        ),
                      )
                    : Image.network(
                        group.coverUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            color: Colors.black26,
                            child: const Icon(Icons.broken_image_rounded),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                group.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileStoryItemsGrid(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileItemsLoading) {
      return const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.selectedProfileGroup == null) {
      return const SizedBox.shrink();
    }

    if (state.profileItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Mục này không có item hoặc session hiện tại không có quyền xem.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return GridView.builder(
      itemCount: state.profileItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final item = state.profileItems[index];

        return _storyItemCard(
          context: context,
          item: item,
          downloading: state.downloadingProfileKeys.contains(item.downloadKey),
          onDownload: () => cubit.downloadProfileStoryItem(item),
        );
      },
    );
  }

  Widget _storyItemCard({
    required BuildContext context,
    required ProfileStoryItem item,
    required bool downloading,
    required VoidCallback onDownload,
  }) {
    final imageUrl = item.thumbnailUrl?.isNotEmpty == true
        ? item.thumbnailUrl!
        : item.downloadUrl;

    return _downloadableThumbCard(
      context: context,
      imageUrl: imageUrl,
      indexText: '#${item.index}',
      isVideo: item.isVideo,
      downloading: downloading,
      downloaded: false,
      onTap: null,
      onDownload: onDownload,
      caption: null,
    );
  }

  Widget _profileFeedGrid(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileFeedLoading) {
      return const SizedBox(
        height: 180,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.profileFeedItems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          state.profileMode == 'all'
              ? 'Chưa có ảnh/video hoặc session không có quyền xem.'
              : 'Chưa có dữ liệu. Bấm Video Reel hoặc Ảnh rồi dán link profile.',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return GridView.builder(
      itemCount: state.profileFeedItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 9,
        mainAxisSpacing: 9,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        final item = state.profileFeedItems[index];
        final selected =
            state.selectedProfileFeedItem?.shortcode == item.shortcode;

        return _profileFeedCard(
          context: context,
          item: item,
          selected: selected,
          onTap: () => cubit.loadProfileMediaItems(item),
        );
      },
    );
  }

  Widget _loadMoreProfileFeedButton(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileMode != 'reels' && state.profileMode != 'posts') {
      return const SizedBox.shrink();
    }

    if (state.profileFeedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    if (!state.profileFeedHasNextPage && !state.profileFeedLoadingMore) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'Đã hết dữ liệu.',
          style: TextStyle(
            color: Theme.of(
              context,
            ).textTheme.bodySmall?.color?.withOpacity(0.7),
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton.tonalIcon(
        onPressed: state.profileFeedLoadingMore
            ? null
            : cubit.loadMoreProfileFeed,
        icon: state.profileFeedLoadingMore
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.expand_more_rounded),
        label: Text(
          state.profileFeedLoadingMore ? 'Đang tải thêm...' : 'Tải thêm',
        ),
      ),
    );
  }

  Widget _profileFeedCard({
    required BuildContext context,
    required ProfileFeedItem item,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final imageUrl = item.coverUrl ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: selected ? 3 : 1,
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.white.withOpacity(0.16),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageUrl.isEmpty)
                Container(
                  color: Colors.black26,
                  child: const Icon(Icons.broken_image_rounded),
                )
              else
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: Colors.black26,
                      child: const Icon(Icons.broken_image_rounded),
                    );
                  },
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.68),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Icon(
                  item.kind == 'reel'
                      ? Icons.play_circle_fill_rounded
                      : item.type == 'carousel'
                      ? Icons.collections_rounded
                      : Icons.image_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              Positioned(
                left: 7,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '#${item.index}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 7,
                right: 7,
                bottom: 7,
                child: Text(
                  item.itemCount > 1
                      ? '${item.itemCount} mục'
                      : item.kind == 'reel'
                      ? 'Reel'
                      : 'Ảnh',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileMediaGrid(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileMediaLoading) {
      return const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.selectedProfileFeedItem == null) {
      return const SizedBox.shrink();
    }

    if (state.profileMediaItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Bài này chưa lấy được item con.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chọn item để tải',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: state.profileMediaItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final item = state.profileMediaItems[index];
            final cleanDownloadUrl = item.downloadUrl.trim();

            final downloaded = state.downloadedProfileMediaKeys.contains(
              cleanDownloadUrl,
            );

            return _profileMediaCard(
              context: context,
              item: item,
              downloading: state.downloadingProfileMediaUrls.contains(
                item.downloadUrl,
              ),
              downloaded: downloaded,
              onDownload: () => cubit.downloadProfileMediaItem(item),
            );
          },
        ),
      ],
    );
  }

  Widget _profileMediaCard({
    required BuildContext context,
    required ProfileMediaItem item,
    required bool downloading,
    required bool downloaded,
    required VoidCallback onDownload,
  }) {
    final imageUrl = item.thumbnailUrl?.isNotEmpty == true
        ? item.thumbnailUrl!
        : item.downloadUrl;

    return _downloadableThumbCard(
      context: context,
      imageUrl: imageUrl,
      indexText: '#${item.index}',
      isVideo: item.isVideo,
      downloading: downloading,
      downloaded: downloaded,
      onTap: null,
      onDownload: onDownload,
      caption: null,
    );
  }

  Widget _downloadableThumbCard({
    required BuildContext context,
    required String imageUrl,
    required String indexText,
    required bool isVideo,
    required bool downloading,
    bool downloaded = false,
    required VoidCallback? onTap,
    required VoidCallback onDownload,
    required String? caption,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: Colors.black26,
                  child: const Icon(Icons.broken_image_rounded),
                );
              },
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.72),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            if (downloaded)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Đã tải',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            if (isVideo)
              Positioned(
                top: downloaded ? 42 : 8,
                right: 8,
                child: const Icon(
                  Icons.play_circle_fill_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  indexText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: FilledButton.icon(
                onPressed: downloading ? null : onDownload,
                icon: downloading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_rounded),
                label: Text(
                  downloading
                      ? 'Đang tải'
                      : downloaded
                      ? 'Tải lại'
                      : 'Tải',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
