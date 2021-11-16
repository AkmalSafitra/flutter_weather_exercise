//
// import 'package:dartz/dartz.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_weather_exercise/domain/auth/sign_in_failure.dart';
// import 'package:flutter_weather_exercise/domain/auth/i_sign_in_facade.dart';
// import 'package:flutter_weather_exercise/domain/auth/value_objects.dart';
// import 'package:injectable/injectable.dart';
//
// @LazySingleton(as: IAuthFacade)
// class FirebaseAuthFacade implements IAuthFacade {
//   // final FirebaseAuth _firebaseAuth;
//   // final GoogleSignIn _googleSignIn;
//   //
//   // FirebaseAuthFacade(this._firebaseAuth,
//   //     this._googleSignIn,);
//
//   @override
//   Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
//     required FirstName firstName,
//     required LastName lastName,
//     required EmailAddress emailAddress,
//     required Password password,
//   }) async {
//     final emailAddressStr = emailAddress.getOrCrash();
//     final passwordStr = password.getOrCrash();
//
//     try {
//       // _firebaseAuth.createUserWithEmailAndPassword(
//       //   email: emailAddressStr,
//       //   password: passwordStr,
//       // );
//       return right(unit);
//     } on PlatformException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         return left(const AuthFailure.emailAlreadyInUse());
//       } else {
//         return left(const AuthFailure.serverError());
//       }
//     }
//   }
//
//
// }
