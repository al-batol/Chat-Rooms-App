import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/src/features/chats/data/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatsRemoteDataSource {
  Stream<List<MessageModel>> getAllMessages({required String roomId});

  Future<Unit> createNewMessage({
    required MessageModel message,
    required String roomHostId,
  });

  Future<Unit> updateMessage({required MessageModel message});
}

class ChatsRemoteDataSourceImp implements ChatsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ChatsRemoteDataSourceImp(this._firestore, this._auth);

  @override
  Future<Unit> createNewMessage(
      {required MessageModel message, required String roomHostId}) async {
    final hostId = _auth.currentUser!.uid;
    try {
      if (hostId != roomHostId) {
        await _firestore.collection('rooms').doc(message.roomId).update({
          'participants': FieldValue.arrayUnion([hostId])
        });
      }
      await _firestore
          .collection('rooms')
          .doc(message.roomId)
          .collection('messages')
          .doc()
          .set(
            message
                .copyWith(
                  userId: hostId,
                  displayName: _auth.currentUser!.displayName,
                  created: DateTime.now().toString(),
                )
                .toMap(),
          );
      return Future.value(unit);
    } catch (e) {
      throw const MessageException(CAN_NOT_SEND_MESSAGE);
    }
  }

  @override
  Stream<List<MessageModel>> getAllMessages({required String roomId}) {
    try {
      return _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('created')
          .snapshots()
          .asyncMap((messages) {
        List<MessageModel> allMessages = [];
        for (var message in messages.docs) {
          allMessages.add(MessageModel.fromMap(message.data()));
        }
        return allMessages;
      });
    } catch (e) {
      throw const MessageException(ROOM_NOT_FOUND);
    }
  }

  @override
  Future<Unit> updateMessage({required MessageModel message}) {
    // TODO: implement updateMessage
    throw UnimplementedError();
  }
}
