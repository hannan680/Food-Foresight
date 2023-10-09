part of 'signupvalidation_bloc.dart';

abstract class SignupvalidationEvent {}

class NameTextChange extends SignupvalidationEvent {
  String name;

  NameTextChange({
    required this.name,
  });
}

class EmailTextChange extends SignupvalidationEvent {
  String email;

  EmailTextChange({
    required this.email,
  });
}

class PhoneTextChange extends SignupvalidationEvent {
  String phone;

  PhoneTextChange({
    required this.phone,
  });
}

class PasswordTextChange extends SignupvalidationEvent {
  String password;

  PasswordTextChange({
    required this.password,
  });
}
