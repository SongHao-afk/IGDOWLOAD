import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/downloader_cubit.dart';
import '../cubit/downloader_state.dart';
import '../widgets/glass_card.dart';
import '../widgets/media_card.dart';
import '../widgets/server_settings_sheet.dart';
import '../widgets/theme_picker_sheet.dart';

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
                          GlassCard(
                            child: Column(
                              children: [
                                TextField(
                                  controller: urlCtrl,
                                  maxLines: 1,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  decoration: const InputDecoration(
                                    labelText: 'Dán link Instagram',
                                    hintText: 'https://www.instagram.com/p/...',
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
                                            : () => cubit.resolveMedia(
                                                urlCtrl.text,
                                              ),
                                        child: state.loading
                                            ? const SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : const Text('Bú link'),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: FilledButton.tonal(
                                        onPressed: state.media.isEmpty
                                            ? null
                                            : cubit.downloadAll,
                                        child: const Text('Tải tất cả'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                          if (state.media.isEmpty)
                            const SizedBox(
                              height: 220,
                              child: Center(child: Text('Chưa có media.')),
                            )
                          else
                            ListView.builder(
                              itemCount: state.media.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = state.media[index];

                                return MediaCard(
                                  item: item,
                                  onDownload: () => cubit.downloadMedia(item),
                                );
                              },
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
                'Lưu media vào album IG Downloader',
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
