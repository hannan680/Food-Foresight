class Recipe {
  final int? id;
  final String? title;

  Recipe({
    required this.id,
    required this.title,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
    );
  }
}
