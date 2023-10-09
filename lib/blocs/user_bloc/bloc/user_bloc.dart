import 'package:bloc/bloc.dart';
import 'package:food_foresight/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<UpdateProfilePic>((event, emit) {
      try {
        emit(ProfilePicUploadingState());
        userRepository.updateProfilePicture(event.imagePath);
        emit(ProfilePicUploadedState());
      } catch (e) {
        emit(ProfilePicUploadErrorState());
      }
    });
  }
}
