# weather_app

A Flutter application that displays current temperature and a 4-day forecast using OpenWeatherMap API.

## Technical Approach

- **Architecture**: 
    + MVC (Model-View-Controller): Organized into `mobile/modules`, `modules/Bloc`, etc., 
    + BLoC: Stream-based, Separates UI from business logic for scalability.

- **Libraries**:
  - `dio`: For API requests
  - `geolocator`: For location services
  - `flutter_dotenv`: This is useful when you need to store sensitive information like API keys, URLs, or other configurations that you don't want to make public in your source code. 
  - `rxdart`: 
    + Manage and manipulate streams of data (like weather updates in your app).
    + Combine, transform, or filter data before it reaches the UI.
    + Write cleaner, more maintainable asynchronous code.
  - `intl`: For date formatting
- **Testing**: 
  - Unit tests with Mockito, build_runner to create mock objects for test. see more: https://docs.flutter.dev/cookbook/testing/unit/mocking

## Setup
1. Get an API key from [OpenWeatherMap](https://openweathermap.org/)
3. Run `flutter pub get`
4. Run `flutter run`

## Git History
- Commit first app
- Config file env, error handling, loading page
- Commit implement simple animations and create simple unit test ( model, bloc )
- Commit write widget test
- Commit README file
- see more: https://github.com/hoangkkk/weatherApp