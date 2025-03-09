// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';
import 'package:weather_app/mobile/modules/home/bloc/weather_forecast_bloc.dart';
import 'package:weather_app/mobile/modules/home/component/error_component.dart';
import 'package:weather_app/mobile/modules/home/component/weather_forecast_component.dart';
import 'package:weather_app/mobile/modules/home/event/home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var bloc = WeatherForecastBloc();
  @override
  void initState() {
    bloc.event.add(GetTemperatureEvent());
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
    return StreamBuilder(
      stream: bloc.weatherForecastDataStream,
      builder: (context, snapshot) {
        Color backgroundColor =
            snapshot.hasError ? wPrimaryBgFailureColor : wPrimaryBgScreenColor;
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(backgroundColor: backgroundColor),
          body: SafeArea(
            child:
                snapshot.hasError
                    ? ErrorComponent(
                      update: (value) {
                        bloc.event.add(GetTemperatureEvent());
                      },
                    )
                    : (snapshot.hasData
                        ? WeatherForecastComponent(data: snapshot.data)
                        : SizedBox()),
          ),
        );
      },
    );
  }
}
