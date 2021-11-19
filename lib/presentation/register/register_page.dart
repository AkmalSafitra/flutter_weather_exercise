import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/register/register_bloc.dart';
import 'package:flutter_weather_exercise/presentation/register/widgets/register_form.dart';
import 'package:hive/hive.dart';

import '../../injection.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = '/registerPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => getIt<RegisterBloc>(),
        child: FutureBuilder(
          future: Hive.openBox(
            'users',
            compactionStrategy: (int total, int deleted) {
              return deleted > 20;
            },
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return  RegisterForm();
              }
            } else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}
