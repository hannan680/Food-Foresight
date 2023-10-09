import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color fontColor;
  final bool border;
  final String text;
  final Size? minSize;
  final Size? maxSize;
  final double elevation;
  final double fontSize;
  final VoidCallback? onTap;
  final Widget? leading;

  const RoundedButton(
      {this.color = const Color.fromRGBO(225, 91, 30, 1),
      this.border = false,
      this.borderColor = const Color.fromRGBO(225, 91, 30, 1),
      this.fontColor = Colors.white,
      this.elevation = 3,
      required this.text,
      required this.onTap,
      this.leading,
      this.fontSize = 18,
      this.minSize,
      this.maxSize,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        minimumSize: minSize,
        maximumSize: maxSize,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: border ? BorderSide(color: borderColor) : BorderSide.none),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
