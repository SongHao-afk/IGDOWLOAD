import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_cubit.dart';

class ThemePickerSheet extends StatefulWidget {
  const ThemePickerSheet({super.key});

  @override
  State<ThemePickerSheet> createState() => _ThemePickerSheetState();
}

class _ThemePickerSheetState extends State<ThemePickerSheet> {
  late AppThemeMode selectedMode;

  @override
  void initState() {
    super.initState();
    selectedMode = context.read<ThemeCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColors = AppTheme.getTheme(selectedMode).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(22, 10, 22, 18 + bottomPadding),
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.chooseThemeColor,
                    maxLines: 1,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
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
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themeDefault,
                mode: AppThemeMode.instagram,
                selectedMode: selectedMode,
                swatch: const _InstagramGradientSwatch(),
                onTap: _select,
              ),
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themeVivid,
                mode: AppThemeMode.vivid,
                selectedMode: selectedMode,
                swatch: const _VividSwatch(),
                onTap: _select,
              ),
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themePink,
                mode: AppThemeMode.pink,
                selectedMode: selectedMode,
                swatch: const _SolidSwatch(color: Color(0xFFFFC2D9)),
                onTap: _select,
              ),
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themeBlue,
                mode: AppThemeMode.blue,
                selectedMode: selectedMode,
                swatch: const _SoftBlueSwatch(),
                onTap: _select,
              ),
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themeRed,
                mode: AppThemeMode.red,
                selectedMode: selectedMode,
                swatch: const _SolidSwatch(color: Color(0xFFD24646)),
                onTap: _select,
              ),
              _ThemeChoiceCard(
                title: AppLocalizations.of(context)!.themeDark,
                mode: AppThemeMode.dark,
                selectedMode: selectedMode,
                swatch: const _DarkSwatch(),
                onTap: _select,
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(context),
                    style: FilledButton.styleFrom(
                      backgroundColor: isDark
                          ? colors.surfaceContainerHighest
                          : const Color(0xFFE8E5E5),
                      foregroundColor: colors.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 10,
                child: SizedBox(
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          selectedColors.primary,
                          selectedColors.tertiary,
                          selectedColors.secondary,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: selectedColors.primary.withOpacity(0.22),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: FilledButton(
                      onPressed: _apply,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppLocalizations.of(context)!.apply),
                          const SizedBox(width: 6),
                          const Icon(Icons.done_all_rounded, size: 19),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _select(AppThemeMode mode) {
    setState(() {
      selectedMode = mode;
    });
  }

  void _apply() {
    context.read<ThemeCubit>().changeTheme(selectedMode);
    Navigator.pop(context);
  }
}

class _ThemeChoiceCard extends StatelessWidget {
  const _ThemeChoiceCard({
    required this.title,
    required this.mode,
    required this.selectedMode,
    required this.swatch,
    required this.onTap,
  });

  final String title;
  final AppThemeMode mode;
  final AppThemeMode selectedMode;
  final Widget swatch;
  final ValueChanged<AppThemeMode> onTap;

  bool get selected => selectedMode == mode;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedColors = AppTheme.getTheme(selectedMode).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onTap(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? colors.surfaceContainerHighest : colors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? selectedColors.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: selectedColors.primary.withOpacity(selected ? 0.12 : 0.04),
              blurRadius: selected ? 16 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: swatch),
                  if (selected)
                    const Center(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0x33FFFFFF),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? selectedColors.primary
                            : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstagramGradientSwatch extends StatelessWidget {
  const _InstagramGradientSwatch();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const RadialGradient(
          center: Alignment(-0.45, 0.75),
          radius: 1.05,
          colors: [
            Color(0xFFFFF176),
            Color(0xFFFF7A30),
            Color(0xFFFF2F75),
            Color(0xFFC13584),
            Color(0xFF405DE6),
          ],
        ),
      ),
    );
  }
}

class _SolidSwatch extends StatelessWidget {
  const _SolidSwatch({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.48),
          ),
        ),
      ),
    );
  }
}

class _VividSwatch extends StatelessWidget {
  const _VividSwatch();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF4FA3), Color(0xFFC13584), Color(0xFF5AC8FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.58),
          ),
        ),
      ),
    );
  }
}

class _SoftBlueSwatch extends StatelessWidget {
  const _SoftBlueSwatch();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const RadialGradient(
          center: Alignment.center,
          radius: 0.95,
          colors: [Color(0xFF8DC7FF), Color(0xFFBDEAFF), Color(0xFFEAF8FF)],
        ),
      ),
    );
  }
}

class _DarkSwatch extends StatelessWidget {
  const _DarkSwatch();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [Color(0xFF05070A), Color(0xFF121820), Color(0xFFD19A55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.52),
          ),
        ),
      ),
    );
  }
}
