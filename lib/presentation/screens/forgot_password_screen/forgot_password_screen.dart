import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import "../../routes/app_routes.dart";

import '../../widgets/custom_form_field.dart';
import '../../widgets/rounded_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.loading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state.status == AuthenticationStatus.unauthenticated) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Password reset link sent to your email: ${_emailController.text}")));
        }
        if (state.status == AuthenticationStatus.error) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
        // TODO: implement listener
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your email for the verification process.\nWe will send a four-digit code to your email.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  controller: _emailController,
                  label: 'Email',
                  prefixIcon: Icons.email,
                  hintText: "Email",
                ),
                const SizedBox(height: 16),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : RoundedButton(
                        text: "Send Verification Code",
                        onTap: () {
                          print(_emailController.text);
                          context.read<AuthenticationBloc>().add(ResetPassword(
                              email: _emailController.text.trim()));
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
