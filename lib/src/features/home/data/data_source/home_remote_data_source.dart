import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeRemoteDataSource {
  Stream<List<RoomModel>> getAllRooms();

  Future<Unit> createNewRoom({required RoomModel room});

  Stream<List<TopicModel>> getAllTopics();

  Future<String> createNewTopic({required TopicModel topic});

  Future<List<RoomModel>> searchByName({required String name});

  Future<Unit> updateRoom({
    required String roomId,
    String? description,
    String? name,
    String? topicId,
  });

  Future<Unit> deleteRoom({required String roomId});
}

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;

  const HomeRemoteDataSourceImp(this._firestore);

  @override
  Stream<List<RoomModel>> getAllRooms() {
    try {
      return _firestore.collection('rooms').snapshots().asyncMap((rooms) {
        final List<RoomModel> allRooms = [];
        for (var room in rooms.docs) {
          allRooms.add(RoomModel.fromMap(room.data(), room.id));
        }
        return allRooms;
      });
    } catch (e) {
      throw const RoomException(CAN_NOT_LOAD_ROOMS);
    }
  }

  @override
  Future<Unit> createNewRoom({required RoomModel room}) async {
    try {
      await _firestore.collection('rooms').add(room
          .copyWith(
            topicId: room.topicId,
            displayName: FirebaseAuth.instance.currentUser?.displayName,
            hostId: FirebaseAuth.instance.currentUser?.uid,
            created: DateTime.now().toString(),
          )
          .toMap());

      return Future.value(unit);
    } catch (e) {
      throw const RoomException(ROOM_WAS_NOT_CREATED);
    }
  }

  Future<String?> isTopicExists(String topic) async {
    final check = await _firestore
        .collection('topics')
        .where('topic', isEqualTo: topic)
        .limit(1)
        .get();
    return check.docs.isNotEmpty ? check.docs.first.id : null;
  }

  @override
  Stream<List<TopicModel>> getAllTopics() {
    try {
      return _firestore.collection('topics').snapshots().asyncMap((topics) {
        final List<TopicModel> allTopics = [];
        for (var topic in topics.docs) {
          allTopics.add(TopicModel.fromMap(topic.data(), topic.id));
        }
        return allTopics;
      });
    } catch (e) {
      throw const RoomException(CAN_NOT_LOAD_ROOMS);
    }
  }

  @override
  Future<String> createNewTopic({required TopicModel topic}) async {
    try {
      final String? getTopicIdIfExists = await isTopicExists(topic.topic!);
      if (getTopicIdIfExists == null) {
        final topicData =
            await _firestore.collection('topics').add(topic.toMap());
        return Future.value(topicData.id);
      } else {
        return Future.value(getTopicIdIfExists);
      }
    } catch (e) {
      throw const TopicException(CAN_NOT_LOAD_TOPICS);
    }
  }

  @override
  Future<List<RoomModel>> searchByName({required String name}) async {
    try {
      final rooms = await _firestore.collection('rooms').get();
      final topics = await _firestore.collection('topics').get();
      final List<RoomModel> allRooms = [];
      final List<RoomModel> foundRooms = [];
      final List<TopicModel> allTopics = [];
      if (name.isNotEmpty) {
        for (var topic in topics.docs) {
          allTopics.add(TopicModel.fromMap(topic.data(), topic.id));
        }

        for (var room in rooms.docs) {
          final RoomModel roomModel = RoomModel.fromMap(room.data(), room.id);
          allRooms.add(roomModel);
          // search by description and name

          if (roomModel.description!.contains(name) ||
              roomModel.name!.contains(name)) {
            foundRooms.add(roomModel);
          }
        }

        // search by topic

        for (RoomModel room in allRooms) {
          for (TopicModel topic in allTopics) {
            if (topic.topic!.startsWith(name)) {
              if (room.topicId == topic.topicId) {
                if (!foundRooms.contains(room)) {
                  foundRooms.add(room);
                }
              }
            }
          }
        }
      }
      return foundRooms;
    } catch (e) {
      throw const RoomException(ROOM_NOT_FOUND);
    }
  }

  @override
  Future<Unit> updateRoom({
    required String roomId,
    String? description,
    String? name,
    String? topicId,
  }) async {
    try {
      if (description != null) {
        await _firestore.collection('rooms').doc(roomId).update({
          'description': description,
        });
      }

      if (name != null) {
        await _firestore.collection('rooms').doc(roomId).update({
          'name': name,
        });
      }

      if (topicId != null) {
        await _firestore.collection('rooms').doc(roomId).update({
          'topicId': topicId,
        });
      }
      return Future(() => unit);
    } catch (e) {
      throw const RoomException(ROOM_UPDATE_FAILED);
    }
  }

  @override
  Future<Unit> deleteRoom({required String roomId}) async {
    try {
      await _firestore.collection('rooms').doc(roomId).delete();
      return Future(() => unit);
    } catch (e) {
      throw const RoomException(ROOM_DELETE_FAILED);
    }
  }
}
