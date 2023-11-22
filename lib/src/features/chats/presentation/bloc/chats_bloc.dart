import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:chat_rooms/src/features/chats/domain/usecases/create_new_message.dart';
import 'package:chat_rooms/src/features/chats/domain/usecases/get_all_messages.dart';
import 'package:equatable/equatable.dart';

part 'chats_event.dart';

part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final GetAllMessages _getAllMessages;
  final CreateNewMessage _createNewMessage;

  ChatsBloc({
    required GetAllMessages getAllMessages,
    required CreateNewMessage createNewMessage,
  })  : _getAllMessages = getAllMessages,
        _createNewMessage = createNewMessage,
        super(const ChatsInitial()) {
    on<GetAllMessagesEvent>(_getAllMessagesHandler);
    on<CreateNewMessageEvent>(_createNewMessageHandler);
  }

  void _getAllMessagesHandler(
    GetAllMessagesEvent event,
    Emitter<ChatsState> emit,
  ) {
    emit(const LoadingMessages());
    _getAllMessages(roomId: event.roomId).fold(
      (failure) => emit(MessagesError(message: failure.message)),
      (allMessages) => emit(LoadedMessages(messages: allMessages)),
    );
  }

  Future<void> _createNewMessageHandler(
    CreateNewMessageEvent event,
    Emitter<ChatsState> emit,
  ) async {
    final Message message = Message(roomId: event.roomId, body: event.message);
    final result = await _createNewMessage(
      message: message,
      roomHostId: event.hostId,
    );
    result.fold((failure) => emit(MessagesError(message: failure.message)),
        (_) => null);
  }
}
