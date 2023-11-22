import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:chat_rooms/src/features/chats/domain/repositories/chats_repository.dart';

class GetAllMessages {
  final ChatsRepository _chatsRepository;

  GetAllMessages(this._chatsRepository);

  ResultStream<List<Message>> call({required String roomId}) {
    return _chatsRepository.getAllMessages(roomId: roomId);
  }
}
