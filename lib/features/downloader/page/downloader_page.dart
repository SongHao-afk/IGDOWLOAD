import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_messages.dart';
import '../cubit/downloader_state.dart';
import '../widgets/download_history_sheet.dart';
import '../widgets/downloader_hero.dart';
import '../widgets/frequent_profiles_card.dart';
import '../widgets/media_card.dart';
import '../widgets/normal_link_card.dart';
import '../widgets/profile_modes_card.dart';
import '../widgets/profile_result_area.dart';
import '../widgets/settings_sheet.dart';
import '../widgets/theme_picker_sheet.dart';
import 'instagram_login_page.dart';
import 'language_picker_page.dart';
import 'manual_instagram_browser_page.dart';

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

  void openThemePicker() {
    showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ThemePickerSheet(),
    );
  }

  Future<void> openSettingsSheet() async {
    final action = await showModalBottomSheet<SettingsSheetAction>(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SettingsSheet(),
    );

    if (!mounted || action == null) return;

    switch (action) {
      case SettingsSheetAction.theme:
        openThemePicker();
        break;
      case SettingsSheetAction.language:
        await openLanguagePicker();
        break;
    }
  }

  Future<void> openLanguagePicker() async {
    await Navigator.of(
      context,
    ).push<void>(MaterialPageRoute(builder: (_) => const LanguagePickerPage()));
  }

  Future<void> openPrivateLogin(DownloaderCubit cubit) async {
    final cookie = await Navigator.of(context).push<String?>(
      MaterialPageRoute(
        builder: (_) => InstagramLoginPage(onLogout: cubit.logoutPrivateCookie),
      ),
    );

    if (cookie == null || cookie.trim().isEmpty) return;

    await cubit.savePrivateCookie(cookie);
  }

  bool loginDialogOpen = false;
  bool followDialogOpen = false;

  Future<void> showLoginRequiredDialog(DownloaderCubit cubit) async {
    if (loginDialogOpen) return;

    loginDialogOpen = true;

    final shouldLogin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final color = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          icon: Icon(Icons.lock_rounded, color: color.primary, size: 32),
          title: Text(AppLocalizations.of(dialogContext)!.loginRequiredTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                child: TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(AppLocalizations.of(dialogContext)!.cancel),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 180,
                child: FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text(AppLocalizations.of(dialogContext)!.login),
                ),
              ),
            ],
          ),
        );
      },
    );

    loginDialogOpen = false;

    if (shouldLogin == true && mounted) {
      await openPrivateLogin(cubit);
    }
  }

  Future<void> showFollowRequiredDialog() async {
    if (followDialogOpen) return;

    followDialogOpen = true;

    try {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          final color = Theme.of(dialogContext).colorScheme;

          return AlertDialog(
            icon: Icon(
              Icons.person_add_alt_1_rounded,
              color: color.primary,
              size: 32,
            ),
            title: Text(
              AppLocalizations.of(dialogContext)!.followRequiredTitle,
            ),
            content: Text(
              AppLocalizations.of(dialogContext)!.followRequiredMessage,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              SizedBox(
                width: 180,
                child: FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(AppLocalizations.of(dialogContext)!.understood),
                ),
              ),
            ],
          );
        },
      );
    } finally {
      followDialogOpen = false;
    }
  }

  Future<void> openManualInstagramBrowser() async {
    final cubit = context.read<DownloaderCubit>();
    final state = cubit.state;

    if (state.sessionBusy || state.loading) return;

    final cookie = (state.privateIgCookie ?? '').trim();

    if (cookie.isEmpty) {
      await showLoginRequiredDialog(cubit);
      return;
    }

    final startUrl = urlCtrl.text.trim();

    final pickedUrl = await Navigator.of(context).push<String?>(
      MaterialPageRoute(
        builder: (_) => ManualInstagramBrowserPage(
          startUrl: startUrl.isEmpty ? null : startUrl,
          privateIgCookie: cookie,
        ),
      ),
    );

    final clean = pickedUrl?.trim() ?? '';
    if (clean.isEmpty) return;

    urlCtrl.text = clean;

    if (!mounted) return;

    await cubit.resolveMedia(clean);
  }

  void _openDownloadHistorySheet(BuildContext context, DownloaderCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DownloadHistorySheet(cubit: cubit),
    );
  }

  void _showDownloadSuccessSnackBar(DownloaderCubit cubit) {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.downloadSuccessMessage),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.viewHistory,
            onPressed: () {
              if (!mounted) return;
              _openDownloadHistorySheet(context, cubit);
            },
          ),
        ),
      );
  }

  void _openFrequentProfilesSheet(BuildContext context, DownloaderCubit cubit) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<DownloaderCubit, DownloaderState>(
          builder: (context, state) {
            return SafeArea(
              child: FractionallySizedBox(
                heightFactor: 1,
                child: FrequentProfilesCard(
                  state: state,
                  cubit: cubit,
                  onProfileTap: (item) {
                    Navigator.of(sheetContext).pop();
                    cubit.loadFrequentProfileAll(item);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloaderCubit, DownloaderState>(
      listenWhen: (previous, current) {
        return previous.status != current.status ||
            previous.downloadHistory.length != current.downloadHistory.length;
      },
      listener: (context, state) {
        final cubit = context.read<DownloaderCubit>();

        if (DownloaderMessages.isLoginRequired(state.status)) {
          if (state.hasPrivateCookie) {
            showFollowRequiredDialog();
          } else {
            showLoginRequiredDialog(cubit);
          }
        }

        if (DownloaderMessages.isFollowRequired(state.status)) {
          showFollowRequiredDialog();
        }

        if (DownloaderMessages.isDownloadSuccess(state.status)) {
          _showDownloadSuccessSnackBar(cubit);
        }
      },
      builder: (context, state) {
        final cubit = context.read<DownloaderCubit>();
        final colors = Theme.of(context).colorScheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: isDark
                ? colors.surface.withOpacity(0.96)
                : Colors.white.withOpacity(0.96),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 12,
            title: const _InstagramTitle(),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(2),
              child: _InstagramGradientLine(),
            ),
            actions: [
              IconButton(
                tooltip: AppLocalizations.of(context)!.frequentAccessTooltip,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: () => _openFrequentProfilesSheet(context, cubit),
                icon: Icon(
                  Icons.history_toggle_off_rounded,
                  color: colors.primary,
                ),
              ),
              IconButton(
                tooltip: AppLocalizations.of(context)!.recentDownloadsTooltip,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: () => _openDownloadHistorySheet(context, cubit),
                icon: Icon(Icons.history_rounded, color: colors.secondary),
              ),
              IconButton(
                tooltip: AppLocalizations.of(context)!.settingsTitle,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: openSettingsSheet,
                icon: Icon(Icons.settings_rounded, color: colors.tertiary),
              ),
              IconButton(
                tooltip: AppLocalizations.of(context)!.login,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: state.sessionBusy
                    ? null
                    : () => openPrivateLogin(cubit),
                icon: _InstagramLoginIcon(active: state.hasPrivateCookie),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [
                        Color(0xFF05070A),
                        Color(0xFF0B1015),
                        Color(0xFF121A1A),
                        Color(0xFF18130D),
                        Color(0xFF070A0D),
                      ]
                    : [
                        colors.primary.withOpacity(0.88),
                        colors.tertiary.withOpacity(0.78),
                        colors.secondary.withOpacity(0.72),
                        colors.primary.withOpacity(0.36),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                stops: const [0.0, 0.18, 0.36, 0.62, 1.0],
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
                      14,
                      14,
                      14,
                      MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          DownloaderHero(state: state),
                          const SizedBox(height: 38),
                          ProfileModesCard(state: state, cubit: cubit),
                          const SizedBox(height: 14),
                          NormalLinkCard(
                            urlCtrl: urlCtrl,
                            state: state,
                            cubit: cubit,
                            onOpenManualInstagramBrowser:
                                openManualInstagramBrowser,
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DownloaderMessages.resolve(context, state.status),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ProfileResultArea(state: state, cubit: cubit),
                          const SizedBox(height: 12),
                          _normalMediaArea(context, state, cubit),
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

  Widget _normalMediaArea(
    BuildContext context,
    DownloaderState state,
    DownloaderCubit cubit,
  ) {
    if (state.media.isEmpty) return const SizedBox.shrink();

    return ListView.builder(
      itemCount: state.media.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = state.media[index];

        return MediaCard(
          item: item,
          isDownloading: state.downloadingIds.contains(item.id),
          errorText: DownloaderMessages.resolveNullable(
            context,
            state.downloadErrors[item.id],
          ),
          onDownload: state.downloadingAll
              ? null
              : () => cubit.downloadMedia(item),
        );
      },
    );
  }
}

class _InstagramTitle extends StatelessWidget {
  const _InstagramTitle();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final gradient = LinearGradient(
      colors: [color.primary, color.tertiary, color.secondary],
    );

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: color.primary.withOpacity(0.22),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.download_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => gradient.createShader(bounds),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'IG Downloader',
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 19,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InstagramGradientLine extends StatelessWidget {
  const _InstagramGradientLine();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.primary, color.tertiary, color.secondary],
        ),
      ),
      child: const SizedBox(width: double.infinity, height: 2),
    );
  }
}

class _InstagramLoginIcon extends StatelessWidget {
  const _InstagramLoginIcon({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? Theme.of(context).colorScheme.primary
        : const Color(0xFF111827);

    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 21,
            height: 21,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color, width: 2),
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              width: 3.5,
              height: 3.5,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
