class Weather {
  final double temperature;
  final double windspeed;

  Weather({required this.temperature, required this.windspeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current_weather']['temperature'].toDouble(),
      windspeed: json['current_weather']['windspeed'].toDouble(),
    );
  }
}
