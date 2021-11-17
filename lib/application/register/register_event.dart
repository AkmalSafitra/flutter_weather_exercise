part of 'register_bloc.dart';

@freezed
abstract class RegisterEvent with _$RegisterEvent{
  const factory RegisterEvent.firstNameChanged(String firstNameStr) = FirstNameChanged;
  const factory RegisterEvent.lastNameChanged(String lastNameStr) = LastNameChanged;
  const factory RegisterEvent.emailChanged(String emailStr) = EmailChanged;
  const factory RegisterEvent.passwordChanged(String passwordStr) = PasswordChanged;

  const factory RegisterEvent.registerPressed() = RegisterPressed;
  const factory RegisterEvent.goToSignInPressed() = GoToSignInPressed;

}