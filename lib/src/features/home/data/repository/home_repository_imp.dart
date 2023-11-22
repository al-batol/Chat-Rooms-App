import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/failure.dart';
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/data/data_source/home_remote_data_source.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImp implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;

  const HomeRepositoryImp(this._homeRemoteDataSource);

  @override
  ResultStream<List<Room>> getAllRooms() {
    try {
      return right(_homeRemoteDataSource.getAllRooms());
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }

  @override
  ResultVoid createNewRoom({required Room room}) async {
    try {
      final RoomModel roomModel = RoomModel(
        name: room.name,
        topicId: room.topicId,
        description: room.description,
        created: room.created,
        updated: room.updated,
        hostId: room.hostId,
      );

      await _homeRemoteDataSource.createNewRoom(room: roomModel);
      return right(unit);
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }

  @override
  ResultStream<List<Topic>> getAllTopics() {
    try {
      return right(_homeRemoteDataSource.getAllTopics());
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }

  @override
  ResultFuture<String> createNewTopic({required Topic topic}) async {
    try {
      final TopicModel topicModel = TopicModel(topic: topic.topic);
      return right(
        await _homeRemoteDataSource.createNewTopic(topic: topicModel),
      );
    } on TopicException catch (e) {
      return Left(TopicFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<Room>> searchByName({required String name}) async {
    try {
      final List<Room> foundRooms =
          await _homeRemoteDataSource.searchByName(name: name);
      return right(foundRooms);
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }

  @override
  ResultVoid updateRoom(
      {required String roomId,
      String? description,
      String? name,
      String? topicId}) async {
    try {
      return right(
        await _homeRemoteDataSource.updateRoom(
          roomId: roomId,
          topicId: topicId,
          description: description,
          name: name,
        ),
      );
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }

  @override
  ResultVoid deleteRoom({required String roomId}) async {
    try {
      return right(await _homeRemoteDataSource.deleteRoom(roomId: roomId));
    } on RoomException catch (e) {
      return Left(RoomFailure(message: e.message));
    }
  }
}
