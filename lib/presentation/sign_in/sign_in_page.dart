
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/sign_in/sign_in_bloc.dart';
import 'package:flutter_weather_exercise/injection.dart';
import 'package:flutter_weather_exercise/presentation/sign_in/widgets/sign_in_form.dart';


class SignInPage extends StatelessWidget {
  static const routeName = '/signInPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocProvider<SignInBloc>(
        create: (context) => getIt<SignInBloc>(),
        child: SignInForm(),
      ),

    );
  }
}
