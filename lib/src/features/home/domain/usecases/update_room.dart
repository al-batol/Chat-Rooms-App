import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class UpdateRoom {
  final HomeRepository _homeRepository;

  const UpdateRoom(this._homeRepository);

  ResultVoid call({
    required String roomId,
    String? description,
    String? name,
    String? topicId,
  }) async {
    return await _homeRepository.updateRoom(
      roomId: roomId,
      description: description,
      name: name,
      topicId: topicId,
    );
  }
}
