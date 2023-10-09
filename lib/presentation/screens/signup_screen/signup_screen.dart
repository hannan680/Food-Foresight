import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/presentation/screens/signup_screen/bloc/signupvalidation_bloc.dart';
import 'package:food_foresight/presentation/widgets/alertbox.dart';
import "../../routes/app_routes.dart";

import '../../widgets/custom_richtext.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/rounded_button.dart';

//

import './models/signup_data.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheckedBox = false;

  final SignupData _signupData =
      SignupData(email: "", name: "", password: "", phone: "");

  void signUp() {
    BlocProvider.of<AuthenticationBloc>(context).add(SignUpRequested(
        email: _signupData.email,
        password: _signupData.password,
        name: _signupData.name,
        phone: _signupData.phone));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.status == AuthenticationStatus.error) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBox(
                              icon: const Icon(Icons.warning),
                              buttonText: "Ok",
                              heading: "Error",
                              description: state.errorMessage!,
                              onButtonPressed: () =>
                                  Navigator.of(context).pop(),
                            );
                          });
                    }
                    if (state.status == AuthenticationStatus.authenticated) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertBox(
                              icon: const Icon(Icons.done_outline_rounded),
                              buttonText: "Ok",
                              heading: "Success",
                              description: "Successfully signed up",
                              onButtonPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.login);
                              },
                            );
                          });
                    }
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Please fill in the fields below.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          BlocBuilder<SignupvalidationBloc,
                              SignupvalidationState>(
                            builder: (context, state) {
                              return CustomFormField(
                                label: 'Name',
                                errorText: state is Error
                                    ? state.error?.nameError
                                    : null,
                                prefixIcon: Icons.person,
                                hintText: "Name",
                                onChange: (value) {
                                  _signupData.name = value;
                                  BlocProvider.of<SignupvalidationBloc>(context)
                                      .add(NameTextChange(name: value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          BlocBuilder<SignupvalidationBloc,
                              SignupvalidationState>(
                            builder: (context, state) {
                              return CustomFormField(
                                label: 'Email',
                                errorText: state is Error
                                    ? state.error?.emailError
                                    : null,
                                prefixIcon: Icons.email,
                                hintText: "Email",
                                onChange: (value) {
                                  _signupData.email = value;

                                  BlocProvider.of<SignupvalidationBloc>(context)
                                      .add(EmailTextChange(email: value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          BlocBuilder<SignupvalidationBloc,
                              SignupvalidationState>(
                            builder: (context, state) {
                              return CustomFormField(
                                label: 'Phone',
                                errorText: state is Error
                                    ? state.error?.phoneError
                                    : null,
                                prefixIcon: Icons.phone,
                                hintText: "Phone",
                                onChange: (value) {
                                  _signupData.phone = value;

                                  BlocProvider.of<SignupvalidationBloc>(context)
                                      .add(PhoneTextChange(phone: value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          BlocBuilder<SignupvalidationBloc,
                              SignupvalidationState>(
                            builder: (context, state) {
                              return CustomFormField(
                                isObsureText: true,
                                label: 'Password',
                                errorText: state is Error
                                    ? state.error?.passwordError
                                    : null,
                                prefixIcon: Icons.password,
                                hintText: "Password",
                                onChange: (value) {
                                  _signupData.password = value;

                                  BlocProvider.of<SignupvalidationBloc>(context)
                                      .add(PasswordTextChange(password: value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                  value: isCheckedBox,
                                  onChanged: (value) {
                                    setState(() {
                                      isCheckedBox = !isCheckedBox;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              CustomRichText(
                                text: "Agree with ",
                                link: "Terms and Conditions",
                                linkColor: Colors.blue,
                                onLinkTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    BlocBuilder<SignupvalidationBloc, SignupvalidationState>(
                      builder: (context, state) {
                        if (state is Error) {
                          if (state.error?.nameError == null &&
                              state.error?.emailError == null &&
                              state.error?.passwordError == null &&
                              state.error?.phoneError == null &&
                              isCheckedBox) {
                            return context
                                        .watch<AuthenticationBloc>()
                                        .state
                                        .status ==
                                    AuthenticationStatus.loading
                                ? const RoundedButton(
                                    text: "Signing Up...", onTap: null)
                                : RoundedButton(
                                    text: "Sign Up",
                                    onTap: () {
                                      signUp();
                                    });
                          }
                        }
                        return const RoundedButton(
                            text: "Sign Up", onTap: null);
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                        child: CustomRichText(
                      text: "Already have an account? ",
                      link: "Login",
                      linkColor: theme.primaryColor,
                      onLinkTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
