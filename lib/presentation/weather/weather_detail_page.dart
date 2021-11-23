import 'package:flutter/material.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';

class WeatherDetailPage extends StatelessWidget {
  static const routeName = '/weatherDetailPage';

  final Weather weather;

  const WeatherDetailPage({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          weather.name,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              child: Hero(
                tag: weather.weather[0].icon,
                child: Image.network(
                  "http://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("City"),
                  Table(
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          const Text('Name: '),
                          Text(weather.name),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          const Text('Weather:'),
                          Text(weather.weather[0].main +
                              ", " +
                              weather.weather[0].description),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          const Text('Temperature:'),
                          Text(weather.main.temp.toString() + " °F"),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          const Text('Humidity:'),
                          Text(weather.main.humidity.toString()),
                        ],
                      ),
                    ],
                  ),

                  // Divider(color: Colors.grey),
                  // Text(weather.timezone.toString()),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Wind"),
                  Table(
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          const Text('Wind Speed: '),
                          Text(weather.wind.speed.toString() + " mph"),
                        ],
                      ),
                      TableRow(
                        children: <Widget>[
                          const Text('Wind Degree: '),
                          Text(weather.wind.deg.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
