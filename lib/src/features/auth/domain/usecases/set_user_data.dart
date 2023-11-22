import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';

class SetUserData {
  final AuthenticationRepository _authRepository;

  SetUserData(this._authRepository);

  ResultVoid call({
    required User user,
    bool isSigningIn = false,
  }) async {
    return await _authRepository.setUserData(
      user: user,
      isSigningIn: isSigningIn,
    );
  }
}
