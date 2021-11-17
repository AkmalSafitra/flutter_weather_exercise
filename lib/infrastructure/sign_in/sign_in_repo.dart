import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/i_sign_in_facade.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/sign_in_failure.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/value_objects.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:flutter_weather_exercise/domain/user/user.dart';
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

    try {
      // _firebaseAuth.createUserWithEmailAndPassword(
      //   email: emailAddressStr,
      //   password: passwordStr,
      // );

      List _userList = <User>[];
      List _signInUser = <User>[];
      Hive.openBox("users");
      var userBox = Hive.box("users");
      _userList = userBox.values.toList();

      _signInUser = _userList.where((e) => e.emailAddress == emailAddressStr && e.password == passwordStr ).toList();

      if(_signInUser.isNotEmpty){
        Hive.openBox("login");
        Hive.box('login').add(_signInUser);
      }

      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const SignInFailure.invalidEmailAndPasswordCombination());
      }
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
      // _firebaseAuth.createUserWithEmailAndPassword(
      //   email: emailAddressStr,
      //   password: passwordStr,
      // );

      List<User> _userList = [];
      var userBox = Hive.box("users");
      _userList = userBox.values.toList() as List<User>;

      List<User> _signInUser = _userList.where((e) => e.emailAddress == emailAddressStr && e.password == passwordStr ) as List<User>;

      if(_signInUser.isNotEmpty){
        Hive.openBox("login");
        Hive.box('login').add(_signInUser);
      }

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
