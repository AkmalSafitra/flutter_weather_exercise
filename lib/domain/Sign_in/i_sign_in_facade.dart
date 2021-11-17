import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/value_objects.dart';

import 'sign_in_failure.dart';

abstract class ISignInFacade{

  Future<Either<SignInFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  // Future<Either<SignInFailure, Unit>> goToRegister();

}