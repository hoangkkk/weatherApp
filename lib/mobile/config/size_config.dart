// ignore_for_file: unnecessary_import

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;

class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = false;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      // isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    // textMultiplier = _blockHeight;
    // textMultiplier = _blockWidth;
    textMultiplier = Platform.isIOS ? 15.5 : 16;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    // print('SizeConfig: ${SizeConfig.textMultiplier}');
  }
}

// Get the scale height as per screen size
double getScaleScreenHeight(double iHeight) {
  return iHeight * SizeConfig.heightMultiplier;
}

// Get the scale width as per screen size
double getScaleScreenWidth(double iWidth) {
  //     (SizeConfig.isPortrait
  //         ? SizeConfig.widthMultiplier
  //         : SizeConfig.heightMultiplier));
  return iWidth *
      (SizeConfig.isPortrait
          ? SizeConfig.widthMultiplier
          : SizeConfig.heightMultiplier);
}

double getScaleImageSize(double iWidth) {
  return iWidth * SizeConfig.imageSizeMultiplier;
}

double getScaleTextSize(double iHeight) {
  return iHeight * SizeConfig.textMultiplier;
}
