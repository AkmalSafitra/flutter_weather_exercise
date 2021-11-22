import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/Weather/value_objects.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather_failure.dart';


abstract class IWeatherFacade{

  Future<Either<WeatherFailure, Map<String, dynamic>>> loadWeather({
    required Query query,
});
  Future<Either<WeatherFailure, Unit>> showMessage();

// Future<Either<SignInFailure, Unit>> goToRegister();

}