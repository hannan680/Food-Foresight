import 'package:flutter/material.dart';
import 'rounded_button.dart';

class AlertBox extends StatelessWidget {
  final Widget icon;
  final String heading;
  final String description;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AlertBox(
      {required this.icon,
      required this.heading,
      required this.description,
      required this.buttonText,
      required this.onButtonPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.black54,
      child: Center(
        child: SizedBox(
          width: 500,
          child: Container(
            padding: const EdgeInsets.all(26),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(height: 16),
                Text(
                  heading,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 150,
                  child: RoundedButton(
                    text: buttonText,
                    onTap: onButtonPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
