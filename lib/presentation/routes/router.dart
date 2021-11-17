

import 'package:auto_route/annotations.dart';
import 'package:flutter_weather_exercise/presentation/register/register_page.dart';
import 'package:flutter_weather_exercise/presentation/sign_in/sign_in_page.dart';

@MaterialAutoRouter(
  // generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: RegisterPage),
  ],
)
class $Router {}
