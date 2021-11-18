import 'package:flutter/material.dart';
import 'package:flutter_weather_exercise/presentation/register/register_page.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';
import 'package:flutter_weather_exercise/presentation/sign_in/sign_in_page.dart';

class MyApp extends StatelessWidget {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        accentColor: Colors.blueAccent,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),

      routes: {
        '/signInPage': (context) => SignInPage(),
        '/registerPage': (context) => RegisterPage(),
      },

      // home: SignInPage(),
      home: MaterialApp.router(
        routeInformationParser: router.defaultRouteParser(),
        routerDelegate: router.delegate(),
      ),
    );
  }
}
