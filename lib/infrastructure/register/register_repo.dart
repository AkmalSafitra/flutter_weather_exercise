
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_exercise/domain/register/i_register_facade.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:flutter_weather_exercise/domain/register/value_objects.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRegisterFacade)
class SqlRegisterFacade implements IRegisterFacade {

  SqlRegisterFacade();

  @override
  Future<Either<RegisterFailure, Unit>> registerWithEmailAndPassword({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final firstNameStr = firstName.getOrCrash();
    final lastNameStr = lastName.getOrCrash();
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      // _firebaseAuth.createUserWithEmailAndPassword(
      //   email: emailAddressStr,
      //   password: passwordStr,
      // );

      User user = User(firstNameStr, lastNameStr, emailAddressStr, passwordStr);
      Hive.box('users').add(user);

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const RegisterFailure.emailAlreadyInUse());
      } else {
        return left(const RegisterFailure.emailAlreadyInUse());
      }
    }
  }


}
