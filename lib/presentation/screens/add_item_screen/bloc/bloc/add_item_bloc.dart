import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:meta/meta.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  Item item = Item();
  AddItemBloc() : super(AddItemInitial(Item())) {
    on<ClearItem>((event, emit) {
      // TODO: implement event handler
      print("cleared");
      item = Item();
    });
    on<NameTextChange>((event, emit) {
      // TODO: implement event handler
      item.name = event.name;
      print(item.name);
    });
    on<InventorySelected>((event, emit) {
      // TODO: implement event handler
      item.inventory = event.inventoryType;
      print(item.inventory);
    });
    on<QuantitySelected>((event, emit) {
      // TODO: implement event handler

      print('triggerred==========================');

      item.quantity = event.quantityType;
      print(item.quantity);
      emit(SelectedItem(item));
    });
    on<StorageSelected>((event, emit) {
      // TODO: implement event handler
      item.storage = event.storageType;
      emit(SelectedItem(item));
      print("emitted");
    });
    on<ContentSelected>((event, emit) {
      // TODO: implement event handler
      item.content = event.contentType;
      emit(SelectedItem(item));
    });
    on<CatogorySelected>((event, emit) {
      // TODO: implement event handler
      item.category = event.catogoryType;
      emit(SelectedItem(item));
    });
    on<ExpirationDateSelected>((event, emit) {
      // TODO: implement event handler
      item.expirationDate = event.expiryDate;

      emit(ExpirationDateSelectedState(event.expiryDate));
    });
    on<ExpiryDatePlus3DaysSelected>((event, emit) {
      // TODO: implement event handler
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 3));
      item.expirationDate = futureDate;
      print("go it--------------------");
      emit(ExpiryDatePlus3DaysSelectedState(futureDate));
    });
    on<ExpiryDatePlus14DaysSelected>((event, emit) {
      // TODO: implement event handler
      DateTime now = DateTime.now();
      DateTime futureDate = now.add(Duration(days: 14));
      item.expirationDate = futureDate;
      print("go it--------------------");
      emit(ExpiryDatePlus14DaysSelectedState(futureDate));
    });
    on<ExpiryDateNoneSelected>((event, emit) {
      // TODO: implement event handler

      item.expirationDate = null;
      print("go it--------------------");
      emit(ExpiryDateNoneSelectedState());
    });
  }
}
