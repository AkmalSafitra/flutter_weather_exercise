part of 'weather_bloc.dart';

@freezed
abstract class WeatherEvent with _$WeatherEvent{
  const factory WeatherEvent.loadingWeather() = LoadingWeather;
  const factory WeatherEvent.loadedWeather() = LoadedWeather;
  const factory WeatherEvent.showMessage() = ShowMessage;

}