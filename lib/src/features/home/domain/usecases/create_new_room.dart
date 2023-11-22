import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class CreateNewRoom {
  final HomeRepository _homeRepository;

  CreateNewRoom(this._homeRepository);

  ResultVoid call(Room room) async {
    return await _homeRepository.createNewRoom(room: room);
  }
}
