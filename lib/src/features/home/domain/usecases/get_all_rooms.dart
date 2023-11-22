import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class GetAllRooms {
  final HomeRepository _homeRepository;

  GetAllRooms(this._homeRepository);

  ResultStream<List<Room>> call() {
    return _homeRepository.getAllRooms();
  }
}
