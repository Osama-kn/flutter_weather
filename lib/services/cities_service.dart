import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CityService {
  static String ninjasApiKey = dotenv.env['NINJAS_API_KEY']!;

  static Future<List<String>> fetchCities(String city) async {
    if (city.length < 3) return List<String>.empty();
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/city?name=$city'),
      headers: {'X-Api-Key': ninjasApiKey},
    );
    if (response.statusCode == 200) {
      // print(response.body);
      final data = json.decode(response.body);
      final List<String> cities =
          List<String>.from(data.map((city) => city['name']));

      return cities;
    } else {
      throw Exception('Failed to fetch cities');
    }
  }
}
