part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object?> get props => [];
}

class UpdateInitial extends UpdateState {
  const UpdateInitial();
}

class UpdatingUserProfile extends UpdateState {
  const UpdatingUserProfile();
}

class UserProfileUpdated extends UpdateState {
  final String? userName;
  final String? photoUrl;
  final String message;

  const UserProfileUpdated({
    required this.message,
    required this.userName,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [message, userName, photoUrl];
}

class UploadingAvatar extends UpdateState {
  const UploadingAvatar();
}

class AvatarUploaded extends UpdateState {
  final String? userName;
  final String? photoUrl;
  final String message;

  const AvatarUploaded({
    required this.message,
    required this.userName,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [message, userName, photoUrl];
}

class UploadingAvatarError extends UpdateState {
  final String message;

  const UploadingAvatarError({required this.message});
}

class UploadingProfileError extends UpdateState {
  final String message;

  const UploadingProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
