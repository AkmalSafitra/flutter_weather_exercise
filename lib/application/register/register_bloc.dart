import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/register/i_register_facade.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:flutter_weather_exercise/domain/register/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';

part 'register_bloc.freezed.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final IRegisterFacade registerFacade;

  RegisterBloc({required this.registerFacade}) : super(RegisterState.initial());

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

        final isFirstNameValid = state.firstName.isValid();
        final isLastNameValid = state.lastName.isValid();
        final isEmailValid = state.emailAddress.isValid();
        final isPasswordValid = state.password.isValid();

        if (isFirstNameValid && isLastNameValid && isEmailValid && isPasswordValid) {
          yield state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          );

          final failureOrSuccess = await registerFacade.registerWithEmailAndPassword(
            firstName: state.firstName,
            lastName: state.lastName,
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

      goToSignInPressed: (e)async*{


        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
          showErrorMessages: true,
        );
      }

    );
  }

}
