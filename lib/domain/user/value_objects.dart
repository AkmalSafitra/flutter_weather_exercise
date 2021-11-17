import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/core/failures.dart';
import 'package:flutter_weather_exercise/domain/core/value_objects.dart';
import 'package:flutter_weather_exercise/domain/core/value_validators.dart';
import 'package:kt_dart/kt.dart';

// class NoteBody extends ValueObject<String> {
//   @override
//   final Either<ValueFailure<String>, String> value;
//
//   static const maxLength = 1000;
//
//   factory NoteBody(String input) {
//     assert(input != null);
//     return NoteBody._(
//       validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
//     );
//   }
//
//   const NoteBody._(this.value);
// }
//
