part of 'suggestions_bloc.dart';

@immutable
sealed class SuggestionsEvent {}

class GetSuggestions extends SuggestionsEvent {}
