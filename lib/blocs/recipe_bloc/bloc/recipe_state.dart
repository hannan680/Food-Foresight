part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<Recipe> recipes;

  RecipeLoaded(this.recipes);
}

class RecipeInformationLoaded extends RecipeState {
  final RecipeInformation recipeInfo;

  RecipeInformationLoaded(this.recipeInfo);
}

class RecipeNutrientLoaded extends RecipeState {
  final List<Nutrient> nutrients;

  RecipeNutrientLoaded(this.nutrients);
}

class RecipeSearchLoaded extends RecipeState {
  final List<Recipe> recipes;

  RecipeSearchLoaded(this.recipes);
}

class RecipeError extends RecipeState {
  final String error;

  RecipeError(this.error);
}

class NutrientError extends RecipeState {
  final String error;

  NutrientError(this.error);
}

class RecipeLoading extends RecipeState {}

class NutrientLoading extends RecipeState {}
