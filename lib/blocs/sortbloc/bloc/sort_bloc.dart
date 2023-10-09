import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/models/sortcriteria.dart';
import 'package:meta/meta.dart';

part 'sort_event.dart';
part 'sort_state.dart';

class SortBloc extends Bloc<SortEvent, SortState> {
  Settings settings;

  SortBloc({required this.settings}) : super(SortInitial()) {
    on<SortBy>((event, emit) {
      // TODO: implement event handler
      settings.sortBy = event.sortCriteria;
      emit(SettingsChangedState(newSettings: settings));
    });
    on<FilterByCategory>((event, emit) {
      // TODO: implement event handler
      // settings.sortBy = event.sortCriteria;
      settings.filteredCatogory = event.filter;
      emit(SettingsChangedState(newSettings: settings));
    });
    on<FilterByInventory>((event, emit) {
      // TODO: implement event handler
      // settings.sortBy = event.sortCriteria;

      settings.filteredInventory = event.filter;
      emit(SettingsChangedState(newSettings: settings));
    });
  }
}
