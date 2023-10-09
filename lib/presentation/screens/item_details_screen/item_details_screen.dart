import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/data/models/nutrient.dart';
import 'package:food_foresight/data/models/recipe_information.dart';
import './recipe_tab_content.dart';
import './ingredients_tab_content.dart';
import './nutrition_tab_content.dart';

class ItemDetailsScreen extends StatefulWidget {
  const ItemDetailsScreen({super.key});
  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String recipeId;
  late String title;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeBloc>().add(GetRecipeInformation(recipeId));
      context.read<RecipeBloc>().add(GetRecipeNutrients(recipeId));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  RecipeInformation? recipeInfo;
  bool isLoading = false;
  bool isError = false;
  List<Nutrient>? nutrients;
  bool isNutrientsLoading = false;
  bool isNutrientsError = false;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      recipeId = args['id'];
      title = args['title'];
    } else {
      recipeId = '';
    }
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RecipeBloc, RecipeState>(
        listener: (context, state) {
          if (state is RecipeInformationLoaded) {
            isLoading = false;
            recipeInfo = state.recipeInfo;
            setState(() {});
          }

          if (state is RecipeLoading) {
            isLoading = true;
            setState(() {});
          }

          if (state is RecipeError) {
            isLoading = false;

            isError = true;
            setState(() {});
          }
          if (state is NutrientLoading) {
            isNutrientsLoading = true;
            setState(() {});
          }
          if (state is NutrientError) {
            isLoading = false;
            isError = true;
            setState(() {});
          }

          if (state is RecipeNutrientLoaded) {
            isNutrientsLoading = false;
            nutrients = state.nutrients;
            setState(() {});
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              // Color of the indicator line
              tabs: const [
                Tab(
                  text: 'Recipe',
                ),
                Tab(text: 'Ingredients'),
                Tab(text: 'Nutrition'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PageStorage(
                      bucket: PageStorageBucket(),
                      child: RecipeTabContent(
                        isLoading: isLoading,
                        isError: isError,
                        recipeInfo: recipeInfo,
                      )),
                  PageStorage(
                      bucket: PageStorageBucket(),
                      child: IngredientsTabContent(
                        isLoading: isLoading,
                        isError: isError,
                        recipeInfo: recipeInfo,
                      )),
                  PageStorage(
                    bucket: PageStorageBucket(),
                    child: NutritionTabContent(
                      isLoading: isNutrientsLoading,
                      isError: isNutrientsError,
                      nutrients: nutrients,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
