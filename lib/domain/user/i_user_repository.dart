
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/user/user.dart';
import 'package:flutter_weather_exercise/domain/user/user_failure.dart';
import 'package:kt_dart/collection.dart';

abstract class IUserRepository {
  Stream<Either<UserFailure, KtList<User>>> watchAll();
  Stream<Either<UserFailure, KtList<User>>> watchUncompleted();
  Future<Either<UserFailure, Unit>> createUser(User user);
  Future<Either<UserFailure, Unit>> updateUser(User user);
  Future<Either<UserFailure, Unit>> deleteUser(User user);
}