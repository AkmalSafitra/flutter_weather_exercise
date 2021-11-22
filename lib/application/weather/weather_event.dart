part of 'weather_bloc.dart';

@freezed
abstract class WeatherEvent with _$WeatherEvent{
  const factory WeatherEvent.locationChanged(String queryStr) = LocationChanged;
  const factory WeatherEvent.loadWeather(String location) = LoadedWeather;
  const factory WeatherEvent.showMessage() = ShowMessage;

}