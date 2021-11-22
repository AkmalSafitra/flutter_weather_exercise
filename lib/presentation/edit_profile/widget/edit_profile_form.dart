import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/register/register_bloc.dart';
import 'package:flutter_weather_exercise/domain/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditProfileForm extends StatefulWidget {
  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _controllerFirstName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerEmailAddress = TextEditingController();
  final loginBox = Hive.box('login');
  @override
  void initState() {
    User user = loginBox.get('login');
    if(user != null){
      _controllerFirstName.text =  user.firstName.toString();
      _controllerLastName.text = user.lastName.toString();
      _controllerEmailAddress.text = user.emailAddress.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => {
              // display error snackBar
              Flushbar(
                message: failure.map(
                  emailAlreadyInUse: (_) => 'Email already in use',
                ),
                duration: Duration(seconds: 3),
              ).show(context),
            },
            (_) {
              final snackBar = SnackBar(content: Text('Profile Successfully Saved'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        );
      },
      builder: (context, state) {

        return WatchBoxBuilder(
          box: loginBox,
          builder: (context, user) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidate: state.showErrorMessages,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _controllerFirstName,//..text = 'abc',
                        // initialValue: user[0].firstName.toString(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded),
                          labelText: 'First Name',
                        ),
                        autocorrect: false,
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.firstNameChanged(value)),
                        validator: (_) => context
                            .read<RegisterBloc>()
                            .state
                            .firstName
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                invalidFirstName: (_) => 'Invalid First Name',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _controllerLastName,
                        // initialValue: user[0].lastName.toString(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded),
                          labelText: 'Last Name',
                        ),
                        autocorrect: false,
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.lastNameChanged(value)),
                        validator: (_) => context
                            .read<RegisterBloc>()
                            .state
                            .lastName
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                invalidLastName: (_) => 'Invalid Last Name',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      ),

                      const SizedBox(height: 8),

                      TextFormField(
                        controller: _controllerEmailAddress,
                        // initialValue: user[0].emailAddress.toString(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        autocorrect: false,
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.emailChanged(value)),
                        validator: (_) => context
                            .read<RegisterBloc>()
                            .state
                            .emailAddress
                            .value
                            .fold(
                              (f) => f.maybeMap(
                                invalidEmail: (_) => 'Invalid Email',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      ),

                      SizedBox(height: 18),

                      ElevatedButton(
                        child: const Text('Save Profile'),
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                                const RegisterEvent.editProfilePressed(),
                              );
                        },
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
