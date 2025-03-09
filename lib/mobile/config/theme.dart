// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: wPrimaryBgScreen,
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // pageTransitionsTheme: const PageTransitionsTheme(builders: {
    //   TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    // }),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: wPrimaryBgScreen,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarTextStyle:
        const TextTheme(
          headlineSmall: TextStyle(color: wPrimaryText, fontSize: 16),
        ).bodyLarge,
    titleTextStyle:
        const TextTheme(
          headlineSmall: TextStyle(color: wPrimaryBgScreen, fontSize: 16),
        ).bodyLarge,
  );
}

InputDecorationTheme inputDecorationTheme() {
  double width = 0;
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android) {
    width = Platform.isIOS ? 0.5 : 1.0;
  } else if (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows) {
    // Some desktop specific code there
  } else {
    // Some web specific code there
  }

  /// Use UnderlineInputBorder
  UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: wPrimaryText, width: width),
  );
  UnderlineInputBorder underlineInputBorderEnabled = UnderlineInputBorder(
    borderSide: BorderSide(color: wPrimaryText.withOpacity(0.7), width: width),
  );
  return InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.grey),
    prefixStyle: const TextStyle(color: Colors.red),
    suffixStyle: const TextStyle(color: wPrimaryText),
    fillColor: wPrimaryText,
    border: underlineInputBorder,
    focusedBorder: underlineInputBorder,
    enabledBorder: underlineInputBorderEnabled,
    disabledBorder: underlineInputBorderEnabled,
  );
}
