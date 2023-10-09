class Item {
  String? id;
  String? name;
  String? inventory;
  DateTime? expirationDate;
  String? category;
  String? quantity;
  String? storage;
  String? content;

  Item({
    this.id,
    this.name,
    this.inventory,
    this.expirationDate,
    this.category,
    this.quantity,
    this.storage,
    this.content,
  });

  factory Item.fromJson(Map<String, dynamic> json, String id) {
    return Item(
      id: id,
      name: json['name'],
      inventory: json['inventory'],
      expirationDate: json['expirationDate'] != null
          ? DateTime.parse(json['expirationDate'])
          : null,
      category: json['category'],
      quantity: json['quantity'],
      storage: json['storage'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'name': name,
      'inventory': inventory,
      'expirationDate': expirationDate?.toIso8601String(),
      'category': category,
      'quantity': quantity,
      'storage': storage,
      'content': content,
    };
  }

  Item clone() {
    return Item(
      id: id,
      name: name,
      inventory: inventory,
      expirationDate: expirationDate,
      category: category,
      quantity: quantity,
      storage: storage,
      content: content,
    );
  }
}
