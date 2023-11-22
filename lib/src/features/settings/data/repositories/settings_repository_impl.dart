import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/failure.dart';
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:chat_rooms/src/features/settings/domain/entities/user_profile.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepositoryImp implements SettingsRepository {
  final SettingsRemoteDataSource _remoteDataSource;

  const SettingsRepositoryImp(this._remoteDataSource);

  @override
  ResultVoid signOut() async {
    try {
      return right(await _remoteDataSource.signOut());
    } on AuthException catch (e) {
      throw AuthFailure(message: e.message);
    }
  }

  @override
  ResultVoid updateUserProfile({
    required String userId,
    String? photo,
    String? name,
    String? bio,
  }) async {
    try {
      return right(
        await _remoteDataSource.updateUserProfile(
          userId: userId,
          photo: photo,
          name: name,
          bio: bio,
        ),
      );
    } on ProfileException catch (e) {
      throw ProfileFailure(message: e.message);
    }
  }

  @override
  ResultFuture<UserProfile> getUserProfile(String userId) async {
    try {
      return right(await _remoteDataSource.getUserProfile(userId));
    } on UsersException catch (e) {
      throw UsersFailure(message: e.message);
    }
  }

  @override
  ResultFuture<List<RoomModel>> getMyRooms(String userId) async {
    try {
      return right(await _remoteDataSource.getMyRooms(userId));
    } on RoomException catch (e) {
      throw RoomFailure(message: e.message);
    }
  }

  @override
  ResultFuture<List<TopicModel>> getTopics(List<String> ids) async {
    try {
      return right(await _remoteDataSource.getTopics(ids));
    } on RoomException catch (e) {
      throw RoomFailure(message: e.message);
    }
  }
}
