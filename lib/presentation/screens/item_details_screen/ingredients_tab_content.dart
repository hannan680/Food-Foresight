import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/data/models/recipe.dart';
import 'package:food_foresight/data/models/recipe_information.dart';
import 'package:lottie/lottie.dart';

class IngredientsTabContent extends StatelessWidget {
  final RecipeInformation? recipeInfo;
  final bool isLoading;
  final bool isError;
  const IngredientsTabContent(
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
                // ... Previous content ...

                ...recipeInfo!.ingredients.map((ingredient) {
                  return _buildIngredient(ingredient.original);
                }).toList()

                // Add more ingredients here...
              ],
            ),
          )
      ],
    ));
  }
}

Widget _buildIngredient(String ingredient) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        const Icon(
          Icons.add_circle,
          size: 26,
          color: Color.fromRGBO(225, 91, 30, 1),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            ingredient,
            softWrap: false,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
