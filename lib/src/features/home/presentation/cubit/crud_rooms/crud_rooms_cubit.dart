import 'package:bloc/bloc.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/core/utils/app_strings.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/create_new_room.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/create_new_topic.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/delete_room.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/update_room.dart';
import 'package:equatable/equatable.dart';

part 'crud_rooms_state.dart';

class CrudRoomsCubit extends Cubit<CrudRoomsState> {
  final CreateNewRoom _createNewRoom;
  final CreateNewTopic _createNewTopic;
  final UpdateRoom _updateRoom;
  final DeleteRoom _deleteRoom;

  CrudRoomsCubit({
    required CreateNewRoom createNewRoom,
    required CreateNewTopic createNewTopic,
    required UpdateRoom updateRoom,
    required DeleteRoom deleteRoom,
  })  : _createNewRoom = createNewRoom,
        _createNewTopic = createNewTopic,
        _updateRoom = updateRoom,
        _deleteRoom = deleteRoom,
        super(CrudRoomsInitial());

  Future<void> createRoomWithTopic({
    required bool isUserVerified,
    required bool shouldUpdate,
    required String? roomId,
    required String topicName,
    required String roomName,
    required String description,
  }) async {
    emit(const CreatingNewRoom());
    if(!isUserVerified) {
      emit(const RoomsError(message: YOU_HAVE_TO_VERIFY_YOUR_ACCOUNT_FIRST));
      return;
    }
    final topicId = await createNewTopic(topicName: topicName);
    if (topicId != null) {
      if (shouldUpdate) {
        await updateRoom(
          name: roomName,
          roomId: roomId!,
          topicId: topicId,
          description: description,
        );
        return;
      }
      await createNewRoom(
        topicName: topicName,
        topicId: topicId,
        roomName: roomName,
        description: description,
      );
    }
  }

  Future<void> createNewRoom({
    required String topicName,
    required String topicId,
    required String roomName,
    required String description,
  }) async {
    Room room = Room(
      name: roomName,
      topicId: topicId,
      description: description,
    );
    final result = await _createNewRoom(room);
    result.fold(
      (failure) => emit(RoomsError(message: failure.message)),
      (_) => emit(const NewRoomCreated(message: NEW_ROOM_CREATED)),
    );
  }

  Future<String?> createNewTopic({required String topicName}) async {
    final Topic topic = Topic(topic: topicName);
    final result = await _createNewTopic(topic);
    return result.fold((failure) {
      emit(RoomsError(message: failure.message));
      return Future.value(null);
    }, (topicId) => topicId);
  }

  String? validator(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'Field can\'t be empty';
    }
  }

  Future<void> updateRoom(
      {required String roomId,
      String? name,
      String? description,
      String? topicId}) async {
    final result = await _updateRoom(
      roomId: roomId,
      name: name,
      description: description,
      topicId: topicId,
    );
    result.fold(
      (failure) => emit(RoomsError(message: failure.message)),
      (r) => emit(const NewRoomCreated(message: ROOM_UPDATED)),
    );
  }

  Future<void> deleteRoom({required String roomId}) async {
    emit(const DeletingRoom());
    final result = await _deleteRoom(roomId: roomId);
    result.fold(
      (failure) => emit(RoomsError(message: failure.message)),
      (r) => emit(RoomDeleted(message: ROOM_DELETED, roomId: roomId)),
    );
  }
}
