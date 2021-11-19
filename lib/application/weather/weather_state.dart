part of 'weather_bloc.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState({
    // required FirstName firstName,
    // required LastName lastName,
    // required EmailAddress emailAddress,
    // required Password password,
    // required bool showErrorMessages,
    // required bool isSubmitting,
    required Option<Either<RegisterFailure, Unit>> authFailureOrSuccessOption,
  }) = _WeatherState;

  factory WeatherState.initial() => WeatherState(
    // firstName: FirstName(''),
    // lastName: LastName(''),
    // emailAddress: EmailAddress(''),
    // password: Password(''),
    // showErrorMessages: false,
    // isSubmitting: false,
    authFailureOrSuccessOption: none(),
  );
}
