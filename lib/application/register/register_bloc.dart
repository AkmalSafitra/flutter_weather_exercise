import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/auth/auth_failure.dart';
import 'package:flutter_weather_exercise/domain/auth/i_auth_facade.dart';
import 'package:flutter_weather_exercise/domain/auth/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_event.dart';
part 'register_state.dart';

part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IAuthFacade authFacade;

  RegisterBloc({required this.authFacade}) : super(RegisterState.initial());

  @override
  RegisterState get initialState => RegisterState.initial();

  @override
  Stream<RegisterState> mapEventToState(
      RegisterEvent event,
      ) async* {

    yield* event.map(
      firstNameChanged: (e) async* {
        yield state.copyWith(
          firstName: FirstName(e.firstNameStr),
          authFailureOrSuccessOption: none(),
        );
      },
      lastNameChanged: (e) async* {
        yield state.copyWith(
          lastName: LastName(e.lastNameStr),
          authFailureOrSuccessOption: none(),
        );
      },
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

      registerPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
          authFacade.registerWithEmailAndPassword,
        );
      },

    );
  }

  Stream<RegisterState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, Unit>> Function(
          {required EmailAddress emailAddress, required Password password})
      forwardedCall,
      ) async* {
    // Either<AuthFailure, Unit> failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      final failureOrSuccess = await forwardedCall(
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
  }
}
