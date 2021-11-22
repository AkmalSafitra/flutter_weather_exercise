import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_weather_exercise/domain/Weather/i_weather_facade.dart';
import 'package:flutter_weather_exercise/domain/Weather/value_objects.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather_failure.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'weather_event.dart';

part 'weather_state.dart';

part 'weather_bloc.freezed.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final IWeatherFacade weatherFacade;
  WeatherBloc({required this.weatherFacade}) : super(WeatherState.initial());

  @override
  WeatherState get initialState => WeatherState.initial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield* event.map(

      locationChanged: (e) async* {
        yield state.copyWith(
          query: Query(e.queryStr),
          authFailureOrSuccessOption: none(),
        );
      },

        showMessage: (e) async* {
          yield state.copyWith(
            authFailureOrSuccessOption: none(),
          );
        },

    loadWeather:  (e) async* {

          print('load weat');
          final isQueryValid = state.query.isValid();
          // final isQueryValid = true;
          print("q v" + isQueryValid.toString() );

          if (isQueryValid) {
            print('load weat 2ll');
            yield state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            );

            print("qu is: "+state.query.toString());
            final failureOrSuccess = await weatherFacade.loadWeather(
              query: state.query,
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

        );
  }
}
