import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/register/register_bloc.dart';
import 'package:flutter_weather_exercise/presentation/edit_profile/widget/edit_profile_form.dart';
import 'package:hive/hive.dart';

import '../../injection.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = '/editProfilePage';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'),),
      body: FutureBuilder(
        future:  Hive.openBox('login'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return BlocProvider<RegisterBloc>(
                create: (context) => getIt<RegisterBloc>(),
                child: EditProfileForm(),
              );
              // return EditProfileDetail();
            }
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
