
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:weather/models/weather_model.dart';

class WeatherServices {
  final String apikey = '246118ffa52393461de5031ec4430d2b';

  Future<Weather> featchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey',
    );

    final response = await http.get(url);


    if(response.statusCode ==200){
      return Weather.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }







  }
}

