import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HideBottomUiOverlayOnTap extends StatelessWidget {
  const HideBottomUiOverlayOnTap({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
      },
    );
  }
}
