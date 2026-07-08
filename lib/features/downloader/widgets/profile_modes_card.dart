import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_messages.dart';
import '../cubit/downloader_state.dart';

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

  String _modeTitle(BuildContext context, ProfileModeAction mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ProfileModeAction.stories:
        return l10n.story;
      case ProfileModeAction.reels:
        return l10n.reels;
      case ProfileModeAction.posts:
        return l10n.posts;
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

  bool _isValidProfileInput(String value) {
    final clean = value.trim();
    if (clean.isEmpty) return false;

    final usernamePattern = RegExp(r'^@?[A-Za-z0-9._]{1,30}$');
    if (usernamePattern.hasMatch(clean)) return true;

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

    const reservedRoots = {'accounts', 'direct', 'explore'};

    return !reservedRoots.contains(segments.first);
  }

  Future<void> _showInvalidFormatDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final color = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          icon: Icon(Icons.error_outline_rounded, color: color.error, size: 32),
          title: Text(AppLocalizations.of(dialogContext)!.invalidProfileTitle),
          content: Text(
            AppLocalizations.of(dialogContext)!.invalidProfileMessage,
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(AppLocalizations.of(dialogContext)!.understood),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showProfileInfo(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      color: Theme.of(sheetContext).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(sheetContext)!.downloadFromProfile,
                      style: Theme.of(sheetContext).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(AppLocalizations.of(sheetContext)!.profileInfo1),
                const SizedBox(height: 8),
                Text(AppLocalizations.of(sheetContext)!.profileInfo2),
                const SizedBox(height: 14),
                Text(
                  AppLocalizations.of(sheetContext)!.example,
                  style: Theme.of(
                    sheetContext,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                const Text(
                  '@username\n'
                  'username\n'
                  'instagram.com/username',
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    child: Text(AppLocalizations.of(sheetContext)!.understood),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _modeHint(BuildContext context, ProfileModeAction mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ProfileModeAction.stories:
        return l10n.storyModeHint;
      case ProfileModeAction.reels:
        return l10n.reelsModeHint;
      case ProfileModeAction.posts:
        return l10n.postsModeHint;
    }
  }

  String _popupTitle(BuildContext context, ProfileModeAction mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ProfileModeAction.stories:
        return l10n.storyPopupTitle;
      case ProfileModeAction.reels:
        return l10n.reelsPopupTitle;
      case ProfileModeAction.posts:
        return l10n.postsPopupTitle;
    }
  }

  String _submitButtonText(BuildContext context, ProfileModeAction mode) {
    final l10n = AppLocalizations.of(context)!;
    switch (mode) {
      case ProfileModeAction.stories:
        return l10n.viewStory;
      case ProfileModeAction.reels:
        return l10n.viewReels;
      case ProfileModeAction.posts:
        return l10n.viewPosts;
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
        barrierColor: Colors.black.withOpacity(0.58),
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (dialogContext, setModalState) {
              final modalColor = Theme.of(dialogContext).colorScheme;

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

                if (localLoading) return;

                if (!_isValidProfileInput(profileUrl)) {
                  await _showInvalidFormatDialog(dialogContext);
                  return;
                }

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
                          gradient: LinearGradient(
                            colors: [
                              modalColor.surface,
                              Color.alphaBlend(
                                modalColor.primary.withOpacity(0.10),
                                modalColor.surface,
                              ),
                              Color.alphaBlend(
                                modalColor.tertiary.withOpacity(0.08),
                                modalColor.surface,
                              ),
                              Color.alphaBlend(
                                modalColor.secondary.withOpacity(0.08),
                                modalColor.surface,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: modalColor.primary.withOpacity(0.20),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: modalColor.primary.withOpacity(0.20),
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
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    gradient: LinearGradient(
                                      colors: [
                                        modalColor.primary,
                                        modalColor.tertiary,
                                        modalColor.secondary,
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                  child: Icon(
                                    _modeIcon(mode),
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _popupTitle(dialogContext, mode),
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
                              _modeHint(dialogContext, mode),
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
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  dialogContext,
                                )!.profileInputLabel,
                                hintText: AppLocalizations.of(
                                  dialogContext,
                                )!.profileInputHint,
                                prefixIcon: const Icon(
                                  Icons.person_search_rounded,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  gradient: LinearGradient(
                                    colors: [
                                      modalColor.primary,
                                      modalColor.tertiary,
                                      modalColor.secondary,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: modalColor.primary.withOpacity(
                                        0.20,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledBackgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
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
                                  label: Text(
                                    _submitButtonText(dialogContext, mode),
                                  ),
                                ),
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
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: [
            color.surface.withOpacity(0.99),
            color.primary.withOpacity(0.13),
            color.tertiary.withOpacity(0.10),
            color.secondary.withOpacity(0.12),
            color.surface.withOpacity(0.94),
          ],
          stops: const [0.0, 0.28, 0.52, 0.76, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.primary.withOpacity(0.20), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.primary.withOpacity(0.16),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [color.primary, color.tertiary, color.secondary],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.downloadFromProfile,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color.onSurface,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _showProfileInfo(context),
                icon: const Icon(Icons.info_outline_rounded),
                color: color.primary,
                tooltip: AppLocalizations.of(context)!.explainFeature,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            AppLocalizations.of(context)!.profileCardDescription,
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.72),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
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
              DownloaderMessages.resolve(context, state.profileError!),
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
    final color = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        _openProfileInputPopup(context: context, cubit: cubit, mode: mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          gradient: selected
              ? LinearGradient(
                  colors: [color.primary, color.tertiary, color.secondary],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                )
              : LinearGradient(
                  colors: [
                    isDark ? color.surfaceContainerHighest : Colors.white,
                    color.primary.withOpacity(0.10),
                    color.secondary.withOpacity(0.09),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          border: Border.all(
            color: selected ? Colors.white : color.primary.withOpacity(0.22),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: (selected ? color.primary : Colors.black).withOpacity(
                selected ? 0.18 : 0.05,
              ),
              blurRadius: selected ? 16 : 10,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              _modeIcon(mode),
              size: 20,
              color: selected ? Colors.white : color.primary,
            ),
            const SizedBox(height: 6),
            Text(
              _modeTitle(context, mode),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: selected ? Colors.white : color.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
