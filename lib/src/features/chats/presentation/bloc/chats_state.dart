part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

class LoadingMessages extends ChatsState {
  const LoadingMessages();
}

class LoadedMessages extends ChatsState {
  final Stream<List<Message>> messages;

  const LoadedMessages({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesError extends ChatsState {
  final String message;

  const MessagesError({required this.message});

  @override
  List<Object> get props => [message];
}

class NewChangesOnMessage extends ChatsState {
  const NewChangesOnMessage();
}
