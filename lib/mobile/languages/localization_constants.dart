// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:weather_app/mobile/config/global_key.dart';
import 'package:weather_app/mobile/constants/key.dart';
import 'package:weather_app/mobile/languages/custom_localization.dart';
import 'package:weather_app/mobile/storage/custom_shared_preferences.dart';

String getTranslated(String key) {
  return CustomLocalizations.of(GlobalVariable.navState.currentContext!)!
      .getTranslateValue(key);
}

Locale _locale(String languageCode) {
  Locale _tmp;
  switch (languageCode) {
    case KeyStorage.VIETNAM:
      _tmp = Locale(languageCode, '');
      break;
    case KeyStorage.ENGLISH:
      _tmp = Locale(languageCode, '');
      break;
    default:
      _tmp = Locale(KeyStorage.VIETNAM, '');
  }
  return _tmp;
}

Future<Locale> setLocale(String languageCode) async {
  languageCode = languageCode.isNotEmpty ? languageCode : KeyStorage.VIETNAM;
  LocalStorageService.setString(KeyStorage.LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = LocalStorageService.getString(KeyStorage.LANGUAGE_CODE);
  languageCode = languageCode.isNotEmpty ? languageCode : KeyStorage.VIETNAM;
  return _locale(languageCode);
}
