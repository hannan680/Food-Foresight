import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/repository/barcode_repository.dart';
import 'package:meta/meta.dart';

part 'barcode_event.dart';
part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  final BarcodeRepository repository;

  BarcodeBloc(this.repository) : super(BarcodeInitial()) {
    on<LookupBarcodeEvent>((event, emit) async {
      try {
        final barcodeInfo = await repository.lookupBarcode(event.barcode);

        print(barcodeInfo['products'][0]['title']);
        // emit(BarcodeLoadedState(barcodeInfo['products'][0]['title']));
      } catch (e) {
        // print(e);
        emit(BarcodeNotLoadedState());
        print("gettin error");
      }
    });
  }
}
