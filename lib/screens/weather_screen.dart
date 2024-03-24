import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/blocs/weather/weather_event.dart';
import 'package:weather_app/blocs/weather/weather_state.dart';
import 'package:weather_app/data/weather_icons.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/widgets/autocomplete_search.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late TextEditingController _searchController;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(context),
        // actions: [
        //   Container(
        //     width: MediaQuery.of(context).size.width, // Adjust width as needed
        //     height:
        //         MediaQuery.of(context).size.height, // Adjust height as needed
        //     child: _buildSearchBar(context),
        //   ),
        // ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Container(); // Placeholder widget
          } else if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoaded) {
            return buildWeatherData(state.weatherData);
          } else if (state is WeatherError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return AutocompleteSearch(
      onCitySelected: (selectedCity) {
        setState(() {
          _selectedCity = selectedCity;
        });

        BlocProvider.of<WeatherBloc>(context).add(FetchWeather(selectedCity));
      },
      onClearPressed: () {
        setState(() {
          _selectedCity = null;
        });
        BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
      },
    );
  }

  Widget buildWeatherData(Weather weather) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.asset(
            weatherIcons[weather.mainCondition.toLowerCase()] ??
                weatherIcons['clear']!,
            width: 200,
          ),
          const SizedBox(height: 10),
          Text(
            'Temperature: ${weather.tempeture.toString()}°C',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Weather Condition: ${weather.mainCondition}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
