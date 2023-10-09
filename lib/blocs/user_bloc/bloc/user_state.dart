part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class ProfilePicUploadingState extends UserState {}

final class ProfilePicUploadedState extends UserState {}

final class ProfilePicUploadErrorState extends UserState {}
