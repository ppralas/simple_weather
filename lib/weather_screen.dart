import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
    required this.weatherData,
  });

  final Map<String, dynamic> weatherData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${weatherData['location']?['name']}, ${weatherData['location']?['country']}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 36),
          if (weatherData['current']?['condition'] != null)
            Text(
              '${weatherData['current']['condition']['text']}',
              style: const TextStyle(fontSize: 40),
            ),
          const SizedBox(height: 16),
          if (weatherData['current']?['condition'] != null)
            Image.network(
              'https:${weatherData['current']['condition']['icon']}',
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          const SizedBox(height: 16),
          if (weatherData['current'] != null)
            Text(
              'Temperature: ${weatherData['current']['temp_c']}°C',
              style: const TextStyle(fontSize: 20),
            ),
          const SizedBox(height: 16),
          Text(
            'Local Time: ${weatherData['location']?['localtime']}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
