class Nutrient {
  final String name;
  final double amount;
  final String unit;
  final double percentOfDailyNeeds;

  Nutrient({
    required this.name,
    required this.amount,
    required this.unit,
    required this.percentOfDailyNeeds,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    // print(json)
    return Nutrient(
      name: json['name'],
      amount: json['amount'].toDouble(),
      unit: json['unit'],
      percentOfDailyNeeds: json['percentOfDailyNeeds'].toDouble(),
    );
  }
}

class NutrientPercentages {
  final double fatPercentage;
  final double proteinPercentage;
  final double carbohydratesPercentage;

  NutrientPercentages({
    required this.fatPercentage,
    required this.proteinPercentage,
    required this.carbohydratesPercentage,
  });
}
