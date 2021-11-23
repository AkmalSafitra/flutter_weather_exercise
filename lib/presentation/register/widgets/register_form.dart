import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/register/register_bloc.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';

class RegisterForm extends StatelessWidget {
  var _controllerFirstName = TextEditingController();
  var _controllerLastName = TextEditingController();
  var _controllerEmailAddress = TextEditingController();
  var _controllerPassword = TextEditingController();

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
                  editNoChanges: (_) => '' ,
                ),
                duration: Duration(seconds: 3),
              ).show(context),
            },
            (_) {
              final snackBar =
                  SnackBar(content: Text('User Successfully Created'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              _controllerFirstName.clear();
              _controllerLastName.clear();
              _controllerEmailAddress.clear();
              _controllerPassword.clear();
            },
          ),
        );
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidate: state.showErrorMessages,
            child: ListView(
              children: [
                const Text(
                  '☁',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 130),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _controllerFirstName,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: 'First Name',
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<RegisterBloc>()
                      .add(RegisterEvent.firstNameChanged(value)),
                  validator: (_) =>
                      context.read<RegisterBloc>().state.firstName.value.fold(
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_box_rounded),
                    labelText: 'Last Name',
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<RegisterBloc>()
                      .add(RegisterEvent.lastNameChanged(value)),
                  validator: (_) =>
                      context.read<RegisterBloc>().state.lastName.value.fold(
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
                const SizedBox(height: 8),
                TextFormField(
                  controller: _controllerPassword,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .read<RegisterBloc>()
                      .add(RegisterEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.read<RegisterBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Short Password',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                ElevatedButton(
                  child: const Text('REGISTER'),
                  onPressed: () {
                    context.read<RegisterBloc>().add(
                          const RegisterEvent.registerPressed(),
                        );
                  },
                ),
                TextButton(
                  child: const Text('GO TO SIGN IN'),
                  onPressed: () {
                    context.replaceRoute(const SignInRoute());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
