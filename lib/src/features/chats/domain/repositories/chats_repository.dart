import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';

abstract class ChatsRepository {
  ResultStream<List<Message>> getAllMessages({required String roomId});

  ResultVoid createNewMessage({required Message message, required String roomHostId});

  ResultVoid updateMessage({required Message message});
}
