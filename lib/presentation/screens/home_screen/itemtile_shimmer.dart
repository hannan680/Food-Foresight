import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemTileShimmer extends StatelessWidget {
  const ItemTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Choose your desired base color
      highlightColor: Colors.grey[100]!, // Choose your desired highlight color
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
