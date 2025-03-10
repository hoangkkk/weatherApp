import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/modules/home/widgets/temperature_widget.dart';

class WeatherForecastComponent extends StatelessWidget {
  final DataViewController data;
  const WeatherForecastComponent({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current Weather
        Container(
          padding: EdgeInsets.only(bottom: 62),
          decoration: BoxDecoration(
            color: wPrimaryBgScreenColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                offset: Offset(
                  0,
                  2,
                ),
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${data.currentTemperature?.temp ?? 0}°',
                  style: TextStyle(
                    color: wPrimaryTextColor,
                    fontSize: 96.0,
                    fontFamily: 'Roboto-black',
                    height: 1.2,
                  ),
                ),
                Text(
                  data.cityName ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Roboto-Thin',
                    color: Color(0xFF556799),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Forecast 4 days
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: data.temperatureForecasts?.length ?? 0,
            itemBuilder: (context, index) {
              final forecast = data.temperatureForecasts?[index];
              return TemperatureWidget(
                day: forecast!.dt.toString(),
                temp: forecast.temp.toString(),
              );
            },
          ),
        ),
      ],
    );
  }
}
