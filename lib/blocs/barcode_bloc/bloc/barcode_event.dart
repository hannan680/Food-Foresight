part of 'barcode_bloc.dart';

@immutable
sealed class BarcodeEvent {}

class LookupBarcodeEvent extends BarcodeEvent {
  final String barcode;

  LookupBarcodeEvent(this.barcode);
}
