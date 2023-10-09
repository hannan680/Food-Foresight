import 'package:flutter/foundation.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/models/sortcriteria.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/model/catogory.dart';

List<Item> sortItems(List<Item> items, SortCriteria? criteria) {
  if (criteria == null) return items;
  switch (criteria) {
    case SortCriteria.Name:
      items.sort((a, b) => a.name!.compareTo(b.name!));
      break;
    case SortCriteria.ExpiryDate:
      items.sort((a, b) => (a.expirationDate ?? DateTime.now())
          .compareTo(b.expirationDate ?? DateTime.now()));
      break;
    case SortCriteria.Category:
      items.sort((a, b) => (a.category ?? '').compareTo(b.category ?? ''));
      break;
    case SortCriteria.Inventory:
      items.sort((a, b) => a.inventory!.compareTo(b.inventory!));
      break;
  }

  return items;
}

List<Item> filterItems(
    List<Item> items, List<String> filterCategories, FilterBy filterBy) {
  return items.where((item) {
    bool isFilter = false;
    if (filterCategories.isEmpty) return true;
    if (filterBy == FilterBy.category) {
      for (String category in filterCategories) {
        if (category == item.category) {
          isFilter = true;
          break;
        }
      }
    }
    if (filterBy == FilterBy.inventory) {
      for (String inventory in filterCategories) {
        print(items);
        print(item.inventory);
        if (inventory == item.inventory) {
          isFilter = true;
          break;
        }
      }
    }
    return isFilter;
  }).toList();
}
