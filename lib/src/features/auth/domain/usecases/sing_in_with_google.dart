import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';

class SignInWithGoogle {
  final AuthenticationRepository _auth;

  const SignInWithGoogle(this._auth);

  ResultFuture<User> call() async {
    return await _auth.signInWithGoogle();
  }
}
