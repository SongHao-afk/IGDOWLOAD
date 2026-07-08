import 'package:flutter/widgets.dart';

class SupportedLanguage {
  const SupportedLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.vietnameseName,
  });

  final String code;
  final String nativeName;
  final String englishName;
  final String vietnameseName;

  Locale get locale => Locale(code);
}

const supportedLanguages = <SupportedLanguage>[
  SupportedLanguage(
    code: 'en',
    nativeName: 'English',
    englishName: 'English',
    vietnameseName: 'Tiếng Anh',
  ),
  SupportedLanguage(
    code: 'vi',
    nativeName: 'Tiếng Việt',
    englishName: 'Vietnamese',
    vietnameseName: 'Tiếng Việt',
  ),
  SupportedLanguage(
    code: 'id',
    nativeName: 'Indonesia',
    englishName: 'Indonesian',
    vietnameseName: 'Tiếng Indonesia',
  ),
  SupportedLanguage(
    code: 'th',
    nativeName: 'ภาษาไทย',
    englishName: 'Thai',
    vietnameseName: 'Tiếng Thái',
  ),
  SupportedLanguage(
    code: 'ms',
    nativeName: 'Bahasa Melayu',
    englishName: 'Malay',
    vietnameseName: 'Tiếng Mã Lai',
  ),
  SupportedLanguage(
    code: 'fil',
    nativeName: 'Filipino',
    englishName: 'Filipino',
    vietnameseName: 'Tiếng Filipino',
  ),
  SupportedLanguage(
    code: 'ja',
    nativeName: '日本語',
    englishName: 'Japanese',
    vietnameseName: 'Tiếng Nhật',
  ),
  SupportedLanguage(
    code: 'ko',
    nativeName: '한국어',
    englishName: 'Korean',
    vietnameseName: 'Tiếng Hàn',
  ),
  SupportedLanguage(
    code: 'zh',
    nativeName: '中文',
    englishName: 'Chinese',
    vietnameseName: 'Tiếng Trung',
  ),
  SupportedLanguage(
    code: 'hi',
    nativeName: 'हिन्दी',
    englishName: 'Hindi',
    vietnameseName: 'Tiếng Hindi',
  ),
  SupportedLanguage(
    code: 'es',
    nativeName: 'Español',
    englishName: 'Spanish',
    vietnameseName: 'Tiếng Tây Ban Nha',
  ),
  SupportedLanguage(
    code: 'pt',
    nativeName: 'Português',
    englishName: 'Portuguese',
    vietnameseName: 'Tiếng Bồ Đào Nha',
  ),
  SupportedLanguage(
    code: 'fr',
    nativeName: 'Français',
    englishName: 'French',
    vietnameseName: 'Tiếng Pháp',
  ),
  SupportedLanguage(
    code: 'de',
    nativeName: 'Deutsch',
    englishName: 'German',
    vietnameseName: 'Tiếng Đức',
  ),
  SupportedLanguage(
    code: 'it',
    nativeName: 'Italiano',
    englishName: 'Italian',
    vietnameseName: 'Tiếng Ý',
  ),
  SupportedLanguage(
    code: 'tr',
    nativeName: 'Türkçe',
    englishName: 'Turkish',
    vietnameseName: 'Tiếng Thổ Nhĩ Kỳ',
  ),
  SupportedLanguage(
    code: 'ar',
    nativeName: 'العربية',
    englishName: 'Arabic',
    vietnameseName: 'Tiếng Ả Rập',
  ),
  SupportedLanguage(
    code: 'ru',
    nativeName: 'Русский',
    englishName: 'Russian',
    vietnameseName: 'Tiếng Nga',
  ),
];

const supportedLanguageCodes = <String>{
  'en',
  'vi',
  'id',
  'th',
  'ms',
  'fil',
  'ja',
  'ko',
  'zh',
  'hi',
  'es',
  'pt',
  'fr',
  'de',
  'it',
  'tr',
  'ar',
  'ru',
};

SupportedLanguage languageForCode(String? code) {
  return supportedLanguages.firstWhere(
    (language) => language.code == code,
    orElse: () => supportedLanguages.first,
  );
}
