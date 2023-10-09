import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:food_foresight/data/repository/item_repository.dart';
import 'package:food_foresight/presentation/screens/signup_screen/bloc/signupvalidation_bloc.dart';
import 'package:meta/meta.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc({required this.itemRepository}) : super(ItemInitial()) {
    on<CreateItem>((event, emit) async {
      try {
        print(event.item.name);
        emit(LoadingState());
        await itemRepository.addItem(event.item, event.userId);
        emit(SuccessState());
      } catch (err) {
        print((err.toString()));
      }
    });
    on<UpdatedItem>((event, emit) async {
      try {
        emit(LoadingState());
        await itemRepository.updateItem(event.userId, event.itemId, event.item);
        emit(SuccessState());
      } catch (err) {
        print((err.toString()));
      }
    });

    on<DeleteItem>((event, emit) async {
      try {
        emit(LoadingState());
        await itemRepository.deleteItem(event.userId, event.itemId);
        emit(SuccessState());
      } catch (err) {
        print((err.toString()));
        emit(DeleteErrorState());
      }
    });
    on<ItemInitialEvent>((event, emit) {
      emit(ItemInitial());
    });
  }
}
