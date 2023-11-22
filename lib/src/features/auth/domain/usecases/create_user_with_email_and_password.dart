import 'package:chat_rooms/core/utils/typedef.dart';

import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';

class CreateUserWithEmailAndPassword {
  final AuthenticationRepository _authRepo;

  const CreateUserWithEmailAndPassword(this._authRepo);

  ResultFuture<String> call({
    required String email,
    required String password,
  }) async {
    return await _authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
