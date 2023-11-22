part of 'crud_rooms_cubit.dart';

abstract class CrudRoomsState extends Equatable {
  const CrudRoomsState();

  @override
  List<Object> get props => [];
}

class CrudRoomsInitial extends CrudRoomsState {}

class CreatingNewRoom extends CrudRoomsState {
  const CreatingNewRoom();
}

class NewRoomCreated extends CrudRoomsState {
  final String message;

  const NewRoomCreated({required this.message});

  @override
  List<Object> get props => [message];
}

class RoomsError extends CrudRoomsState {
  final String message;

  const RoomsError({required this.message});

  @override
  List<Object> get props => [message];
}

class RoomDeleted extends CrudRoomsState {
  final String message;
  final String roomId;
  const RoomDeleted({required this.message, required this.roomId});

  @override
  List<Object> get props => [message, roomId];
}

class DeletingRoom extends CrudRoomsState {
  const DeletingRoom();
}
