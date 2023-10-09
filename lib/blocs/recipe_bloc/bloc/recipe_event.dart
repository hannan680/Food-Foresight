part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class GetRandomRecipe extends RecipeEvent {}

class GetRecipeInformation extends RecipeEvent {
  final String id;
  GetRecipeInformation(this.id);
}

class GetRecipeNutrients extends RecipeEvent {
  final String id;
  GetRecipeNutrients(this.id);
}

class SearchRecipe extends RecipeEvent {
  final String query;
  SearchRecipe(this.query);
}
