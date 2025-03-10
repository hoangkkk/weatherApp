import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';

class ErrorComponent extends StatefulWidget {
  const ErrorComponent({super.key, required this.retry});
final Function(Null) retry;
  @override
  State<ErrorComponent> createState() => _ErrorComponentState();
}

class _ErrorComponentState extends State<ErrorComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Something went wrong at our end!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: wTextWhiteColor,
            fontSize: 54.0,
            fontFamily: 'Roboto-Thin',
          ),
        ),
        SizedBox(height: 44.0),
        TextButton(
          onPressed: () {
            widget.retry(null);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            foregroundColor: Colors.white,
            backgroundColor: wPrimaryButtonBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Ensures no border radius
            ),
          ),
          child: Text(
            'Retry'.toUpperCase(),
            style: TextStyle(fontFamily: 'Roboto-Thin', color: wTextWhiteColor),
          ),
        ),
      ],
    );
  }
}
