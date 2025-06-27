class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final String description;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.description,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'] - 273.15,
        humidity: json['main']['humidity'],
        description: json['weather'][0]['description'],
        windSpeed: json['wind']['speed'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset'],
    );
  }
}