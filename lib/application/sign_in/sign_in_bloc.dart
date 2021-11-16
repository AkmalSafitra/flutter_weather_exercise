import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/i_sign_in_facade.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/sign_in_failure.dart';
import 'package:flutter_weather_exercise/domain/Sign_in/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ISignInFacade signInFacade;

  SignInBloc({required this.signInFacade}) : super(SignInState.initial());

  @override
  SignInState get initialState => SignInState.initial();

  @override
  Stream<SignInState> mapEventToState(
      SignInEvent event,
      ) async* {

    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none(),
        );
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none(),
        );
      },

      signInPressed: (e) async* {

        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();

        if (isEmailValid && isPasswordValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          );

          final failureOrSuccess = await signInFacade.signInWithEmailAndPassword(
            emailAddress: state.emailAddress,
            password: state.password,
          );

          yield state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          );
        }

        yield state.copyWith(
          isSubmitting: false,
          showErrorMessages: true,
        );
      },

      registerNewAccountPressed: (e) async* {
        yield state.copyWith(
          isSubmitting: true,
          showErrorMessages: true,
        );
      }

    );
  }

}