import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/rounded_button.dart';
import '../../widgets/alertbox.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Set the new password for your account so\n you can login and access all features.',
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              const CustomFormField(
                label: 'Password',
                prefixIcon: Icons.password,
                hintText: "Password",
              ),
              const SizedBox(height: 36),
              const CustomFormField(
                label: 'Confirm Password',
                prefixIcon: Icons.password,
                hintText: "Confirm Password",
              ),
              const SizedBox(height: 36),
              RoundedButton(
                text: 'Reset Password',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertBox(
                            icon: Image.asset("assets/images/success.png"),
                            heading: "Reset password successfull",
                            description: "Your password succesfully changed",
                            buttonText: "Go to home",
                            onButtonPressed: () {});
                      });
                  // Perform password reset logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final String hintText;

  const CustomFormField({
    required this.label,
    required this.prefixIcon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
