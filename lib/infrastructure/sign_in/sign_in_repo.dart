import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/i_sign_in_facade.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/sign_in_failure.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/value_objects.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:hive/hive.dart';
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

    List _userList = <User>[];
    List _signInUser = <User>[];

    await Hive.openBox("users");
    var userBox = Hive.box("users");
    _userList = userBox.values.toList();
    _signInUser = _userList
        .where((e) =>
            e.emailAddress == emailAddressStr && e.password == passwordStr)
        .toList();

    if (_signInUser.isNotEmpty) {
      await Hive.openBox("login");
      User user = User(_signInUser[0].firstName.toString(), _signInUser[0].lastName.toString(), emailAddressStr, passwordStr);
      // Hive.box("login").put('login', _signInUser);
      Hive.box("login").put('login', user);
      print('save signin' + Hive.box("login").values.length.toString());
      return right(unit);
    } else {
      print('signin failed1');
      return left(const SignInFailure.invalidEmailAndPasswordCombination());
    }

  }

  @override
  Future<Either<SignInFailure, Unit>> register({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {

        return right(unit);

    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      }
    }
  }

// @override
// Future<Either<SignInFailure, Unit>> goToRegister() {
//
// }

}
