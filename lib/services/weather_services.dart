import 'package:weather/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherServices {
  final String apiKey = 'd9f9ac6c7421eb1bee6a8c383ba3d042';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'
    );

    final response = await http.get(url);
    print("Request URL: $url");
    print("Status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Failed to load weather data');
    }
  }
}