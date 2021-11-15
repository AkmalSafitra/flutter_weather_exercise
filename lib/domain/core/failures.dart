
import 'package:freezed_annotation/freezed_annotation.dart';
part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {

  const factory ValueFailure.invalidFirstName({
    required String failedValue,
  }) = InvalidFirstName<T>;

  const factory ValueFailure.invalidLastName({
    required String failedValue,
  }) = InvalidLastName<T>;

  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required String failedValue,
  }) = ShortPassword<T>;
}
