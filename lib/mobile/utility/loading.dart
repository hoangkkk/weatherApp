// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather_app/mobile/config/global_key.dart';
import 'package:weather_app/mobile/constants/constant.dart';

class LoadingDialog {
  static Future showLoadingDialog(
      {String msg = '', BuildContext? context}) async {
    showDialog(
      context: context ?? GlobalVariable.navState.currentContext!,
      barrierDismissible: false,
      builder: (context) => msg.isNotEmpty
          ? Dialog(
              child: Container(
                color: Colors.white,
                height: 96,
                width: 96,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(wPrimaryLoadingColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        msg,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 96,
                  width: 96,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(wPrimaryLoadingColor),
                  ),
                ),
              ],
            ),
    );
  }

  static Future hideLoadingDialog(
      {BuildContext? context, int duration = 500}) async {
    await Future.delayed(Duration(milliseconds: duration));
    Navigator.of(context ?? GlobalVariable.navState.currentContext!)
        .pop(LoadingDialog);
  }
}
