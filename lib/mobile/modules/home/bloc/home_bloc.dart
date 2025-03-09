import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather_app/mobile/base/base_bloc.dart';
import 'package:weather_app/mobile/base/base_event.dart';
import 'package:weather_app/mobile/modules/home/event/home_event.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/modules/home/repository/home_repository.dart';
import 'package:geocoding/geocoding.dart';

class HomeBloc extends BaseBloc {
  // Stream controller
  final _weatherForecastDataController = BehaviorSubject<DataViewController>();

  Stream<DataViewController> get weatherForecastDataStream =>
      _weatherForecastDataController.stream;
  Sink<DataViewController> get weatherForecastDataSink =>
      _weatherForecastDataController.sink;

  HomeBloc() {
    getCurrentTemperature();
  }

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

  getCurrentTemperature() async {
    // try {
      final position = await getCurrentPosition();
      List<Placemark> placemarks = await getCityName(
        position.latitude,
        position.longitude,
      );
      final response = await HomeRepository().getSummaryReport(
        WeatherModelRequest(
          lat: position.latitude,
          long: position.longitude,
          appid: "14ef67ad897384289657e9e4174a18e9",
        ),
      );
      if (response != null) {
        // Map data to DataViewController
        weatherForecastDataSink.add(
          DataViewController(
            cityName: placemarks[0].name,
            currentTemperature: response.currentTemperature,
            temperatureForecasts: response.temperatureForecasts,
          ),
        );
      }
    // } catch (e) {
    //   _weatherForecastDataController.sink.addError(e.toString());
    // }
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
