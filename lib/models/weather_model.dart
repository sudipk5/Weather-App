class Weather {
  final String cityName;
  final double temperature;
  final String descpription;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.descpription,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      descpription: json['weather'][0]['description'], // fixed: [0]
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      temperature: json['main']['temp'] - 273.15,
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
