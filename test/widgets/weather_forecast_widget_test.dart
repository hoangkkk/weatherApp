import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/mobile/modules/home/bloc/weather_forecast_bloc.dart';
import 'package:weather_app/mobile/modules/home/home_screen.dart';
import 'package:weather_app/mobile/modules/home/component/weather_forecast_component.dart';
import 'package:weather_app/mobile/modules/home/component/error_component.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';

void main() {
  // Test group for HomeScreen
  group('HomeScreen Tests', () {
    testWidgets('HomeScreen shows loading state initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('HomeScreen shows error component when stream has error', (
      WidgetTester tester,
    ) async {
      final bloc = WeatherForecastBloc();
      await tester.pumpWidget(MaterialApp(home: HomeScreen(bloc: bloc)));
      bloc.weatherForecaseSinkError(Exception('Test error'));
      await tester.pump(Duration.zero);

      expectLater(find.byType(ErrorComponent), findsOneWidget);
    });
  });

  // Test group for WeatherForecastComponent
  group('WeatherForecastComponent Tests', () {
    testWidgets(
      'WeatherForecastComponent displays current temperature and city',
      (WidgetTester tester) async {
        final testData = DataViewController(
          currentTemperature: TemperatureModel(temp: 25, dt: 'Satuday'),
          cityName: 'Test City',
          temperatureForecasts: [
            TemperatureModel(dt: 'Monday', temp: 26),
            TemperatureModel(dt: 'Tuesday', temp: 27),
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: WeatherForecastComponent(data: testData)),
          ),
        );

        expect(find.text('25°'), findsOneWidget);
        expect(find.text('Test City'), findsOneWidget);
        expect(find.text('Monday'), findsOneWidget);
        expect(find.text('26 C'), findsOneWidget);
      },
    );
  });

  // Test group for ErrorComponent
  group('ErrorComponent Tests', () {
    testWidgets('ErrorComponent displays retry button', (
      WidgetTester tester,
    ) async {
      bool wasCalled = false;
      void testCallback(Null _) {
        wasCalled = true;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorComponent(
              retry: (value) {
                testCallback(null);
              },
            ),
          ),
        ),
      );

      expect(find.text('RETRY'), findsOneWidget);

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      expect(wasCalled, true);
    });
  });
}
