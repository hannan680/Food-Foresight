import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<RecipeBloc>().add(GetRandomRecipe());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Food Foresight",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.notificationScreen);
                      },
                      child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.settings,
                            // color: ,
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomSearchBar(
                  onChanged: (val) {
                    context.read<RecipeBloc>().add(SearchRecipe(val));
                  },
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<RecipeBloc, RecipeState>(
                buildWhen: (prevState, curState) {
                  return curState is RecipeInitial ||
                      curState is RecipeError ||
                      curState is RecipeLoaded ||
                      curState is RecipeSearchLoaded;
                },
                builder: (context, state) {
                  if (state is RecipeInitial) {
                    // Initial state, you can show a loading indicator or initial UI
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );
                  } else if (state is RecipeLoaded) {
                    final recipes = state.recipes;
                    // Use the recipe data to display in your UI
                    return Expanded(
                      child: ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                      AppRoutes.itemDetailsScreen,
                                      arguments: {
                                        'id':
                                            state.recipes[index].id.toString(),
                                        'title': state.recipes[index].title
                                      }),
                              child: ItemTile(item: recipes[index].title!));
                        },
                      ),
                    );
                  } else if (state is RecipeError) {
                    return Lottie.asset('assets/lottie/wentwrong.json');
                  } else if (state is RecipeSearchLoaded) {
                    final recipes = state.recipes;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                      AppRoutes.itemDetailsScreen,
                                      arguments: {
                                        'id':
                                            state.recipes[index].id.toString(),
                                        'title': state.recipes[index].title
                                      }),
                              child: ItemTile(item: recipes[index].title!));
                        },
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final String item;

  ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              size: 24,
            ),
            title: Text(
              item,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}

List<String> items = [
  'Item 1',
  'Item 2',
  'Item 3',
  // Add more items here
];
