import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/register/register_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

part 'weather_bloc.freezed.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // final IRegisterFacade registerFacade;
  // {required this.registerFacade}
  WeatherBloc() : super(WeatherState.initial());

  @override
  WeatherState get initialState => WeatherState.initial();

  @override
  Stream<WeatherState> mapEventToState(
      WeatherEvent event,
      ) async* {

    // yield* event.map(
    //   firstNameChanged: (e) async* {
    //     yield state.copyWith(
    //       firstName: FirstName(e.firstNameStr),
    //       authFailureOrSuccessOption: none(),
    //     );
    //   },
    //   lastNameChanged: (e) async* {
    //     yield state.copyWith(
    //       lastName: LastName(e.lastNameStr),
    //       authFailureOrSuccessOption: none(),
    //     );
    //   },
    //   emailChanged: (e) async* {
    //     yield state.copyWith(
    //       emailAddress: EmailAddress(e.emailStr),
    //       authFailureOrSuccessOption: none(),
    //     );
    //   },
    //   passwordChanged: (e) async* {
    //     yield state.copyWith(
    //       password: Password(e.passwordStr),
    //       authFailureOrSuccessOption: none(),
    //     );
    //   },
    //
    //   registerPressed: (e) async* {
    //
    //     final isFirstNameValid = state.firstName.isValid();
    //     final isLastNameValid = state.lastName.isValid();
    //     final isEmailValid = state.emailAddress.isValid();
    //     final isPasswordValid = state.password.isValid();
    //
    //     if (isFirstNameValid && isLastNameValid && isEmailValid && isPasswordValid) {
    //       yield state.copyWith(
    //         isSubmitting: true,
    //         authFailureOrSuccessOption: none(),
    //       );
    //
    //       final failureOrSuccess = await registerFacade.registerWithEmailAndPassword(
    //         firstName: state.firstName,
    //         lastName: state.lastName,
    //         emailAddress: state.emailAddress,
    //         password: state.password,
    //       );
    //
    //       yield state.copyWith(
    //         isSubmitting: false,
    //         authFailureOrSuccessOption: some(failureOrSuccess),
    //       );
    //     }
    //
    //     yield state.copyWith(
    //       isSubmitting: false,
    //       showErrorMessages: true,
    //     );
    //   },
    //
    //   editProfilePressed: (e) async* {
    //
    //     final isFirstNameValid = state.firstName.isValid();
    //     final isLastNameValid = state.lastName.isValid();
    //     final isEmailValid = state.emailAddress.isValid();
    //
    //     if (isFirstNameValid && isLastNameValid && isEmailValid) {
    //       yield state.copyWith(
    //         isSubmitting: true,
    //         authFailureOrSuccessOption: none(),
    //       );
    //
    //       final failureOrSuccess = await registerFacade.editProfile(
    //         firstName: state.firstName,
    //         lastName: state.lastName,
    //         emailAddress: state.emailAddress,
    //       );
    //
    //       yield state.copyWith(
    //         isSubmitting: false,
    //         authFailureOrSuccessOption: some(failureOrSuccess),
    //       );
    //     }
    //
    //     yield state.copyWith(
    //       isSubmitting: false,
    //       showErrorMessages: true,
    //     );
    //   },
    //
    //
    // );
  }

}
