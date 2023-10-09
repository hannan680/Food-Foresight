import 'package:flutter/material.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import '../../widgets/rounded_button.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/empty_placeholder.png"),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'You wil see your food list here..\n but the list is empty.\nTap scan Button to add Food',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
