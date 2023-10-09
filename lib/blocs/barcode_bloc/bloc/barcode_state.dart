part of 'barcode_bloc.dart';

@immutable
sealed class BarcodeState {}

final class BarcodeInitial extends BarcodeState {}

class BarcodeLoadedState extends BarcodeState {
  final String barcodeInfoName;

  BarcodeLoadedState(this.barcodeInfoName);
}

class BarcodeNotLoadedState extends BarcodeState {
  BarcodeNotLoadedState();
}

class BarcodeErrorState extends BarcodeState {
  final String error;
  BarcodeErrorState(this.error);
}
