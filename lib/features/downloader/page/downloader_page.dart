import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../widgets/download_history_sheet.dart';
import '../widgets/downloader_hero.dart';
import '../widgets/media_card.dart';
import '../widgets/normal_link_card.dart';
import '../widgets/profile_modes_card.dart';
import '../widgets/profile_result_area.dart';
import '../widgets/server_settings_sheet.dart';
import '../widgets/session_mode_card.dart';
import '../widgets/theme_picker_sheet.dart';
import 'instagram_login_page.dart';
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

  Future<void> openManualInstagramBrowser() async {
    final cubit = context.read<DownloaderCubit>();
    final state = cubit.state;

    if (state.sessionBusy || state.loading) return;

    final cookie = (state.privateIgCookie ?? '').trim();

    if (!state.privateMode || cookie.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Manual Browser cần bật Private mode trước.'),
        ),
      );
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
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (_) => DownloadHistorySheet(cubit: cubit),
    );
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
                tooltip: 'Đã tải gần đây',
                onPressed: () => _openDownloadHistorySheet(context, cubit),
                icon: const Icon(Icons.history_rounded),
              ),
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
                          DownloaderHero(state: state),
                          const SizedBox(height: 46),
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
                              state.status,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ProfileResultArea(state: state, cubit: cubit),
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
}
