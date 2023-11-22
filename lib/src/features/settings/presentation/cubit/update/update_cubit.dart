import 'dart:io';

import 'package:chat_rooms/core/utils/app_strings.dart';
import 'package:chat_rooms/core/utils/pick_photo.dart';
import 'package:chat_rooms/core/utils/upload_photo.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/user/user_auth_cubit.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/update_user_profile.dart';
import 'package:chat_rooms/src/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

part 'update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  final UpdateUserProfile _updateUserProfile;

  UpdateCubit({required UpdateUserProfile updateUserProfile})
      : _updateUserProfile = updateUserProfile,
        super(const UpdateInitial());

  Future<void> updateUserProfile({
    required String userId,
    required BuildContext context,
    String? photo,
    String? name,
    String? bio,
  }) async {
    photo ?? emit(const UpdatingUserProfile());
    final result = await _updateUserProfile(
      userId: userId,
      name: name,
      bio: bio,
      photo: photo,
    );
    result.fold(
      (failure) => emit(UploadingProfileError(message: failure.message)),
      (r) {
        photo == null
            ? emit( UserProfileUpdated(message: USER_PROFILE_UPDATED, userName: name,photoUrl: photo))
            : emit( AvatarUploaded(message: USER_AVATAR_UPLOADED, userName: name,photoUrl: photo));
        context.read<SettingsCubit>().getUserProfile(userId);
      },
    );
  }

  Future<String> pickPhotoThenUpload(
    BuildContext context,
    String userId,
  ) async {
    File? image = await PickPhoto.pickPhoto(context);
    String photoLink = '';
    if (image != null) {
      photoLink = await uploadPhoto(
        image: image,
        path: '$PHOTOS_PATH/$userId/${basename(image.path)}',
      );
      if (photoLink.isNotEmpty && context.mounted) {
        await updateUserProfile(
          userId: userId,
          photo: photoLink,
          context: context,
        );
      }
    }
    return Future(() => photoLink);
  }

  Future<String> uploadPhoto({
    required File image,
    required String path,
  }) async {
    emit(const UploadingAvatar());
    final result = await UploadPhoto.uploadPhoto(image: image, path: path);
    result.fold(
      (failure) => emit(UploadingAvatarError(message: failure.message)),
      (_) => null,
    );
    return result.getOrElse(() => '');
  }
}
