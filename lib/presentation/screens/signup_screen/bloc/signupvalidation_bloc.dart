import 'package:bloc/bloc.dart';
import 'package:food_foresight/presentation/screens/login_screen/bloc/loginvalidation_bloc.dart';
import 'package:meta/meta.dart';
import "package:email_validator/email_validator.dart";
part 'signupvalidation_event.dart';
part 'signupvalidation_state.dart';

class SignupvalidationBloc
    extends Bloc<SignupvalidationEvent, SignupvalidationState> {
  final fieldsError = FieldsError();
  SignupvalidationBloc() : super(InitialState()) {
    on<NameTextChange>((event, emit) {
      if (event.name.length < 6) {
        fieldsError.nameError = "Name should be greater that 5 characters";
        emit(Error(error: fieldsError));
      } else {
        fieldsError.nameError = null;

        emit(Error(error: fieldsError));
      }
    });
    on<EmailTextChange>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        fieldsError.emailError = "Email is not Valid";
        emit(Error(error: fieldsError));
      } else {
        fieldsError.emailError = null;
        emit(Error(error: fieldsError));
      }
    });
    on<PhoneTextChange>((event, emit) {
      if (event.phone.length < 11) {
        fieldsError.phoneError = "Phone is not Valid";
        emit(Error(error: fieldsError));
      } else {
        fieldsError.phoneError = null;
        emit(Error(error: fieldsError));
      }
    });
    on<PasswordTextChange>((event, emit) {
      if (event.password.length < 8) {
        fieldsError.passwordError =
            "Password should be greater than 7 characters";
        emit(Error(error: fieldsError));
      } else {
        fieldsError.passwordError = null;

        emit(Error(error: fieldsError));
      }
    });
  }
}
