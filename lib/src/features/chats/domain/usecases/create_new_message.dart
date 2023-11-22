import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:chat_rooms/src/features/chats/domain/repositories/chats_repository.dart';

class CreateNewMessage {
  final ChatsRepository _chatsRepository;

  const CreateNewMessage(this._chatsRepository);

  ResultVoid call(
      {required Message message, required String roomHostId}) async {
    return await _chatsRepository.createNewMessage(
      message: message,
      roomHostId: roomHostId,
    );
  }
}
