import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class OpenWeatherMapService {
  final String openWeatherMapApiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY']!;
  static const openWeatherUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  OpenWeatherMapService();

  Future<Weather> getWeatherData(String cityName) async {
    
    final response = await http.get(Uri.parse(
        '$openWeatherUrl?q=$cityName&appid=$openWeatherMapApiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load weather data");
  }
}
