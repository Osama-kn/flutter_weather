import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/opencage_data_service.dart';
import 'package:weather_app/services/openweathermap_service.dart';

void main() async {
  await dotenv.load(
      fileName: '.env'); // Load environment variables from .env file

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WeatherBloc(),
        child: const WeatherScreen(),
      ),
    );
  }
}
