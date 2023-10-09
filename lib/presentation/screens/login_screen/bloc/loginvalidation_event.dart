part of 'loginvalidation_bloc.dart';

@immutable
sealed class LoginvalidationEvent {}

class EmailTextChange extends LoginvalidationEvent {
  String email;

  EmailTextChange({
    required this.email,
  });
}

class PasswordTextChange extends LoginvalidationEvent {
  String password;

  PasswordTextChange({required this.password});
}
