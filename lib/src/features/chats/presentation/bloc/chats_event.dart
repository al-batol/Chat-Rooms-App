part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class GetAllMessagesEvent extends ChatsEvent {
  final String roomId;

  const GetAllMessagesEvent(this.roomId);
}

class CreateNewMessageEvent extends ChatsEvent {
  final String message;
  final String roomId;
  final String hostId;

  const CreateNewMessageEvent(this.message, this.roomId, this.hostId);

  @override
  List<Object> get props => [message, roomId, hostId];
}
