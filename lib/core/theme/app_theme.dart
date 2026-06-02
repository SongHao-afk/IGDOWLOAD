import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'theme_cubit.dart';

class AppTheme {
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.pink:
        return _build(
          brightness: Brightness.light,
          primary: AppColors.pink,
          secondary: AppColors.pink2,
          background: AppColors.pinkBg,
          surface: Colors.white,
        );

      case AppThemeMode.blue:
        return _build(
          brightness: Brightness.light,
          primary: AppColors.blue,
          secondary: AppColors.blue2,
          background: AppColors.blueBg,
          surface: Colors.white,
        );

      case AppThemeMode.red:
        return _build(
          brightness: Brightness.light,
          primary: AppColors.red,
          secondary: AppColors.red2,
          background: AppColors.redBg,
          surface: Colors.white,
        );

      case AppThemeMode.white:
        return _build(
          brightness: Brightness.light,
          primary: Colors.black87,
          secondary: Colors.grey,
          background: AppColors.whiteBg,
          surface: AppColors.whiteCard,
        );

      case AppThemeMode.dark:
        return _build(
          brightness: Brightness.dark,
          primary: AppColors.pink,
          secondary: AppColors.blue,
          background: AppColors.darkBg,
          surface: AppColors.darkCard,
        );
    }
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color background,
    required Color surface,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      secondary: secondary,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.dark
            ? Colors.white.withOpacity(0.07)
            : Colors.white.withOpacity(0.86),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }
}
