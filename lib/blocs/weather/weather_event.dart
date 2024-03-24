abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String? city; // Define city as a parameter
  FetchWeather([this.city]);
}

class RefreshWeather extends WeatherEvent {}

class SearchWeather extends WeatherEvent {
  final String location;

  SearchWeather(this.location);
}
