import 'package:flutter/material.dart';

class FoodItemCard extends StatelessWidget {
  final String description;
  final String title;
  const FoodItemCard({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.grey.withOpacity(.3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
