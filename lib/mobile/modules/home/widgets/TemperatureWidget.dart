import 'package:flutter/widgets.dart';
import 'package:weather_app/mobile/constants/constant.dart';

class TemperatureWidget extends StatelessWidget {
  final String day;
  final String temp;

  const TemperatureWidget({super.key, required this.day, required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: wPrimaryText,
              fontSize: 16.0,
              fontFamily: 'Roboto-Regular',
              height: 1.2,
            ),
          ),
          Text(
            "$temp C",
            style: TextStyle(
              color: wPrimaryText,
              fontSize: 16.0,
              fontFamily: 'Roboto-Regular',
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
