import 'package:weather_app/mobile/helpers/date_format.dart';

class WeatherModelRequest {
  double lat;
  double long;
  String? appid;

  WeatherModelRequest({required this.long, required this.lat, this.appid});

  String mapToUrl(Map<String, dynamic> data) {
    Uri uri = Uri(queryParameters: data);
    return uri.toString();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "lat": lat.toString(),
      "lon": long.toString(),
      "appid": appid,
    };
    return data;
  }
}

class DataViewController {
  String? cityName;
  TemperatureModel? currentTemperature;
  List<TemperatureModel>? temperatureForecasts = [];
  DataViewController({
    this.currentTemperature,
    this.temperatureForecasts,
    this.cityName,
  });
  factory DataViewController.fromJson(Map<String, dynamic> json) {
    // Filter out the current day
    List temperatureForecasts =
        (json['daily'] as List).map((e) => e).where((forecast) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(forecast["dt"].toString()) * 1000,
          );
          final currentdate = DateTime.fromMillisecondsSinceEpoch(
            int.parse(json['current']["dt"].toString()) * 1000,
          );
          bool check = DateTimeHelper.isSameDay(date, currentdate);
          return !check;
        }).toList();

    return DataViewController(
      currentTemperature: TemperatureModel.fromJson(json['current']),
      temperatureForecasts:
          temperatureForecasts
              .map((e) => TemperatureModel.fromJson(e))
              .toList(),
    );
  }
}

class TemperatureModel {
  String dt;
  int temp;
  TemperatureModel({required this.dt, required this.temp});

  factory TemperatureModel.fromJson(Map<String, dynamic> json) {
    double temp = 0;
    final date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(json['dt'].toString()) * 1000,
    );

    if (json['temp'] is double) {
      temp = json['temp'] - 273.15; // Kelvin to Celsius
    } else if (json['temp'] is Map) {
      // Calculate average temperature
      final tempMap = json['temp'] as Map<String, dynamic>;
      final sumTemp = tempMap.values.fold(0.0, (sum, item) => sum + item);
      temp = (sumTemp / tempMap.length) - 273.15; // Kelvin to Celsius
    }
    return TemperatureModel(
      dt: DateTimeHelper.getWeekday(date),
      temp: temp.round(),
    );
  }
}
