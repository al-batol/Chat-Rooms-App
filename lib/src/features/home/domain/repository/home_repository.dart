import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';

abstract class HomeRepository {
  ResultStream<List<Room>> getAllRooms();

  ResultVoid createNewRoom({required Room room});

  ResultStream<List<Topic>> getAllTopics();

  ResultFuture<String> createNewTopic({required Topic topic});

  ResultFuture<List<Room>> searchByName({required String name});

  ResultVoid updateRoom({
    required String roomId,
    String? description,
    String? name,
    String? topicId,
  });

  ResultVoid deleteRoom({required String roomId});
}
