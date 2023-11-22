import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel extends Room {
  const RoomModel({
    super.hostId,
    super.roomId,
    super.topicId,
    super.name,
    super.displayName,
    super.description,
    super.participants,
    super.created,
    super.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'hostId': hostId,
      'topicId': topicId,
      'name': name,
      'displayName': displayName,
      'description': description,
      'participants': participants ?? [],
      'created': Timestamp.fromDate(DateTime.parse(created!)),
      'updated': null,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map, String roomId) {
    return RoomModel(
      hostId: map['hostId'] ?? '',
      roomId: roomId,
      topicId: map['topicId'] ?? '',
      name: map['name'] ?? '',
      displayName: map['displayName'] ?? '',
      description: map['description'] ?? '',
      participants: List.from(map['participants']),
      created: map['created'] != null
          ? (map['created'] as Timestamp).toDate().toString()
          : '',
      updated: map['updated'] != null
          ? (map['updated'] as Timestamp).toDate().toString()
          : '',
    );
  }

  RoomModel copyWith({
    String? hostId,
    String? topicId,
    String? name,
    String? displayName,
    String? description,
    List<String>? participants,
    String? created,
    String? updated,
  }) {
    return RoomModel(
      hostId: hostId ?? this.hostId,
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      description: description ?? this.description,
      participants: participants ?? this.participants,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }
}
