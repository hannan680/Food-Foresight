import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/models/nutrient.dart';
import 'package:food_foresight/data/models/recipe_information.dart';
import 'package:food_foresight/data/repository/recipe_repository.dart';
import 'package:meta/meta.dart';
import '../../../data/models/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeRepository recipeRepository;
  RecipeBloc(this.recipeRepository) : super(RecipeInitial()) {
    on<GetRandomRecipe>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(RecipeLoading());

        final randomRecipe = await recipeRepository.getRandomRecipes();
        emit(RecipeLoaded(randomRecipe));
      } catch (e) {
        emit(RecipeError('Failed to load recipe: $e'));
      }
    });
    on<GetRecipeInformation>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(RecipeLoading());
        final recipeInfo =
            await recipeRepository.getRecipeInformation(event.id);

        emit(RecipeInformationLoaded(recipeInfo));
      } catch (e) {
        emit(RecipeError('Failed to load recipe: $e'));
      }
    });
    on<GetRecipeNutrients>((event, emit) async {
      // TODO: implement event handler
      try {
        emit(NutrientLoading());
        final recipeInfo = await recipeRepository.getRecipeNutrients(event.id);
        emit(RecipeNutrientLoaded(recipeInfo));
      } catch (e) {
        print(e);
        emit(NutrientError('Failed to load recipe:'));
      }
    });
    on<SearchRecipe>((event, emit) async {
      // TODO: implement event handler
      try {
        if (event.query == "") {
          final randomRecipe = await recipeRepository.getRandomRecipes();
          emit(RecipeLoaded(randomRecipe));
        } else {
          final searchedRecipe =
              await recipeRepository.searchRecipes(event.query);

          emit(RecipeSearchLoaded(searchedRecipe));
        }
      } catch (e) {
        emit(RecipeError('Failed to load recipe: $e'));
      }
    });
  }
}
