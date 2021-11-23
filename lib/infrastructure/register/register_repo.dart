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
      List _userList = <User>[];
      List _newUserList = <User>[];

      _newUserList = _userList.where((e) => e.emailAddress == emailAddressStr).toList();

      if (_newUserList.isEmpty) {
        User user = User(firstNameStr, lastNameStr, emailAddressStr, passwordStr);
        final userBox = Hive.box('users');
        userBox.add(user);
        return right(unit);
      }else{
        return left(const RegisterFailure.emailAlreadyInUse());
      }

    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const RegisterFailure.emailAlreadyInUse());
      } else {
        return left(const RegisterFailure.emailAlreadyInUse());
      }
    }
  }

  @override
  Future<Either<RegisterFailure, Unit>> editProfile({
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress emailAddress,
  }) async {
    final firstNameStr = firstName.getOrCrash();
    final lastNameStr = lastName.getOrCrash();
    final emailAddressStr = emailAddress.getOrCrash();
    try {
      List _userList = <User>[];
      List _newUser = <User>[];

      await Hive.openBox("users");
      await Hive.openBox("login");
      var userBox = Hive.box("users");
      var loginBox = Hive.box("login");

      _userList = userBox.values.toList();
      final signInUser = loginBox.get('login');
      _newUser = _userList.where((e) => e.emailAddress == emailAddressStr).toList();

      if (_newUser.isNotEmpty
          && _newUser[0].firstName == firstNameStr
          && _newUser[0].lastName == lastNameStr
          && _newUser[0].emailAddress == emailAddressStr) {
        // no changes
        return left(const RegisterFailure.editNoChanges());
      }
      else if (_newUser.isEmpty
          || (_newUser.isNotEmpty && _newUser[0].emailAddress == emailAddressStr)) {
        User user = User(firstNameStr, lastNameStr, emailAddressStr, signInUser.password.toString());

        Hive.box('login').put('login', user);

        final Map<dynamic, dynamic> deliveriesMap = userBox.toMap();
        deliveriesMap.forEach((key, value){
          if (value.emailAddress == signInUser.emailAddress) {
            userBox.delete(key);
          }
        });
        Hive.box("users").add(user);

        print("is r");
        return right(unit);
      }
      else {
        print("is fail");
        return left(const RegisterFailure.emailAlreadyInUse());
      }

    } on PlatformException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(const RegisterFailure.emailAlreadyInUse());
      } else {
        return left(const RegisterFailure.emailAlreadyInUse());
      }
    }
  }
}
