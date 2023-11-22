import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String? userId;
  final String? roomId;
  final String? displayName;
  final String? body;
  final String? created;
  final String? updated;

  const Message({
    this.userId,
    this.roomId,
    this.displayName,
    this.body,
    this.created,
    this.updated,
  });

  @override
  List<Object?> get props =>
      [userId, roomId, displayName, body, created, updated];
}
