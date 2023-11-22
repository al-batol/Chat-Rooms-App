import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/failure.dart';
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/chats/data/data_sources/chat_remote_data_source.dart';
import 'package:chat_rooms/src/features/chats/data/models/message_model.dart';
import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:chat_rooms/src/features/chats/domain/repositories/chats_repository.dart';
import 'package:dartz/dartz.dart';

class ChatsRepositoryImp implements ChatsRepository {
  final ChatsRemoteDataSource _chatsRemoteDataSource;

  ChatsRepositoryImp(this._chatsRemoteDataSource);

  @override
  ResultVoid createNewMessage(
      {required Message message, required String roomHostId}) async {
    try {
      final MessageModel messageModel = MessageModel(
        userId: message.userId,
        updated: message.updated,
        created: message.created,
        body: message.body,
        roomId: message.roomId,
      );
      await _chatsRemoteDataSource.createNewMessage(
        message: messageModel,
        roomHostId: roomHostId,
      );
      return right(unit);
    } on MessageException catch (e) {
      return Left(MessageFailure(message: e.message));
    }
  }

  @override
  ResultStream<List<Message>> getAllMessages({required String roomId}) {
    try {
      return right(_chatsRemoteDataSource.getAllMessages(roomId: roomId));
    } on MessageException catch (e) {
      return Left(MessageFailure(message: e.message));
    }
  }

  @override
  ResultVoid updateMessage({required Message message}) {
    // TODO: implement updateMessage
    throw UnimplementedError();
  }
}
