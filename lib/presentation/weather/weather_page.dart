import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/weather/weather_bloc.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';

class WeatherPage extends StatelessWidget {
  static const routeName = '/weatherPage';

  var _controllerQuery = TextEditingController();
  late Map<String, dynamic> weather = {'':''} ;
  late User usr;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => {
              // display error snackBar
            },
            (result) {
              final snackBar =
                  SnackBar(content: Text('User Successfully Created'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // _controllerFirstName.clear();
              weather = result;
              print("we s : " + weather.toString());
              print("we res : " + result.toString());
            },
          ),
        );
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controllerQuery,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: 'Location',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print("isi tedtfield: " + _controllerQuery.text);
                        context.read<WeatherBloc>().add(
                            WeatherEvent.loadWeather(_controllerQuery.text));
                      },
                    ),
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<WeatherBloc>()
                      .add(WeatherEvent.locationChanged(value)),
                  validator: (_) =>
                      context.read<WeatherBloc>().state.query.value.fold(
                            (f) => f.maybeMap(
                              invalidFirstName: (_) => 'Invalid Query',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
              ),
              Expanded(
                child: Text("weather.firstName.toString()"),
              ),
            ],
          ),
        );
      },
    );
  }
}
