import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a city name")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try{
      final weather = await _weatherServices.fetchWeather(_controller.text.trim());
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    }catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: _weather !=null && _weather!.description.toLowerCase().contains('rain')?
              LinearGradient(
                  colors:[Colors.grey, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
              : _weather !=null && _weather!.description.toLowerCase().contains('clear')?
              LinearGradient(
                colors: [Colors.orangeAccent, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
              : LinearGradient(
              colors: [Colors.grey, Colors.lightBlueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
              )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                
                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 25,),

                TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter Your City Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color.fromARGB(110, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                
                ElevatedButton(
                  onPressed: _getWeather,
                  child: Text(
                    "Get Weather",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(209, 125, 155, 170),
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                if (_isLoading)
                  Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(color: Colors.white,),),

                if (_weather != null)
                  WeatherCard(weather: _weather!),

              ],
            ),
          ),
        ),
      ),
    );
  }

}