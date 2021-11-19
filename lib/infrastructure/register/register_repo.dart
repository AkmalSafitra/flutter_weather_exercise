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
    print("is asa");
    try {
      print("is try");
      List _userList = <User>[];
      List _signInUser = <User>[];
      List _newUser = <User>[];

      await Hive.openBox("users");
      await Hive.openBox("login");
      var userBox = Hive.box("users");
      var loginBox = Hive.box("users");

      _userList = userBox.values.toList();
      _signInUser = loginBox.values.toList();
      print(_signInUser);
      print(emailAddressStr);
      _newUser = _userList.where((e) => e.emailAddress == emailAddressStr).toList();

      if (_newUser.isEmpty) {
        print("is emp");
        User user = User(firstNameStr, lastNameStr, emailAddressStr, _signInUser[0].password.toString());
        Hive.box("login").putAt(0, user);


        print("is user");
        final Map<dynamic, dynamic> deliveriesMap = userBox.toMap();
        dynamic desiredKey;
        deliveriesMap.forEach((key, value){
          print(value.emailAddress);
          print("_");
          print(_signInUser[0].emailAddress);
          print("__");
          if (value.emailAddress == _signInUser[0].emailAddress) {
            print("is key found");
            desiredKey = key;
            userBox.delete(desiredKey);
          }
        });

        Hive.box("users").add(user);

        print("is r");
        return right(unit);
      } else {
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
