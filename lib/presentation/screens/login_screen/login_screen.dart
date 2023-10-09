import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/presentation/screens/login_screen/bloc/loginvalidation_bloc.dart';
import 'package:food_foresight/presentation/widgets/alertbox.dart';
import "../../routes/app_routes.dart";

import '../../widgets/custom_richtext.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();
  final _loginBloc = LoginvalidationBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final authBlocListner = context.watch<AuthenticationBloc>();

    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
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
                    onButtonPressed: () => Navigator.of(context).pop(),
                  );
                });
          }
          if (state.status == AuthenticationStatus.authenticated) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacementNamed(
                context, AppRoutes.bottomNavigationScreen);
          }
        },
        child: Center(
          child: SizedBox(
            height: mediaQuery.viewInsets.bottom <= 0
                ? mediaQuery.size.height
                : null,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Image.asset(
                        'assets/images/login.png', // Change the image path accordingly
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please sign in to continue.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginvalidationBloc, LoginvalidationState>(
                      builder: (context, state) {
                        return CustomFormField(
                          onChange: (val) {
                            context
                                .read<LoginvalidationBloc>()
                                .add(EmailTextChange(email: val));
                          },
                          errorText:
                              state is FieldsError ? state.emailError : null,
                          controller: _emailController,
                          label: 'Email',
                          prefixIcon: Icons.email,
                          hintText: "Email",
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<LoginvalidationBloc, LoginvalidationState>(
                      builder: (context, state) {
                        return CustomFormField(
                          isObsureText: true,
                          onChange: (val) {
                            context
                                .read<LoginvalidationBloc>()
                                .add(PasswordTextChange(password: val));
                          },
                          errorText:
                              state is FieldsError ? state.passwordError : null,
                          controller: _passwordController,
                          label: 'Password',
                          prefixIcon: Icons.lock,
                          hintText: "Password",
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.forgotPassword);
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 14, color: theme.primaryColor),
                            ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    // if (mediaQuery.viewInsets.bottom <= 0) const Spacer(),
                    BlocBuilder<LoginvalidationBloc, LoginvalidationState>(
                      builder: (context, state) {
                        if (state is FieldsError) {
                          if (_emailController.text != "" &&
                              _passwordController.text != "") {
                            return authBlocListner.state.status ==
                                    AuthenticationStatus.loading
                                ? const RoundedButton(
                                    text: "Signing In...", onTap: null)
                                : RoundedButton(
                                    text: "Sign In",
                                    onTap: () {
                                      context.read<AuthenticationBloc>().add(
                                          SignInRequested(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text));
                                    });
                          }
                        }
                        return const RoundedButton(
                            text: "Sign In", onTap: null);
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: CustomRichText(
                        text: "Don't have an account? ",
                        link: "Sign Up",
                        linkColor: theme.primaryColor,
                        onLinkTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.signup);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
