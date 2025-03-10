import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/mobile/base/base_bloc.dart';
import 'package:weather_app/mobile/base/base_event.dart';
import 'package:weather_app/mobile/modules/home/event/home_event.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/modules/home/repository/home_repository.dart';
import 'package:geocoding/geocoding.dart';

class WeatherForecastBloc extends BaseBloc {
  // Stream controller
  final _weatherForecastDataController = BehaviorSubject<DataViewController?>();

  Stream<DataViewController?> get weatherForecastDataStream =>
      _weatherForecastDataController.stream;
  Sink<DataViewController?> get weatherForecastDataSink =>
      _weatherForecastDataController.sink;

  @override
  void dispathEvent(BaseEvent event) {
    if (event is GetTemperatureEvent) {
      getCurrentTemperature();
    }
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception('Location services are disabled.');

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  getTemperatureForecast(double lat, double lon) async {
    final response = await HomeRepository().getSummaryReport(
      WeatherModelRequest(
        lat: lat,
        long: lon,
        appid: dotenv.env['key_weather_api'], // API Key
      ),
    );
    return response;
  }

  getCurrentTemperature() async {
    try {
      DataViewController data = DataViewController();
      final position = await getCurrentPosition();
      List<Placemark> placemarks = await getCityName(
        position.latitude,
        position.longitude,
      );
      final response = await getTemperatureForecast(position.latitude, position.longitude);
      data = DataViewController(
        cityName: placemarks.first.subAdministrativeArea,
        currentTemperature: response.currentTemperature,
        temperatureForecasts: response.temperatureForecasts,
      );
      // Map data to DataViewController
      weatherForecastDataSink.add(data);
    } catch (e) {
      _weatherForecastDataController.sink.addError(e);
    }
  }

  Future<List<Placemark>> getCityName(double lat, double lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    return placemarks;
  }

  @override
  void dispose() {
    _weatherForecastDataController.close();
    super.dispose();
  }
}
