import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    const MaterialApp(
      title: 'Weather App',
      home: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  WeatherAppState createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  String _temperature = '';
  String _weatherCondition = '';
  String _humidity = '';

  Future<void> _fetchWeatherData() async {
    final String city = _cityController.text.trim();
    print('Requesting weather data');
    try {
      final response = await http
          .get(Uri.parse('http://192.168.0.133:5000/weather?city=$city'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = data['current']['temp_c'].toString();
          _weatherCondition = data['current']['condition']['text'];
          _humidity = data['current']['humidity'].toString();
        });
      } else {
        setState(() {
          _temperature = 'N/A';
          _weatherCondition = 'Error';
          _humidity = 'N/A';
        });
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        _temperature = 'N/A';
        _weatherCondition = 'Error: Failed to fetch weather data';
        _humidity = 'N/A';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: const Color.fromARGB(255, 108, 2, 179),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter a city name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 108, 2, 179),
              ),
              onPressed: _fetchWeatherData,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Temperature: $_temperature',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Weather Condition: $_weatherCondition',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Humidity: $_humidity',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
