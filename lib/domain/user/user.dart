

import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_exercise/domain/core/value_objects.dart';
import 'package:flutter_weather_exercise/domain/register/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User implements _$User {
  const User._();

  const factory User({
    required UniqueId id,
    required FirstName firstName,
    required LastName lastName,
    required EmailAddress emailAddress,
    required Password password,
  }) = _User;

  factory User.empty() => User(
    id: UniqueId(),
    firstName: FirstName(''),
    lastName: LastName(''),
    emailAddress: EmailAddress(''),
    password: Password(''),
  );

  // Option<ValueFailure<dynamic>> get failureOption {
  //   return body.failureOrUnit
  //       .andThen(todos.failureOrUnit)
  //       .andThen(
  //     todos
  //         .getOrCrash()
  //     // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
  //         .map((todoItem) => todoItem.failureOption)
  //         .filter((o) => o.isSome())
  //     // If we can't get the 0th element, the list is empty. In such a case, it's valid.
  //         .getOrElse(0, (_) => none())
  //         .fold(() => right(unit), (f) => left(f)),
  //   )
  //       .fold((f) => some(f), (_) => none());
  // }

}