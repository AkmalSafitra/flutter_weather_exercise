import 'package:flutter/material.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';

class WeatherDetailPage extends StatelessWidget {
  static const routeName = '/weatherDetailPage';

  final Weather weather;

  const WeatherDetailPage({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 240,
              child: Hero(
                tag: weather.weather[0].icon,
                child: Image.network(
                    "http://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png",
                    width: 50),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
