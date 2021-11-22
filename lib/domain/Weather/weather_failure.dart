import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_failure.freezed.dart';

@freezed
abstract class WeatherFailure with _$WeatherFailure {
  const factory WeatherFailure.unableLoadWeather() = _UnableLoadWeather;
  const factory WeatherFailure.locationNotFound() = _LocationNotFound;
  const factory WeatherFailure.serverError() = _ServerError;
}
