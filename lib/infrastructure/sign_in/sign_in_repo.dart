import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/i_sign_in_facade.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/sign_in_failure.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/value_objects.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISignInFacade)
class SqlSignInFacade implements ISignInFacade {

  SqlSignInFacade();

  @override
  Future<Either<SignInFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      // _firebaseAuth.createUserWithEmailAndPassword(
      //   email: emailAddressStr,
      //   password: passwordStr,
      // );
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      }
    }
  }


}
