import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:food_foresight/presentation/screens/signup_screen/bloc/signupvalidation_bloc.dart';
import 'package:meta/meta.dart';

part 'loginvalidation_event.dart';
part 'loginvalidation_state.dart';

class LoginvalidationBloc
    extends Bloc<LoginvalidationEvent, LoginvalidationState> {
  LoginvalidationBloc() : super(LoginvalidationInitial()) {
    on<EmailTextChange>((event, emit) {
      if (event.email.isEmpty) {
        emit(FieldsError(emailError: "Email is required"));
      } else {
        emit(FieldsError());
      }
    });
    on<PasswordTextChange>((event, emit) {
      if (event.password.isEmpty) {
        emit(FieldsError(passwordError: "Password is required"));
      } else {
        emit(FieldsError());
      }
    });
  }
}
