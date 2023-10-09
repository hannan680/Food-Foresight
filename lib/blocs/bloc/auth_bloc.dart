import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  AuthenticationBloc({required this.authRepository})
      : super(
            AuthenticationState(status: AuthenticationStatus.unauthenticated)) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthenticationState(status: AuthenticationStatus.loading));

      try {
        await authRepository.signUp(
            email: event.email,
            password: event.password,
            name: event.name,
            phone: event.phone);
        emit(AuthenticationState(status: AuthenticationStatus.authenticated));
      } on Exception catch (err) {
        print("form bloc..............................");
        print(err.toString());
        emit(AuthenticationState(
            status: AuthenticationStatus.error, errorMessage: err.toString()));
      }
    });
    on<SignInRequested>((event, emit) async {
      emit(AuthenticationState(status: AuthenticationStatus.loading));
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthenticationState(status: AuthenticationStatus.authenticated));
      } on Exception catch (err) {
        print("form bloc..............................");
        print(err.toString());
        emit(AuthenticationState(
            status: AuthenticationStatus.error, errorMessage: err.toString()));
      }
    });
    on<ResetPassword>((event, emit) async {
      emit(AuthenticationState(status: AuthenticationStatus.loading));
      try {
        await authRepository.resetPassword(
          event.email,
        );
        emit(AuthenticationState(status: AuthenticationStatus.unauthenticated));
      } on Exception catch (err) {
        print("form bloc..............................");
        print(err.toString());
        emit(AuthenticationState(
            status: AuthenticationStatus.error, errorMessage: err.toString()));
      }
    });
    on<DeleteAccount>((event, emit) async {
      emit(AuthenticationState(status: AuthenticationStatus.loading));
      try {
        await authRepository.deleteAccount(
          event.password,
        );
        emit(AuthenticationState(status: AuthenticationStatus.unauthenticated));
      } on Exception catch (err) {
        print("form bloc..............................");
        print(err.toString());
        emit(AuthenticationState(
            status: AuthenticationStatus.error, errorMessage: err.toString()));
      }
    });
  }
}
