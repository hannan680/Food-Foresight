part of 'auth_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });
}

class ResetPassword extends AuthenticationEvent {
  final String email;

  ResetPassword({
    required this.email,
  });
}

class DeleteAccount extends AuthenticationEvent {
  final String password;
  DeleteAccount({
    required this.password,
  });
}
