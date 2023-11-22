import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class DeleteRoom {
  final HomeRepository _homeRepository;

  const DeleteRoom(this._homeRepository);

  ResultVoid call({required String roomId}) async {
    return await _homeRepository.deleteRoom(roomId: roomId);
  }
}
