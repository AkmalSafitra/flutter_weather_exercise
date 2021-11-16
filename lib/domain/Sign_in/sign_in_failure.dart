import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
abstract class SignInFailure with _$SignInFailure{
  const factory SignInFailure.invalidEmailAndPasswordCombination() = InvalidEmailAndPasswordCombination;
}