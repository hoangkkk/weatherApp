import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/services/call_api.dart';

class HomeRepository {
  String getCurentTemperature =
      'https://api.openweathermap.org/data/3.0/onecall';

  Future<DataViewController?> getSummaryReport(
    WeatherModelRequest data,
  ) async {
    dynamic response;
    // try {
      Uri uri = Uri(queryParameters: data.toJson());
      response = await CallAPI.fetchData("$getCurentTemperature$uri");
      return DataViewController.fromJson(response);
    // } catch (e) {
    //   print("e: $e"); 
    //   return null;
    // }
  }
}
