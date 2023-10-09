enum SortCriteria {
  Name,
  ExpiryDate,
  Category,
  Inventory,
}

enum FilterBy {
  category,
  inventory,
}

class Settings {
  SortCriteria? sortBy;
  List<String> filteredCatogory;
  List<String> filteredInventory;
  Settings(
      {this.sortBy,
      this.filteredCatogory = const [],
      this.filteredInventory = const []});
}
