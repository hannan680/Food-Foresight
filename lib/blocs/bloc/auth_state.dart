part of 'auth_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthenticationState {
  final AuthenticationStatus status;
  final String? errorMessage;

  AuthenticationState({
    required this.status,
    this.errorMessage,
  });
}
