import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenCageDataService {
  final String openCageApiKey = dotenv.env['OPEN_CAGE_API_KEY']!;
  static const openCageUrl = "https://api.opencagedata.com/geocode/v1/json";

  OpenCageDataService();

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
          '$openCageUrl?key=$openCageApiKey&q=${position.latitude}+${position.longitude}';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        city = data['results'][0]['components']['city'] ?? data['results'][0]['components']['country'] ?? '';
        print(city);
      } else {
         throw Exception('Failed to load location data');
      }
    } else {
      // Mobile geocoding logic
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      city = placemarks.isNotEmpty ? placemarks[0].locality.toString() : '';
    }

    return city ?? '';
  }
}
