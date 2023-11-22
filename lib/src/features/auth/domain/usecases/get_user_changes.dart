import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';

class GetUserChanges {
  final AuthenticationRepository _authRepository;

  const GetUserChanges(this._authRepository);

  ResultStream<dynamic> call() {
    return _authRepository.getUserChanges();
  }
}
