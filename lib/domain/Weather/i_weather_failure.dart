import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/application/weather/weather_bloc.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather_failure.dart';


abstract class IWeatherInFacade{

  Future<Either<WeatherFailure, Unit>> loadingWeather();
  Future<Either<WeatherFailure, Unit>> loadedWeather();
  Future<Either<WeatherFailure, Unit>> showMessage();

// Future<Either<SignInFailure, Unit>> goToRegister();

}