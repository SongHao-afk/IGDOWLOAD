import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_handler/share_handler.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../widgets/download_history_sheet.dart';
import '../widgets/downloader_hero.dart';
import '../widgets/frequent_profiles_card.dart';
import '../widgets/media_card.dart';
import '../widgets/normal_link_card.dart';
import '../widgets/profile_modes_card.dart';
import '../widgets/profile_result_area.dart';
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

  StreamSubscription? _shareSub;
  String? _lastSharedUrl;

  @override
  void initState() {
    super.initState();
    _initShareHandler();
  }

  @override
  void dispose() {
    _shareSub?.cancel();
    urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _initShareHandler() async {
    final handler = ShareHandlerPlatform.instance;

    try {
      final initial = await handler.getInitialSharedMedia();
      await _handleSharedText(initial?.content);
    } catch (_) {}

    _shareSub = handler.sharedMediaStream.listen((media) async {
      await _handleSharedText(media.content);
    });
  }

  Future<void> _handleSharedText(String? text) async {
    final clean = _extractInstagramUrl(text);
    if (clean == null) return;

    if (_lastSharedUrl == clean) return;
    _lastSharedUrl = clean;

    urlCtrl.text = clean;

    if (!mounted) return;

    final cubit = context.read<DownloaderCubit>();
    final state = cubit.state;

    if (state.loading || state.sessionBusy) return;

    await cubit.resolveMedia(clean);
  }

  String? _extractInstagramUrl(String? raw) {
    final text = raw?.trim() ?? '';
    if (text.isEmpty) return null;

    final match = RegExp(
      r'https?:\/\/(?:www\.)?instagram\.com\/[^\s]+',
      caseSensitive: false,
    ).firstMatch(text);

    final url = match?.group(0)?.trim();
    if (url == null || url.isEmpty) return null;

    return url;
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

  Future<void> openPrivateLogin(DownloaderCubit cubit) async {
    final cookie = await Navigator.of(context).push<String?>(
      MaterialPageRoute(builder: (_) => const InstagramLoginPage()),
    );

    if (cookie == null || cookie.trim().isEmpty) return;

    await cubit.savePrivateCookie(cookie);
  }

  bool loginDialogOpen = false;

  Future<void> showLoginRequiredDialog(DownloaderCubit cubit) async {
    if (loginDialogOpen) return;

    loginDialogOpen = true;

    final shouldLogin = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final color = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          icon: Icon(Icons.lock_rounded, color: color.primary, size: 32),
          title: const Text('Cần đăng nhập'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 180,
                child: TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Hủy'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 180,
                child: FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text('Đăng nhập'),
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
      listener: (context, state) {
        if (state.status == 'Cần đăng nhập') {
          showLoginRequiredDialog(context.read<DownloaderCubit>());
        }
      },
      builder: (context, state) {
        final cubit = context.read<DownloaderCubit>();
        final colors = Theme.of(context).colorScheme;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.96),
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
                tooltip: 'Truy cập thường xuyên',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: state.frequentProfiles.isEmpty
                    ? null
                    : () => _openFrequentProfilesSheet(context, cubit),
                icon: Icon(
                  Icons.history_toggle_off_rounded,
                  color: colors.primary,
                ),
              ),
              IconButton(
                tooltip: 'Đã tải gần đây',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: () => _openDownloadHistorySheet(context, cubit),
                icon: Icon(Icons.history_rounded, color: colors.secondary),
              ),
              IconButton(
                tooltip: 'Đổi giao diện',
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 44,
                ),
                onPressed: openThemePicker,
                icon: Icon(Icons.palette_rounded, color: colors.tertiary),
              ),
              IconButton(
                tooltip: 'Đăng nhập',
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
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.88),
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.78),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.72),
                  Theme.of(context).colorScheme.primary.withOpacity(0.36),
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
          errorText: state.downloadErrors[item.id],
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
