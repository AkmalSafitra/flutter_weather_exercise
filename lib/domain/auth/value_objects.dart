import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/core/failures.dart';
import 'package:flutter_weather_exercise/domain/core/value_objects.dart';
import 'package:flutter_weather_exercise/domain/core/value_validators.dart';


class FirstName extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  const FirstName._(this.value);

  factory FirstName(String input) {
    return FirstName._(
      validateFirstName(input),
    );
  }
}

class LastName extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  const LastName._(this.value);

  factory LastName(String input) {
    return LastName._(
      validateLastName(input),
    );
  }
}

class EmailAddress extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  const EmailAddress._(this.value);

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }
}
class Password extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  const Password._(this.value);

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }
}


