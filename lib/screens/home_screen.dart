import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final weather = await _weatherServices.featchWeather(_controller.text.trim());
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgGradient = _weather != null &&
            _weather!.descpription.toLowerCase().contains('rain')
        ? const LinearGradient(
            colors: [Colors.blueGrey, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        : _weather != null &&
                _weather!.descpription.toLowerCase().contains('clear')
            ? const LinearGradient(
                colors: [Colors.orangeAccent, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : const LinearGradient(
                colors: [Colors.lightBlueAccent, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  '🌤 Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.location_city, color: Colors.white),
                    filled: true,
                    // ignore: deprecated_member_use
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _getWeather(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Weather',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                const SizedBox(height: 20),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
