import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback onLinkTap;
  final Color linkColor;
  final Color textColor;
  const CustomRichText(
      {super.key,
      required this.text,
      required this.link,
      required this.onLinkTap,
      this.linkColor = Colors.blue,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(color: textColor),
          ),
          TextSpan(
            text: link,
            style: TextStyle(
              color: linkColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onLinkTap,
          ),
        ],
      ),
    );
  }
}
