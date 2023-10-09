part of 'add_item_bloc.dart';

@immutable
sealed class AddItemEvent {}

class NameTextChange extends AddItemEvent {
  final String name;
  NameTextChange(this.name);
}

class InventorySelected extends AddItemEvent {
  final String inventoryType;
  bool update;
  InventorySelected(this.inventoryType, {this.update = false});
}

class ClearItem extends AddItemEvent {}

class QuantitySelected extends AddItemEvent {
  final String quantityType;
  QuantitySelected(this.quantityType);
}

class StorageSelected extends AddItemEvent {
  final String storageType;

  StorageSelected(this.storageType);
}

class ContentSelected extends AddItemEvent {
  final String contentType;

  ContentSelected(this.contentType);
}

class CatogorySelected extends AddItemEvent {
  final String catogoryType;

  CatogorySelected(this.catogoryType);
}

class ExpirationDateSelected extends AddItemEvent {
  final DateTime? expiryDate;

  ExpirationDateSelected(this.expiryDate);
}

class ExpiryDatePlus3DaysSelected extends AddItemEvent {}

class ExpiryDatePlus14DaysSelected extends AddItemEvent {}

class ExpiryDateNoneSelected extends AddItemEvent {}
