import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/sign_in/sign_in_bloc.dart';
import 'package:flutter_weather_exercise/presentation/register/register_page.dart';
import 'package:flutter_weather_exercise/presentation/routes/router.gr.dart';
import 'package:another_flushbar/flushbar.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => {
              // display error snackBar
              Flushbar(
                message: failure.map(
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid Email and Password Combination',
                ),
                duration: Duration(seconds: 3),
              ).show(context),
            },
            (_) {
              context.replaceRoute(const HomeRoute());
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
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<SignInBloc>()
                      .add(SignInEvent.emailChanged(value)),
                  validator: (_) =>
                      context.read<SignInBloc>().state.emailAddress.value.fold(
                            (f) => f.maybeMap(
                              invalidEmail: (_) => 'Invalid Email',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .read<SignInBloc>()
                      .add(SignInEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.read<SignInBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Short Password',
                              orElse: () => null,
                            ),
                            (_) => null,
                          ),
                ),
                ElevatedButton(
                  child: const Text('SIGN IN'),
                  onPressed: () {
                    context.read<SignInBloc>().add(
                          const SignInEvent.signInPressed(),
                        );
                  },
                ),
                TextButton(
                  child: const Text('REGISTER NEW ACCOUNT'),
                  onPressed: () {
                    context.replaceRoute(const RegisterRoute());
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
