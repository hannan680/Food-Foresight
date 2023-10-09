import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String heading;
  final String description;
  final String imagePath;

  const OnboardingPage(
      {required this.heading,
      required this.description,
      required this.imagePath,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 200,
        ),
        const SizedBox(height: 16),
        Text(
          heading,
          style: const TextStyle(
            color: Color.fromRGBO(225, 91, 30, 1),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
