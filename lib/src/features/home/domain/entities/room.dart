import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String? hostId;
  final String? roomId;
  final String? topicId;
  final String? name;
  final String? displayName;
  final String? description;
  final List<String>? participants;
  final String? created;
  final String? updated;

  const Room({
    this.hostId,
    this.roomId,
    this.topicId,
    this.name,
    this.displayName,
    this.description,
    this.participants,
    this.created,
    this.updated,
  });

  @override
  List<Object?> get props => [
        hostId,
        roomId,
        topicId,
        name,
        displayName,
        description,
        participants,
        created,
        updated,
      ];
}
