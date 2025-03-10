import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/mobile/modules/home/model/home_model.dart';
import 'package:weather_app/mobile/modules/home/repository/home_repository.dart';
import 'mocks.mocks.dart';

class WeatherService {
  final HomeRepository repository;

  WeatherService(this.repository);

  Future<DataViewController> getTemperatureForecast(
    double lat,
    double lon,
  ) async {
    final response = await repository.getSummaryReport(
      WeatherModelRequest(
        lat: lat,
        long: lon,
        appid: dotenv.env['key_weather_api'],
      ),
    );
    return response;
  }
}

void main() {
  late MockHomeRepository mockHomeRepository;
  late WeatherService weatherService;

  final mockResponse = DataViewController.fromJson({
    'current': {'dt': 1641234567, 'temp': 283.15},
    'daily': [
      {
        'dt': 1641320967,
        'temp': {'day': 285.15},
      },
      {
        'dt': 1641407367,
        'temp': {'day': 287.15},
      },
      {
        'dt': 1641493767,
        'temp': {'day': 289.15},
      },
      {
        'dt': 1641580167,
        'temp': {'day': 291.15},
      },
    ],
  });

  setUp(() async {
    // Load environment variables (mock the .env file)
    dotenv.testLoad(fileInput: 'key_weather_api=test_api_key');

    // Initialize mocks
    mockHomeRepository = MockHomeRepository();
    weatherService = WeatherService(mockHomeRepository);
  });

  group('getTemperatureForecast', () {
    test('returns forecast data on successful API call', () async {
      // Arrange: Mock the repository to return a successful response
      when(
        mockHomeRepository.getSummaryReport(any),
      ).thenAnswer((_) async => mockResponse);

      // // Act: Call the function with sample lat/lon
      final result = await weatherService.getTemperatureForecast(
        51.5074,
        -0.1278,
      );
      // Assert: Check if the result matches the mock response
      expect(result, mockResponse);

      // Verify: Ensure the repository was called with the correct arguments
      verify(mockHomeRepository.getSummaryReport(any)).called(1);
    });

    test('throws exception on API failure', () async {
      // Arrange: Mock the repository to throw an exception
      when(
        mockHomeRepository.getSummaryReport(any),
      ).thenThrow(Exception('API call failed'));
      await expectLater(
        () async =>
            await weatherService.getTemperatureForecast(51.5074, -0.1278),
        throwsException,
      );
      // Verify: Ensure the repository was called with the correct arguments
      verify(mockHomeRepository.getSummaryReport(any)).called(1);
    });
  });
}
