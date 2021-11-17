import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/sign_in/sign_in_bloc.dart';
import 'package:flutter_weather_exercise/presentation/register/register_page.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) => {
              // FlushbarHelper.createError(
              //   message: failure.map(
              //     cancelledByUser: (_) => 'Cancelled',
              //     serverError: (_) => 'Server Error',
              //     emailAlreadyInUse: (_) => 'Email already in use',
              //     invalidEmailAndPasswordCombination: (_) => 'Invalid email and password combination',
              //   ),
              // ).show(context),
            },
            (_) {
              // ExtendedNavigator.of(context).replace(Routes.notesOverviewPage);
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
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
                  Navigator.of(context).pushReplacementNamed(RegisterPage.routeName);
                  // Navigator.of(context).pushNamed(route)
                  // context.read<SignInBloc>().add(
                  //       const SignInEvent.registerNewAccountPressed(),
                  //     );
                },
              ),

            ],
          ),
        );
      },
    );
  }
}
