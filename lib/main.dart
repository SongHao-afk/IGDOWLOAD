import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/downloader/cubit/downloader_cubit.dart';
import 'features/downloader/page/downloader_page.dart';

void main() {
  runApp(const IgDownloaderApp());
}

class IgDownloaderApp extends StatelessWidget {
  const IgDownloaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..loadTheme()),
        BlocProvider(create: (_) => DownloaderCubit()..loadSettings()),
      ],
      child: BlocBuilder<ThemeCubit, AppThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'IG Downloader',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(themeMode),
            home: const DownloaderPage(),
          );
        },
      ),
    );
  }
}
