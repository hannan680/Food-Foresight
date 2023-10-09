class RecipeInformation {
  final int servings;
  final double pricePerServing;
  final int healthScore;
  final int readyInMinutes;
  final String title;
  final String summary;
  final List<Ingredient> ingredients;

  RecipeInformation({
    required this.servings,
    required this.pricePerServing,
    required this.healthScore,
    required this.readyInMinutes,
    required this.title,
    required this.summary,
    required this.ingredients,
  });

  factory RecipeInformation.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = (json['extendedIngredients'] as List)
        .map((ingredient) => Ingredient.fromJson(ingredient))
        .toList();
    // final info = RecipeInformation(
    //   servings: json['servings'],
    //   spoonacularScore: json['spoonacularScore'].toDouble(),
    //   readyInMinutes: json['readyInMinutes'],
    //   title: json['title'],
    //   summary: json['summary'],
    //   ingredients: ingredients,
    // );
    print("recipe info====================");
    print(json['spoonacularScore']);
    print(json['readyInMinutes']);
    print(json['title']);
    print(json['summary'].replaceAll(RegExp(r'<[^>]+>'), ''));

    return RecipeInformation(
      servings: json['servings'],
      pricePerServing: json['pricePerServing'],
      healthScore: json['healthScore'],
      readyInMinutes: json['readyInMinutes'],
      title: json['title'],
      summary: json['summary'].replaceAll(RegExp(r'<[^>]+>'), ''),
      ingredients: ingredients,
    );
  }
}

class Ingredient {
  final int id;
  final String aisle;
  final String image;
  final String consistency;
  final String name;
  final String nameClean;
  final String original;
  final String originalName;
  final double amount;
  final String unit;
  final List<String> meta;

  Ingredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalName: json['originalName'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
      meta: List<String>.from(json['meta']),
    );
  }
}
