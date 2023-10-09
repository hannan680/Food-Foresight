import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'This Privacy Policy outlines how we collect, use, store, and protect your personal information when you use our recipe app.',
            ),
            const SizedBox(height: 16),
            Text(
              'Agreement to Terms: By using the Food Foresight app, you agree to be bound by these terms of service, which may be updated by Food Foresight at any time without notice.',
            ),
            const SizedBox(height: 16),
            // Add more text sections here...

            Text(
              'By using the Food Foresight app, you agree to be bound by these terms of service, which may be updated by Food Foresight at any time without notice.',
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: PrivacyPolicyScreen()));
}
