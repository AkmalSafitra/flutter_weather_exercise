import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:flutter_weather_exercise/domain/register/value_objects.dart';

abstract class IRegisterFacade{
  Future<Either<RegisterFailure, Unit>> registerWithEmailAndPassword({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<RegisterFailure, Unit>> editProfile({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress emailAddress,
  });

}