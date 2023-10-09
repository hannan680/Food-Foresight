part of 'sort_bloc.dart';

@immutable
sealed class SortEvent {}

class SortBy extends SortEvent {
  SortCriteria sortCriteria;
  SortBy({required this.sortCriteria});
}

class FilterByCategory extends SortEvent {
  List<String> filter;
  FilterByCategory({required this.filter});
}

class FilterByInventory extends SortEvent {
  List<String> filter;
  FilterByInventory({required this.filter});
}
