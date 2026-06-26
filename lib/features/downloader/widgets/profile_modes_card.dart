import 'package:flutter/material.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import 'glass_card.dart';

enum ProfileModeAction { stories, reels, posts }

class ProfileModesCard extends StatelessWidget {
  const ProfileModesCard({super.key, required this.state, required this.cubit});

  final DownloaderState state;
  final DownloaderCubit cubit;

  @override
  Widget build(BuildContext context) {
    return _profileModesCard(context, state, cubit);
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

  bool _isSingleMediaUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    if (uri == null) return false;

    final host = uri.host.toLowerCase();
    if (host != 'instagram.com' && !host.endsWith('.instagram.com')) {
      return false;
    }

    final path = uri.path.toLowerCase();

    return path.contains('/p/') ||
        path.contains('/reel/') ||
        path.contains('/reels/') ||
        path.contains('/tv/');
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
                    if (_isSingleMediaUrl(profileUrl)) {
                      await cubit.resolveMedia(profileUrl);
                      break;
                    }

                    cubit.setProfileMode('reels');
                    await cubit.loadProfileReels(profileUrl);
                    break;

                  case ProfileModeAction.posts:
                    if (_isSingleMediaUrl(profileUrl)) {
                      await cubit.resolveMedia(profileUrl);
                      break;
                    }

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
}
