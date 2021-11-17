part of 'user_bloc.dart';


@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<UserFailure, Unit>> authFailureOrSuccessOption,
  }) = _UserState;

  factory UserState.initial() => UserState(
    showErrorMessages: false,
    isSubmitting: false,
    authFailureOrSuccessOption: none(),
  );
}
