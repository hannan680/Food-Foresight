import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/data/models/recipe_information.dart';
import 'package:lottie/lottie.dart';

class RecipeTabContent extends StatelessWidget {
  final RecipeInformation? recipeInfo;
  final bool isLoading;
  final bool isError;
  const RecipeTabContent(
      {super.key,
      this.isLoading = false,
      this.isError = false,
      this.recipeInfo});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isLoading)
            LinearProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          if (isError)
            Center(
              child: Lottie.asset('assets/lottie/wentwrong.json'),
            ),
          if (recipeInfo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem(
                            icon: Icons.star,
                            title: 'Health Score',
                            subtitle: recipeInfo!.healthScore.toString(),
                          ),
                          const SizedBox(width: 20),
                          _buildInfoItem(
                            icon: Icons.room_service,
                            title: 'Servings',
                            subtitle: recipeInfo!.servings.toString(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoItem(
                            icon: Icons.fireplace,
                            title: 'Price per serving',
                            subtitle: recipeInfo!.pricePerServing.toString(),
                          ),
                          SizedBox(width: 20),
                          _buildInfoItem(
                            icon: Icons.timer,
                            title: 'Ready in minutes',
                            subtitle: recipeInfo!.readyInMinutes.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Details about Recipe',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    recipeInfo!.summary,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

Widget _buildInfoItem(
    {required IconData icon,
    Color iconColor = const Color.fromRGBO(225, 91, 30, 1),
    required String title,
    required String subtitle}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(subtitle),
          ],
        ),
      ],
    ),
  );
}
