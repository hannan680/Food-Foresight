import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/mock/suggested_items.dart';
import 'package:food_foresight/data/models/suggested_item.dart';
import 'package:meta/meta.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  SuggestionsBloc() : super(SuggestionsInitial()) {
    on<GetSuggestions>((event, emit) {
      // TODO: implement event handler
      const data = suggestedItems;
      List<Suggestion> suggestions =
          data.map((json) => Suggestion.fromJson(json)).toList();
      emit(GetSuggestionsState(suggestions));
    });
  }
}
