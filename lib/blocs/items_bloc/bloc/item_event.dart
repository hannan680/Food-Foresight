part of 'item_bloc.dart';

@immutable
sealed class ItemEvent {}

class CreateItem extends ItemEvent {
  final Item item;
  final String userId;
  CreateItem(this.item, this.userId);
}

class UpdatedItem extends ItemEvent {
  final Item item;
  final String userId;
  final String itemId;
  UpdatedItem(
    this.userId,
    this.itemId,
    this.item,
  );
}

class DeleteItem extends ItemEvent {
  final String userId;
  final String itemId;

  DeleteItem({required this.userId, required this.itemId});
}

class ItemInitialEvent extends ItemEvent {}
