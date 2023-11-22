import 'package:chat_rooms/src/features/chats/domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends Message {
  const MessageModel({
    super.userId,
    super.roomId,
    super.displayName,
    super.body,
    super.created,
    super.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'body': body,
      'created': Timestamp.fromDate(DateTime.parse(created!)),
      'updated': null,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      userId: map['userId'] ?? '',
      displayName: map['displayName'] ?? '',
      body: map['body'] ?? '',
      created: map['created'] != null
          ? (map['created'] as Timestamp).toDate().toString()
          : '',
      updated:  map['updated'] != null
          ? (map['updated'] as Timestamp).toDate().toString()
          : '',
    );
  }

  MessageModel copyWith({
    String? userId,
    String? roomId,
    String? displayName,
    String? body,
    String? created,
    String? updated,
  }) {
    return MessageModel(
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      displayName: displayName ?? this.displayName,
      body: body ?? this.body,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }
}
