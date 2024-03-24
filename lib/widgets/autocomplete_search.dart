import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
import 'package:weather_app/services/cities_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutocompleteSearch extends StatefulWidget {
  final Function(String) onCitySelected;
  GlobalKey<AutocompleteSearchState>? autocompleteKey;
  TextEditingController cityController = TextEditingController();
  Function()? onClearPressed; // Callback for clear button

  AutocompleteSearch({
    Key? key,
    required this.onCitySelected,
    this.autocompleteKey,
    this.onClearPressed, // Initialize onClearPressed callback
  }) : super(key: key);

  @override
  AutocompleteSearchState createState() => AutocompleteSearchState();
}

class AutocompleteSearchState extends State<AutocompleteSearch> {
  final _weatherService = WeatherService();
  late WeatherBloc _weatherBloc;
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: Autocomplete<String>(
              key: widget.autocompleteKey, // Assign the key
              // key: ValueKey(widget.local_controller),
              optionsBuilder: (TextEditingValue textEditingValue) {
                return CityService.fetchCities(
                    textEditingValue.text.toLowerCase());
              },
              onSelected: (String selectedCity) {
                // widget.controller.text = selectedCity;
                print("SELECT CITY: $selectedCity");
                widget.onCitySelected(selectedCity);
              },
              fieldViewBuilder: (BuildContext context, cityController,
                  FocusNode focusNode, VoidCallback onFieldSubmitted) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            cityController, // Use widget.cityController here
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // _getCitySuggestions(value);
                          if (value.isEmpty) {
                            widget.onClearPressed
                                ?.call(); // Call clear callback if value is empty
                          }
                        },
                        onSubmitted: (_) => onFieldSubmitted(),
                        decoration: const InputDecoration(
                          hintText: 'Enter city name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        print("Clear button pressed");
                        cityController.clear();
                        widget.cityController.clear(); // Clear the text field
                        widget.onClearPressed?.call(); // Call clear callback
                      },
                    ),
                  ],
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ]));
  }
}
