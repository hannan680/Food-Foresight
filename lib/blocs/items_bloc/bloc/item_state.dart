part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

class LoadingState extends ItemState {}

class SuccessState extends ItemState {}

class DeleteErrorState extends ItemState {}

class ShowDeleteMenuState extends ItemState {}

class HideDeleteMenuState extends ItemState {}
