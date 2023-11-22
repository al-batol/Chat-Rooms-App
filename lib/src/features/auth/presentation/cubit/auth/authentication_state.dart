part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class UserCreated extends AuthenticationState {
  final String message;

  const UserCreated({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}

class PickingPhoto extends AuthenticationState {
  const PickingPhoto();
}

class PickedPhoto extends AuthenticationState {
  const PickedPhoto();
}

class UploadingPhoto extends AuthenticationState {
  const UploadingPhoto();
}

class PhotoUploaded extends AuthenticationState {
  const PhotoUploaded();
}

class SignedIn extends AuthenticationState {
  final entity.User? user;
  final String message;

  const SignedIn({this.user, required this.message});

  @override
  List<Object> get props => [message];
}
