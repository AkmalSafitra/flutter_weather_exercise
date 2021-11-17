import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather_exercise/domain/user/user_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial());

  @override
  UserState get initialState => UserState.initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    yield* event.map(
      getUser: (e) async* {
        yield state.copyWith(
          authFailureOrSuccessOption: none(),
        );
      },
      insertUser: (e) async* {
        yield state.copyWith(
          authFailureOrSuccessOption: none(),
        );
      },
      updateUser: (e) async* {
        yield state.copyWith(
          authFailureOrSuccessOption: none(),
        );
      },
      loadingUser: (e) async* {
        yield state.copyWith(
          authFailureOrSuccessOption: none(),
        );
      },
    );
  }
}
