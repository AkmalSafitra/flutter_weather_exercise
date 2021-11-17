import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_exercise/application/register/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
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
              // TODO: Navigate
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
                    invalidEmail: (_) => 'Invalid First Name',
                    orElse: () => null,
                  ),
                      (_) => null,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                    invalidEmail: (_) => 'Invalid Last Name',
                    orElse: () => null,
                  ),
                      (_) => null,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
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
                  context.read<RegisterBloc>().add(
                    const RegisterEvent.goToSignInPressed(),
                  );
                },
              ),

            ],
          ),
        );
      },
    );
  }
}
