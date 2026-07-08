import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locale/supported_language.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../l10n/app_localizations.dart';

enum SettingsSheetAction { theme, language }

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 18 + bottomPadding),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.16),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.settingsTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                color: colors.onSurface,
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocBuilder<ThemeCubit, AppThemeMode>(
            builder: (context, mode) {
              return _SettingsTile(
                icon: Icons.palette_rounded,
                iconColor: colors.tertiary,
                title: l10n.themeSettingTitle,
                subtitle: _themeLabel(l10n, mode),
                onTap: () => Navigator.pop(context, SettingsSheetAction.theme),
              );
            },
          ),
          const SizedBox(height: 10),
          _SettingsTile(
            icon: Icons.language_rounded,
            iconColor: colors.onSurface,
            title: l10n.languageSettingTitle,
            subtitle: _languageLabel(locale),
            onTap: () => Navigator.pop(context, SettingsSheetAction.language),
          ),
        ],
      ),
    );
  }

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.instagram:
        return l10n.themeDefault;
      case AppThemeMode.vivid:
        return l10n.themeVivid;
      case AppThemeMode.pink:
        return l10n.themePink;
      case AppThemeMode.blue:
        return l10n.themeBlue;
      case AppThemeMode.red:
        return l10n.themeRed;
      case AppThemeMode.dark:
        return l10n.themeDark;
    }
  }

  String _languageLabel(Locale locale) {
    return languageForCode(locale.languageCode).nativeName;
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? colors.surfaceContainerHighest : colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onSurface.withOpacity(0.56),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.onSurface.withOpacity(0.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
