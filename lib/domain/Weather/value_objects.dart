import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/core/failures.dart';
import 'package:flutter_weather_exercise/domain/core/value_objects.dart';
import 'package:flutter_weather_exercise/domain/core/value_validators.dart';


class Query extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  const Query._(this.value);

  factory Query(String input) {
    return Query._(
      validateStringNotEmpty(input),
    );
  }
}

// class LastName extends ValueObject<String>{
//   final Either<ValueFailure<String>, String> value;
//
//   const LastName._(this.value);
//
//   factory LastName(String input) {
//     return LastName._(
//       validateLastName(input),
//     );
//   }
// }