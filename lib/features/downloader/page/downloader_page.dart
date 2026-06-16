import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../models/profile_feed_item.dart';
import '../models/profile_media_item.dart';
import '../models/profile_story_group.dart';
import '../models/profile_story_item.dart';
import '../widgets/glass_card.dart';
import '../widgets/media_card.dart';
import '../widgets/server_settings_sheet.dart';
import '../widgets/session_mode_card.dart';
import '../widgets/theme_picker_sheet.dart';
import 'instagram_login_page.dart';

enum ProfileModeAction { stories, reels, posts }

class DownloaderPage extends StatefulWidget {
  const DownloaderPage({super.key});

  @override
  State<DownloaderPage> createState() => _DownloaderPageState();
}

class _DownloaderPageState extends State<DownloaderPage> {
  final TextEditingController urlCtrl = TextEditingController();

  @override
  void dispose() {
    urlCtrl.dispose();
    super.dispose();
  }

  void openServerSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      builder: (_) => BlocProvider.value(
        value: context.read<DownloaderCubit>(),
        child: const ServerSettingsSheet(),
      ),
    );
  }

  void openThemePicker() {
    showModalBottomSheet(
      context: context,
      showDragHandle: false,
      builder: (_) => const ThemePickerSheet(),
    );
  }

  Future<void> openPrivateLogin(DownloaderCubit cubit) async {
    final cookie = await Navigator.of(context).push<String?>(
      MaterialPageRoute(builder: (_) => const InstagramLoginPage()),
    );

    if (cookie == null || cookie.trim().isEmpty) return;

    await cubit.savePrivateCookie(cookie);
  }

  Future<void> logoutPrivate(DownloaderCubit cubit) async {
    await CookieManager.instance().deleteAllCookies();
    await cubit.logoutPrivateCookie();
  }

  String _modeKey(ProfileModeAction mode) {
    switch (mode) {
      case ProfileModeAction.stories:
        return 'stories';
      case ProfileModeAction.reels:
        return 'reels';
      case ProfileModeAction.posts:
        return 'posts';
    }
  }

  String _modeTitle(ProfileModeAction mode) {
    switch (mode) {
      case ProfileModeAction.stories:
        return 'Stories';
      case ProfileModeAction.reels:
        return 'Video Reel';
      case ProfileModeAction.posts:
        return 'Ảnh';
    }
  }

  IconData _modeIcon(ProfileModeAction mode) {
    switch (mode) {
      case ProfileModeAction.stories:
        return Icons.auto_stories_rounded;
      case ProfileModeAction.reels:
        return Icons.movie_creation_rounded;
      case ProfileModeAction.posts:
        return Icons.photo_library_rounded;
    }
  }

  String _modeHint(ProfileModeAction mode) {
    switch (mode) {
      case ProfileModeAction.stories:
        return 'Dán link profile để lấy story/highlight';
      case ProfileModeAction.reels:
        return 'Dán link profile để lấy danh sách reels';
      case ProfileModeAction.posts:
        return 'Dán link profile để lấy danh sách ảnh/bài viết';
    }
  }

  Future<void> _openProfileInputPopup({
    required BuildContext context,
    required DownloaderCubit cubit,
    required ProfileModeAction mode,
  }) async {
    final ctrl = TextEditingController();
    var localLoading = false;

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.35),
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setModalState) {
              Future<void> closePopup() async {
                FocusManager.instance.primaryFocus?.unfocus();

                await Future<void>.delayed(const Duration(milliseconds: 120));

                if (!dialogContext.mounted) return;

                final navigator = Navigator.of(
                  dialogContext,
                  rootNavigator: true,
                );

                if (navigator.canPop()) {
                  navigator.pop();
                }
              }

              Future<void> submit() async {
                final profileUrl = ctrl.text.trim();

                if (profileUrl.isEmpty || localLoading) return;

                setModalState(() {
                  localLoading = true;
                });

                await closePopup();

                switch (mode) {
                  case ProfileModeAction.stories:
                    cubit.setProfileMode('stories');
                    cubit.updateProfileUrl(profileUrl);
                    await cubit.loadProfileStoryGroups();
                    break;

                  case ProfileModeAction.reels:
                    cubit.setProfileMode('reels');
                    await cubit.loadProfileReels(profileUrl);
                    break;

                  case ProfileModeAction.posts:
                    cubit.setProfileMode('posts');
                    await cubit.loadProfilePosts(profileUrl);
                    break;
                }
              }

              return PopScope(
                canPop: false,
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(dialogContext).cardColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.22),
                              blurRadius: 28,
                              offset: const Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_modeIcon(mode)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Tải ${_modeTitle(mode)} từ trang cá nhân',
                                    style: Theme.of(dialogContext)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                IconButton(
                                  onPressed: localLoading ? null : closePopup,
                                  icon: const Icon(Icons.close_rounded),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _modeHint(mode),
                              style: TextStyle(
                                color: Theme.of(
                                  dialogContext,
                                ).textTheme.bodySmall?.color?.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: ctrl,
                              autofocus: true,
                              maxLines: 1,
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (_) => submit(),
                              decoration: const InputDecoration(
                                labelText: 'Link profile hoặc username',
                                hintText: 'https://www.instagram.com/username',
                                prefixIcon: Icon(Icons.person_search_rounded),
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: localLoading ? null : submit,
                                icon: localLoading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.search_rounded),
                                label: Text('Bú ${_modeTitle(mode)}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    } finally {
      ctrl.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloaderCubit, DownloaderState>(
      builder: (context, state) {
        final cubit = context.read<DownloaderCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text(
              'IG Downloader',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            actions: [
              IconButton(
                onPressed: openThemePicker,
                icon: const Icon(Icons.palette_rounded),
              ),
              IconButton(
                onPressed: openServerSettings,
                icon: const Icon(Icons.settings_rounded),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).colorScheme.primary.withOpacity(0.24),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.14),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          _hero(context, state),
                          const SizedBox(height: 46),
                          _profileModesCard(context, state, cubit),
                          const SizedBox(height: 14),
                          _normalLinkCard(context, state, cubit),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.status,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _profileResultArea(context, state, cubit),
                          const SizedBox(height: 12),
                          _normalMediaArea(context, state, cubit),
                          const SizedBox(height: 12),
                          SessionModeCard(
                            privateMode: state.privateMode,
                            hasPrivateCookie: state.hasPrivateCookie,
                            sessionBusy: state.sessionBusy,
                            onModeChanged: cubit.setPrivateMode,
                            onLogin: () => openPrivateLogin(cubit),
                            onLogout: () => logoutPrivate(cubit),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _profileModesCard(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.dashboard_customize_rounded),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tải từ trang cá nhân',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Chọn mode, dán link profile, rồi app sẽ hiện danh sách để chọn tải.',
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.72),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _profileModeButton(
                  context: context,
                  state: state,
                  cubit: cubit,
                  mode: ProfileModeAction.stories,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _profileModeButton(
                  context: context,
                  state: state,
                  cubit: cubit,
                  mode: ProfileModeAction.reels,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _profileModeButton(
                  context: context,
                  state: state,
                  cubit: cubit,
                  mode: ProfileModeAction.posts,
                ),
              ),
            ],
          ),
          if (state.profileError != null) ...[
            const SizedBox(height: 10),
            Text(
              state.profileError!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _profileModeButton({
    required BuildContext context,
    required DownloaderState state,
    required DownloaderCubit cubit,
    required ProfileModeAction mode,
  }) {
    final selected = state.profileMode == _modeKey(mode);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        _openProfileInputPopup(context: context, cubit: cubit, mode: mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: selected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.18)
              : Colors.white.withOpacity(0.06),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.white.withOpacity(0.16),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              _modeIcon(mode),
              size: 28,
              color: selected ? Theme.of(context).colorScheme.primary : null,
            ),
            const SizedBox(height: 6),
            Text(
              _modeTitle(mode),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _normalLinkCard(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    return GlassCard(
      child: Column(
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
          const SizedBox(height: 12),
          Row(
            children: [
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
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.tonal(
                  onPressed: state.media.isEmpty || state.isAnyDownloading
                      ? null
                      : cubit.downloadAll,
                  child: state.downloadingAll
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Tải tất cả'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileResultArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.profileMode == 'stories') {
      return _storyResultArea(context, state, cubit);
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
        height: 96,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.profileGroups.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Chưa có story/highlight. Bấm Stories rồi dán link profile.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      );
    }

    return SizedBox(
      height: 116,
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
            const SizedBox(height: 6),
            Text(
              group.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
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
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Chưa có dữ liệu. Bấm Video Reel hoặc Ảnh rồi dán link profile.',
          style: TextStyle(fontWeight: FontWeight.w600),
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

            return _profileMediaCard(
              context: context,
              item: item,
              downloading: state.downloadingProfileMediaUrls.contains(
                item.downloadUrl,
              ),
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
            if (isVideo)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
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
                label: Text(downloading ? 'Đang tải' : 'Tải'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _normalMediaArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.media.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: state.media.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = state.media[index];

        return MediaCard(
          item: item,
          isDownloading: state.downloadingIds.contains(item.id),
          errorText: state.downloadErrors[item.id],
          onDownload: state.downloadingAll
              ? null
              : () => cubit.downloadMedia(item),
        );
      },
    );
  }

  Widget _hero(BuildContext context, DownloaderState state) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 34),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.34),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tải ảnh, reel, story',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.privateMode
                    ? 'Private mode: dùng đăng nhập Instagram trên máy này'
                    : 'Public mode: dùng session mặc định',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 22,
          bottom: -28,
          child: _bubbleImage('lib/images/anh1.jpg', 58),
        ),
        Positioned(
          left: 88,
          bottom: -18,
          child: _bubbleImage('lib/images/anh2.jpg', 44),
        ),
        Positioned(
          right: 88,
          bottom: -25,
          child: _bubbleImage('lib/images/anh3.jpg', 52),
        ),
        Positioned(
          right: 26,
          bottom: -14,
          child: _bubbleImage('lib/images/anh4.jpg', 40),
        ),
      ],
    );
  }

  Widget _bubbleImage(String path, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
}
