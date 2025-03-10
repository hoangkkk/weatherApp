import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';

void main() {
  test('Weather model parses JSON correctly', () {
    final json = {
      "current": {
        "dt": 1741588060,
        "temp": 282.22,
        "feels_like": 282.22,
      },
      "daily": [
        {
            "dt": 1741550400,
            "temp": {
                "day": 286.86,
                "min": 282.22,
                "max": 287.25,
                "night": 282.22,
                "eve": 284.32,
                "morn": 282.8
            },
            "feels_like": {
                "day": 285.7,
                "night": 281.47,
                "eve": 283.32,
                "morn": 282.8
            },
        },
        {
            "dt": 1741636800,
            "temp": {
                "day": 286.55,
                "min": 281.95,
                "max": 288.01,
                "night": 284.05,
                "eve": 286.33,
                "morn": 281.95
            },

        },
        {
            "dt": 1741723200,
            "temp": {
                "day": 287,
                "min": 282.99,
                "max": 287,
                "night": 284.56,
                "eve": 285.01,
                "morn": 282.99
            },

        },
        {
            "dt": 1741809600,
            "temp": {
                "day": 285.46,
                "min": 282.09,
                "max": 285.99,
                "night": 282.47,
                "eve": 282.9,
                "morn": 284.25
            },

        },
        {
            "dt": 1741896000,
            "temp": {
                "day": 283.9,
                "min": 281.56,
                "max": 283.9,
                "night": 282.15,
                "eve": 282.36,
                "morn": 281.56
            },
        },
        {
            "dt": 1741982400,
            "temp": {
                "day": 281.2,
                "min": 281.2,
                "max": 282.87,
                "night": 282.87,
                "eve": 281.94,
                "morn": 281.6
            },

        },
        {
            "dt": 1742068800,
            "temp": {
                "day": 284.83,
                "min": 282.03,
                "max": 284.83,
                "night": 283.85,
                "eve": 284.02,
                "morn": 282.17
            },
        },
        {
            "dt": 1742155200,
            "temp": {
                "day": 284.82,
                "min": 281.99,
                "max": 284.82,
                "night": 281.99,
                "eve": 283.25,
                "morn": 283.11
            },
        }
    ]
    }; // 10°C
    final weather = DataViewController.fromJson(json);
    expect(weather.currentTemperature?.temp, closeTo(10, 1));
    expect(weather.currentTemperature?.dt, "Monday");
  });
}
