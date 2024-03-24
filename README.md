# Weather App

A simple weather app built with Flutter to display current weather information for different cities.

## Features

- View current weather information for a specific city.
- Autocomplete search functionality to find cities easily.
- Clear button to reset the search input and suggestions.

## Technologies Used

- Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- Bloc Library: A predictable state management library for Dart and Flutter that helps implement the BLoC (Business Logic Component) architectural pattern.


## Installation

1. Clone the repository to your local machine
2. Navigate to the project directory
3. Install dependencies:
    ``` flutter pub get ```
4. Run the app: 
    ``` flutter run ```


## Usage

- Upon launching the app, you'll see a search bar at the top.
- Start typing the name of a city to see autocomplete suggestions.
- Select a city from the suggestions to view its current weather.
- To clear the search input and suggestions, press the clear button next to the search bar.

## Dependencies

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): State management library for Flutter applications.
- [weather_service](https://pub.dev/packages/weather_service): A service to fetch weather data from an API.
- [http](https://pub.dev/packages/http): HTTP client for making API requests.
- [autocomplete_textfield](https://pub.dev/packages/autocomplete_textfield): A text field widget with autocomplete suggestions.

## Credits

- This app was created by KNOUZ Oussama.

## License

This project is licensed under the [MIT License](LICENSE).
