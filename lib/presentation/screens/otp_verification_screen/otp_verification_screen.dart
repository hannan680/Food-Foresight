import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import "../../routes/app_routes.dart";

import '../../widgets/rounded_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _remainingTime = 30;
  late Timer _timer;

  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    // Implement resend code logic here
    setState(() {
      _remainingTime = 30;
      startTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
                  'Verification',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the four-digit code that you received on\nyour email ${widget.email}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      width: 60,
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty && i < 3) {
                            _focusNodes[i + 1].requestFocus();
                          }
                        },
                        onSubmitted: (_) {
                          if (i > 0) {
                            _focusNodes[i - 1].requestFocus();
                          }
                        },
                        onTap: () {
                          _controllers[i].clear();
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 36),
              RoundedButton(
                text: 'Verify Account',
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.resetPassword);
                },
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive an email?\n Resend code in $_remainingTime sec',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              if (_remainingTime == 0)
                TextButton(
                  onPressed: _resendCode,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
