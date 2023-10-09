part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UpdateProfilePic extends UserEvent {
  final String imagePath;
  UpdateProfilePic(this.imagePath);
}
