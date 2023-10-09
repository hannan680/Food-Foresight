part of 'add_item_bloc.dart';

abstract class AddItemState {}

final class AddItemInitial extends AddItemState {
  final Item item;
  AddItemInitial(this.item);
}

class InventorySelectedState extends AddItemState {
  final String inventoryType;
  InventorySelectedState(this.inventoryType);
}

class SelectedItem extends AddItemState {
  final Item item;
  SelectedItem(this.item);
}

class StorageSelectedState extends AddItemState {
  final String storageType;
  StorageSelectedState(this.storageType);
}

class ContentSelectedState extends AddItemState {
  final String contentType;
  ContentSelectedState(this.contentType);
}

class CategorySelectedState extends AddItemState {
  final String categoryType;
  CategorySelectedState(this.categoryType);
}

class ExpirationDateSelectedState extends AddItemState {
  final DateTime? expiryDate;
  ExpirationDateSelectedState(this.expiryDate);
}

class ExpiryDatePlus3DaysSelectedState extends AddItemState {
  final DateTime expiryDate;

  ExpiryDatePlus3DaysSelectedState(this.expiryDate);
}

class ExpiryDatePlus14DaysSelectedState extends AddItemState {
  final DateTime expiryDate;

  ExpiryDatePlus14DaysSelectedState(this.expiryDate);
}

class ExpiryDateNoneSelectedState extends AddItemState {}
