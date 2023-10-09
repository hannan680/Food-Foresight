part of 'loginvalidation_bloc.dart';

@immutable
sealed class LoginvalidationState {}

final class LoginvalidationInitial extends LoginvalidationState {}

class FieldsError extends LoginvalidationState {
  String? emailError;
  String? passwordError;

  FieldsError({
    this.emailError,
    this.passwordError,
  });
}
