part of 'weather_bloc.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState({
    required Query query,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<WeatherFailure,  Map<String, dynamic>>> authFailureOrSuccessOption,
  }) = _WeatherState;

  factory WeatherState.initial() => WeatherState(
    query: Query(''),
    showErrorMessages: false,
    isSubmitting: false,
    authFailureOrSuccessOption: none(),
  );
}
