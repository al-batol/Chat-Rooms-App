import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/failure.dart';
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/data/date_source/auth_remote_date_source.dart';
import 'package:chat_rooms/src/features/auth/data/models/user_model.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart'
    as entity;
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _authDataRemoteSource;

  AuthenticationRepositoryImp(this._authDataRemoteSource);

  @override
  ResultFuture<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authDataRemoteSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(result);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  ResultVoid setUserData({
    required entity.User user,
    bool isSigningIn = false,
  }) async {
    final UserModel userModel = UserModel(
      userId: user.userId,
      name: user.name,
      avatar: user.avatar,
      bio: user.bio,
      email: user.email,
      phoneNumber: user.phoneNumber,
    );
    try {
      await _authDataRemoteSource.setUserData(
        user: userModel,
        isSigningIn: isSigningIn,
      );
      return const Right(unit);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  ResultVoid signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _authDataRemoteSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(unit);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  ResultStream<List<entity.User>> getAllUsers() {
    try {
      return right(_authDataRemoteSource.getAllUsers());
    } on UsersException catch (e) {
      return left(UsersFailure(message: e.message));
    }
  }

  @override
  ResultStream<User?> getUserChanges() {
    try {
      return right(_authDataRemoteSource.getUserChanges());
    } on UsersException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  ResultFuture<entity.User> signInWithGoogle() async {
    try {
      return right(await _authDataRemoteSource.signInWithGoogle());
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }
}
