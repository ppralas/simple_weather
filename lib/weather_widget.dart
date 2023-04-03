import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httpweather/weather_screen.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  TextEditingController searchController = TextEditingController();
  String query = '';

  late Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData('Zagreb');
  }

  Future<void> fetchWeatherData(String query) async {
    final response = await http.get(
        Uri.parse(
            'https://weatherapi-com.p.rapidapi.com/current.json?q=$query'),
        headers: {
          'X-RapidAPI-Key':
              '7d72957525msh0a3476e8238d3c2p12c493jsne6832b801c90',
        });
    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Search City',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (String value) {
            setState(() {
              query = value;
            });
            fetchWeatherData(query);
          },
        ),
      ),
      body: WeatherScreen(weatherData: weatherData),
    );
  }
}
