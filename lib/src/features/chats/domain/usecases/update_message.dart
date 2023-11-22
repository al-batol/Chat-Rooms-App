import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:chat_rooms/src/features/chats/domain/repositories/chats_repository.dart';

class UpdateMessage {
  final ChatsRepository _chatsRepository;

  const UpdateMessage(this._chatsRepository);

  ResultVoid call({required Message message}) async {
    return await _chatsRepository.updateMessage(message: message);
  }
}
