import 'dart:developer';

import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/settings/data/models/user_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SettingsRemoteDataSource {
  Future<Unit> signOut();

  Future<UserProfileModel> getUserProfile(String userId);

  Future<Unit> updateUserProfile({
    required String userId,
    String? photo,
    String? name,
    String? bio,
  });

  Future<List<RoomModel>> getMyRooms(String userId);

  Future<List<TopicModel>> getTopics(List<String> ids);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  const SettingsRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<Unit> signOut() async {
    try {
      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().signOut();
      }
      await _auth.signOut();
      return Future(() => unit);
    } catch (e) {
      throw const AuthException(TRY_AGAIN);
    }
  }

  @override
  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      final userProfileData =
          await _firestore.collection('users').doc(userId).get();
      final UserProfileModel userProfile =
          UserProfileModel.fromMap(userProfileData.data()!);
      return userProfile;
    } catch (e) {
      throw const UsersException(CAN_NOT_LOAD_USER);
    }
  }

  @override
  Future<Unit> updateUserProfile(
      {required String userId,
      String? photo,
      String? name,
      String? bio}) async {
    try {
      if (photo != null) {
        log(photo);
        await _firestore.collection('users').doc(userId).update({
          'avatar': photo,
        });
      }
      if (name != null) {
        await _firestore.collection('users').doc(userId).update({
          'name': name,
        });
      }
      if (bio != null) {
        await _firestore.collection('users').doc(userId).update({
          'bio': bio,
        });
      }
      return Future(() => unit);
    } catch (e) {
      throw ProfileException(e.toString());
    }
  }

  @override
  Future<List<RoomModel>> getMyRooms(String userId) async {
    try {
      List<RoomModel> myRooms = [];
      final rooms = await _firestore
          .collection('rooms')
          .where(
            'hostId',
            isEqualTo: userId,
          )
          .get();
      for (var room in rooms.docs) {
        myRooms.add(RoomModel.fromMap(room.data(), room.id));
      }
      return myRooms;
    } catch (e) {
      throw const RoomException(CAN_NOT_LOAD_ROOMS);
    }
  }

  @override
  Future<List<TopicModel>> getTopics(List<String> ids) async {
    try {
      List<TopicModel> topics = [];
      for (String id in ids) {
        final doc = await _firestore.collection('topics').doc(id).get();
        topics.add(TopicModel.fromMap(doc.data()!, doc.id));
      }

      return topics;
    } catch (e) {
      throw const RoomException(CAN_NOT_LOAD_ROOMS);
    }
  }
}
