import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/weather/weather_bloc.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';
import 'package:flutter_weather_exercise/presentation/weather/weather_page.dart';

import '../../injection.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              context.pushRoute(const EditProfileRoute());
            },
          ),
          TextButton(
              onPressed: () => context.replaceRoute(const SignInRoute()),
              child: const Text(
                ('Sign Out'),
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<WeatherBloc>(),
        child: WeatherPage(),
      ),
    );
  }
}
