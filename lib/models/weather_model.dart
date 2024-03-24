class Weather {
  final String cityName;
  final double tempeture;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.tempeture,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        tempeture: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}
