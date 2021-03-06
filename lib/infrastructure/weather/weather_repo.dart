import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_exercise/domain/Weather/i_weather_facade.dart';
import 'package:flutter_weather_exercise/domain/Weather/value_objects.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather_failure.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: IWeatherFacade)
class WeatherFacade implements IWeatherFacade {
  WeatherFacade();

  @override
  Future<Either<WeatherFailure, dynamic>> loadWeather({
    required Query query,
  }) async {
    final queryStr = query.getOrCrash();
    try {
      Map<String, String> requestHeaders = {
        'X-RapidAPI-Host': 'community-open-weather-map.p.rapidapi.com',
        'X-RapidAPI-Key': 'af58938779mshf9c47fe8bb813bep1842f9jsn116e28339dba',
      };

      print("qstr: " + queryStr);
      Weather? weather;
      final url =
          ("https://community-open-weather-map.p.rapidapi.com/weather?q=$queryStr");
      await http
          .get(
        Uri.parse(url),
        headers: requestHeaders,
      )
          .then((response) {
        print("rsp : " + response.body.toString());

        weather = Weather.fromJson(json.decode(response.body));
        print("we : " + weather!.base.toString());

        return right(weather);
      });

      return right(weather);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const WeatherFailure.locationNotFound());
      } else {
        return left(const WeatherFailure.serverError());
      }
    }
  }

  @override
  Future<Either<WeatherFailure, Unit>> showMessage() {
    throw UnimplementedError();
  }
}
