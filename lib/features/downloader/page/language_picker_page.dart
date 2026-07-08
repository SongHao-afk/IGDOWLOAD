import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locale/locale_cubit.dart';
import '../../../core/locale/supported_language.dart';
import '../../../l10n/app_localizations.dart';

class LanguagePickerPage extends StatefulWidget {
  const LanguagePickerPage({super.key});

  @override
  State<LanguagePickerPage> createState() => _LanguagePickerPageState();
}

class _LanguagePickerPageState extends State<LanguagePickerPage> {
  String? _selectedCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedCode ??= _effectiveLocaleCode();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        titleSpacing: 0,
        title: Text(
          l10n.chooseLanguageTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: supportedLanguages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.05,
                  ),
                  itemBuilder: (context, index) {
                    final language = supportedLanguages[index];

                    return _LanguageTile(
                      nativeName: language.nativeName,
                      subtitle: _localizedLanguageName(l10n, language),
                      selected: _selectedCode == language.code,
                      onTap: () {
                        setState(() {
                          _selectedCode = language.code;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        colors.primary,
                        colors.tertiary,
                        colors.secondary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: FilledButton(
                    onPressed: _save,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    child: Text(l10n.save),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _effectiveLocaleCode() {
    final current = context.read<LocaleCubit>().state.languageCode;
    return supportedLanguageCodes.contains(current) ? current : 'en';
  }

  String _localizedLanguageName(
    AppLocalizations l10n,
    SupportedLanguage language,
  ) {
    return l10n.localeName == 'vi'
        ? language.vietnameseName
        : language.englishName;
  }

  Future<void> _save() async {
    final code = _selectedCode;
    if (code == null) return;

    await context.read<LocaleCubit>().changeLocale(Locale(code));
    if (!mounted) return;

    Navigator.pop(context);
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.nativeName,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String nativeName;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = colors.tertiary;

    return Material(
      color: selected
          ? activeColor.withOpacity(isDark ? 0.16 : 0.05)
          : isDark
          ? colors.surfaceContainerHighest
          : const Color(0xFFF2F1F2),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? activeColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      nativeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.onSurface.withOpacity(0.48),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: activeColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
