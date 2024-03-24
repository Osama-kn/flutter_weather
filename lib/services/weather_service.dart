import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  static const OPEN_CAGE_URL = "https://api.opencagedata.com/geocode/v1/json";

  static const OPEN_WEATHER_URL =
      "https://api.openweathermap.org/data/2.5/weather";

  final String openCageApiKey = dotenv.env['OPEN_CAGE_API_KEY']!;
  final String openWeatherMapApiKey = dotenv.env['OPEN_WEATHER_MAP_API_KEY']!;

  WeatherService();

  Future<Weather> getWeather(cityName) async {
    final response = await http.get(Uri.parse(
        '$OPEN_WEATHER_URL?q=$cityName&appid=$openWeatherMapApiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }

    throw Exception("Failed to load weather data");
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String? city;

    if (kIsWeb) {
      // Web-specific geocoding logic using OpenCage Geocoding API
      final url =
          '$OPEN_CAGE_URL?key=$openCageApiKey&q=${position.latitude}+${position.longitude}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        city = data['results'][0]['components']['city'] ?? '';
      } else {
        city = 'Unknown';
      }
    } else {
      // Mobile geocoding logic
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      city = placemarks.isNotEmpty ? placemarks[0].locality.toString() : '';
    }

    return city ?? '';
  }

  Future<List<String>> getCitySuggestions(String query) async {
    return [
      "Paris",
      "New York",
      "Los Angeles",
      "Chicago",
      "Houston",
    ];
  }
}
