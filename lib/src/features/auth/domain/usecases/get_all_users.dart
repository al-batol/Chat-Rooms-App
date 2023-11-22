import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/domain/repository/authentication_repository.dart';

class GetAllUsers {
  final AuthenticationRepository _homeRepository;

  const GetAllUsers(this._homeRepository);

  ResultStream<List<User>> call() {
    return _homeRepository.getAllUsers();
  }
}
