import 'package:weather_app/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weatherData;

  WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
