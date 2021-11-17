part of 'user_bloc.dart';

@freezed
abstract class UserEvent with _$UserEvent{
  const factory UserEvent.loadingUser() = LoadingUser;
  const factory UserEvent.getUser() = GetUser;
  const factory UserEvent.insertUser() = InsertUser;
  const factory UserEvent.updateUser() = UpdateUser;
}