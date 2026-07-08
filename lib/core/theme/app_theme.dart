import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'theme_cubit.dart';

class AppTheme {
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.instagram:
        return _build(
          brightness: Brightness.light,
          primary: const Color(0xFFFF7A30),
          secondary: const Color(0xFF405DE6),
          tertiary: const Color(0xFFE1306C),
          background: const Color(0xFFFFEEF6),
          surface: Colors.white,
        );

      case AppThemeMode.vivid:
        return _build(
          brightness: Brightness.light,
          primary: AppColors.pink,
          secondary: AppColors.blue,
          background: AppColors.pinkBg,
          surface: Colors.white,
        );

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

      case AppThemeMode.dark:
        return _build(
          brightness: Brightness.dark,
          primary: const Color(0xFFD19A55),
          secondary: const Color(0xFF7C8B63),
          tertiary: const Color(0xFF9A6A43),
          background: AppColors.darkBg,
          surface: AppColors.darkCard,
        );
    }
  }

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    Color? tertiary,
    required Color background,
    required Color surface,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      primary: primary,
      secondary: secondary,
      surface: surface,
    ).copyWith(tertiary: tertiary ?? secondary);

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
