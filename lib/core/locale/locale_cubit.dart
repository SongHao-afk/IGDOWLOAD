import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'supported_language.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    emit(_localeFromCode(prefs.getString(AppConstants.prefsLocaleCode)));
  }

  Future<void> changeLocale(Locale locale) async {
    final nextLocale = _localeFromCode(locale.languageCode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppConstants.prefsLocaleCode,
      nextLocale.languageCode,
    );
    emit(nextLocale);
  }

  Locale _localeFromCode(String? code) {
    return languageForCode(code).locale;
  }
}
