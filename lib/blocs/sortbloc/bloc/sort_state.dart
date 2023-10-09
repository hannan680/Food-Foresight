part of 'sort_bloc.dart';

@immutable
sealed class SortState {}

final class SortInitial extends SortState {}

final class SortByState extends SortState {
  SortCriteria sortCriteria;

  SortByState({required this.sortCriteria});
}

final class SettingsChangedState extends SortState {
  Settings newSettings;

  SettingsChangedState({required this.newSettings});
}

final class FilterByCategoryState extends SortState {
  List<String> filter;

  FilterByCategoryState({required this.filter});
}

final class FilterByInventoryState extends SortState {
  List<String> filter;

  FilterByInventoryState({required this.filter});
}
