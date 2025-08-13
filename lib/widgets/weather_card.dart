import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  String getAnimationPath() {
    if (weather.descpription.toLowerCase().contains('rain')) {
      return 'assets/rain.json';
    } else if (weather.descpription.toLowerCase().contains('clear')) {
      return 'assets/sunny.json';
    } else {
      return 'assets/cloudy.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            getAnimationPath(),
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 10),
          Text(
            '${weather.temperature.toStringAsFixed(1)}°C',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            weather.descpription,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Humidity: ${weather.humidity}%',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Wind: ${weather.windSpeed} m/s',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.wb_sunny_outlined, color: Colors.orange),
                  Text('Sunrise', style: TextStyle(color: Colors.white)),
                  Text(
                    formatTime(weather.sunrise),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.nights_stay_outlined,
                      color: Colors.purpleAccent),
                  Text('Sunset', style: TextStyle(color: Colors.white)),
                  Text(
                    formatTime(weather.sunset),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
