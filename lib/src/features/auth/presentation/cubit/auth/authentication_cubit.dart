import 'dart:io';

import 'package:chat_rooms/core/utils/app_strings.dart';
import 'package:chat_rooms/core/utils/upload_photo.dart';
import 'package:chat_rooms/core/utils/pick_photo.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/create_user_with_email_and_password.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/get_user_changes.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/set_user_data.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/sing_in_with_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart'
    as entity;

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUserWithEmailAndPassword _createUser;
  final SetUserData _setUserData;
  final UploadPhoto _uploadPhoto;
  final SignInWithEmailAndPassword _signInWithEmailAndPassword;
  final GetUserChanges _getUserChanges;
  final SignInWithGoogle _signInWithGoogle;

  AuthenticationCubit({
    required CreateUserWithEmailAndPassword createUser,
    required SetUserData setUserData,
    required UploadPhoto uploadPhoto,
    required SignInWithEmailAndPassword signInWithEmailAndPassword,
    required GetUserChanges getUserChanges,
    required SignInWithGoogle signInWithGoogle,
  })  : _createUser = createUser,
        _setUserData = setUserData,
        _uploadPhoto = uploadPhoto,
        _signInWithEmailAndPassword = signInWithEmailAndPassword,
        _getUserChanges = getUserChanges,
        _signInWithGoogle = signInWithGoogle,
        super(const AuthenticationInitial());

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const CreatingUser());
    final result = await _createUser(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (result) async {
        final String userId = result;
        // String? photo;
        // if (avatar != null) {
        //   photo = await uploadPhoto(
        //     image: avatar,
        //     path: '$PHOTOS_PATH/$userId/${basename(avatar.path)}',
        //   );
        // }
        final entity.User user = entity.User(
          userId: userId,
          name: name,
          email: email,
        );
        await setUserData(user: user);
        return emit(SignedIn(message: USER_CREATED, user: user));
      },
    );
  }

  Future<void> setUserData({
    required entity.User user,
    bool isSigningIn = false,
  }) async {
    final result = await _setUserData(user: user, isSigningIn: isSigningIn);
    result.fold(
        (failure) => emit(AuthenticationError(message: failure.message)),
        (_) => null);
  }

  File? photo;

  Future<File?> pickPhoto(BuildContext context) async {
    emit(const PickingPhoto());
    photo = await PickPhoto.pickPhoto(context);
    if (photo != null) {
      emit(const PickedPhoto());
    }
    return photo;
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    emit(const CreatingUser());
    final result =
        await _signInWithEmailAndPassword(email: email, password: password);
    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (_) => emit(const SignedIn(message: USER_LOGGED_IN)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(const CreatingUser());
    final result = await _signInWithGoogle();
    result.fold(
      (failure) => emit(AuthenticationError(message: failure.message)),
      (result) async {
        final entity.User user = result;
        await setUserData(user: user, isSigningIn: true);
        return emit(const SignedIn(message: USER_LOGGED_IN));
      },
    );
  }

  Stream getUserChanges() {
    final result = _getUserChanges();
    return result.fold((failure) {
      emit(AuthenticationError(message: failure.message));
      return const Stream.empty();
    }, (result) => result);
  }

  String? validator(String? firstPassword, String? secondPassword) {
    if (secondPassword != null) {
      if (firstPassword != secondPassword) {
        return 'unmatched';
      }
    }
    if (firstPassword != null) {
      final RegExp passValid =
          RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
      if (passValid.hasMatch(firstPassword)) {
        return null;
      }
    }
    return "Error";
  }
}
