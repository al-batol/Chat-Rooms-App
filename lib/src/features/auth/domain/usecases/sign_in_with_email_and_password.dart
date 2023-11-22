import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';

class SignInWithEmailAndPassword {
  final AuthenticationRepository _authRepo;

  SignInWithEmailAndPassword(this._authRepo);

  ResultVoid call({
    required String email,
    required String password,
  }) {
    return _authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
