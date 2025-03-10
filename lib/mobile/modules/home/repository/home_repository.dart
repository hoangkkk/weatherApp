import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/services/call_api.dart';

class HomeRepository {
  String getCurentTemperature =
      'https://api.openweathermap.org/data/3.0/onecall';

  Future<DataViewController> getSummaryReport(WeatherModelRequest data) async {
    Uri uri = Uri(queryParameters: data.toJson());
    dynamic response = await CallAPI.fetchData("$getCurentTemperature$uri");
    return DataViewController.fromJson(response);
  }
}
