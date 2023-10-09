part of 'signupvalidation_bloc.dart';

@immutable
sealed class SignupvalidationState {}

class FieldsError {
  String? nameError;
  String? emailError;
  String? phoneError;
  String? passwordError;

  FieldsError({
    this.nameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
  });
}

class Error extends SignupvalidationState {
  final FieldsError? error;

  Error({
    this.error,
  });
}

class InitialState extends SignupvalidationState {}
