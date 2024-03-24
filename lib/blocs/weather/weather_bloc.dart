import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/services/opencage_data_service.dart';
import 'package:weather_app/services/openweathermap_service.dart';

// import 'package:your_weather_data_model.dart'; // Import your weather data model
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final OpenWeatherMapService openWeatherMapService = OpenWeatherMapService();
  final OpenCageDataService openCageDataService = OpenCageDataService();

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // if (event is FetchWeather) {
    //   yield* _mapFetchWeatherToState();
    // } else if (event is RefreshWeather) {
    //   yield* _mapRefreshWeatherToState();
    // } else if (event is SearchWeather) {
    //   yield* _mapSearchWeatherToState(event.location);
    // }
  }

  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    try {
      print(event.city ?? 'NONE');
      final city = event.city ?? await openCageDataService.getCurrentCity();
      final weather = await openWeatherMapService.getWeatherData(city);
      emit(WeatherLoaded(weather));
    } catch (error) {
      emit(WeatherError('Failed to fetch weather data: $error'));
    }
  }

  Stream<WeatherState> _mapFetchWeatherToState() async* {
    // Logic to fetch weather data
    try {
      // Emit appropriate states like WeatherLoading, WeatherLoaded, or WeatherError
      final city = await openCageDataService.getCurrentCity();
      final weather = await openWeatherMapService
          .getWeatherData(city); // Call your weather service to get data
      yield WeatherLoaded(weather);
    } catch (error) {
      emit(WeatherError('Failed to fetch weather data: $error'));
    }
  }

  Stream<WeatherState> _mapRefreshWeatherToState() async* {
    // Logic to refresh weather data
  }

  Stream<WeatherState> _mapSearchWeatherToState(String location) async* {
    // Logic to search weather data for a specific location
  }
}
