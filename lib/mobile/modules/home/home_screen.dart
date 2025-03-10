// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:weather_app/mobile/constants/constant.dart';
import 'package:weather_app/mobile/modules/home/bloc/weather_forecast_bloc.dart';
import 'package:weather_app/mobile/modules/home/component/error_component.dart';
import 'package:weather_app/mobile/modules/home/component/weather_forecast_component.dart';
import 'package:weather_app/mobile/modules/home/event/home_event.dart';
import 'package:weather_app/mobile/utility/fade_up_animation.dart';

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
                      retry: (value) {
                        bloc.weatherForecastDataSink.add(null);
                        bloc.event.add(GetTemperatureEvent());
                      },
                    )
                    : (snapshot.hasData
                        ? EFadeUpAnimation(
                          child: WeatherForecastComponent(data: snapshot.data),
                        )
                        : Center(
                          child: SizedBox(
                            height: 96,
                            width: 96,
                            child: CircularProgressIndicator(
                              strokeWidth: 5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                wPrimaryLoadingColor,
                              ),
                            ),
                          ),
                        )),
          ),
        );
      },
    );
  }
}
