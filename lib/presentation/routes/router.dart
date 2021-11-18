import 'package:auto_route/annotations.dart';
import 'package:flutter_weather_exercise/presentation/home/home_page.dart';
import 'package:flutter_weather_exercise/presentation/register/register_page.dart';
import 'package:flutter_weather_exercise/presentation/sign_in/sign_in_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SignInPage, initial: true),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: HomePage),
  ],
)
class $AppRouter {}