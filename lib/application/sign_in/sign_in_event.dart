part of 'sign_in_bloc.dart';

@freezed
abstract class SignInEvent with _$SignInEvent{
  const factory SignInEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInEvent.passwordChanged(String passwordStr) = PasswordChanged;

  const factory SignInEvent.signInPressed() = SignInPressed;
  // const factory SignInEvent.registerNewAccountPressed() = RegisterNewAccountPressed;

}