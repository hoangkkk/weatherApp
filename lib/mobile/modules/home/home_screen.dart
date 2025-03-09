// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';
import 'package:weather_app/mobile/modules/home/bloc/home_bloc.dart';
import 'package:weather_app/mobile/modules/home/widgets/TemperatureWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bloc = HomeBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      //
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: wPrimaryBgScreen,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: StreamBuilder(
          stream: bloc.weatherForecastDataStream,
          builder: (context, snapshot) {
            return Column(
              children: [
                // Current Weather
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data?.currentTemperature?.temp ?? 0}°',
                        style: TextStyle(
                          color: wPrimaryText,
                          fontSize: 96.0,
                          fontFamily: 'Roboto-black',
                          height: 1.2,
                        ),
                      ),
                      Text(
                        snapshot.data?.cityName ?? 'Unknown',
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

                // Forecast
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: snapshot.data?.temperatureForecasts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final forecast =
                          snapshot.data?.temperatureForecasts?[index];
                      return TemperatureWidget(
                        day: forecast!.dt.toString(),
                        temp: forecast.temp.toString(),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
