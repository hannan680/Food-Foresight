part of 'suggestions_bloc.dart';

@immutable
sealed class SuggestionsState {}

final class SuggestionsInitial extends SuggestionsState {}

class GetSuggestionsState extends SuggestionsState {
  final List<Suggestion> suggestion;
  GetSuggestionsState(this.suggestion);
}
