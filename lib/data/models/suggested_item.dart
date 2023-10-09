class Suggestion {
  final String name;
  final String category;
  final String expirationDate;

  Suggestion({
    required this.name,
    required this.category,
    required this.expirationDate,
  });

  factory Suggestion.fromJson(json) {
    return Suggestion(
        name: json['name'],
        category: json['category'],
        expirationDate: json['expirationDate']);
  }
}
