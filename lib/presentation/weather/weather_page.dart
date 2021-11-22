import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/weather/weather_bloc.dart';
import 'package:flutter_weather_exercise/domain/Weather/weather.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';
import 'package:flutter_weather_exercise/presentation/weather/weather_detail_page.dart';

class WeatherPage extends StatelessWidget {
  static const routeName = '/weatherPage';

  var _controllerQuery = TextEditingController();

  Weather? weather;

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
              weather = result;
              // print("weather result : " + weather.toString());
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
                flex: 1,
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
                flex: 8,
                child: weather?.name.toString() == null
                    ? const Center(child: Text("Search Weather Location"))
                    : ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 8.0),
                        leading: Hero(
                          tag: weather!.weather[0].icon,
                          child: Image.network(
                              "http://openweathermap.org/img/wn/${weather!.weather[0].icon}@2x.png",
                              width: 50),
                        ),

                        title: Text(weather!.name),
                        subtitle: Text(weather!.weather[0].description),
                        onTap: () => context.pushRoute(WeatherDetailRoute(weather: weather as Weather)),
                        // onTap: (){Navigator.pushNamed(
                        //   context,
                        //   WeatherDetailPage.routeName,
                        //   arguments: weather,
                        //   );
                        // },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
