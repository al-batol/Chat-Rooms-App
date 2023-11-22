import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/settings/domain/entities/user_profile.dart';

abstract class SettingsRepository {
  ResultVoid signOut();

  ResultFuture<UserProfile> getUserProfile(String userId);

  ResultVoid updateUserProfile({
    required String userId,
    String? photo,
    String? name,
    String? bio,
  });

  ResultFuture<List<RoomModel>> getMyRooms(String userId);

  ResultFuture<List<TopicModel>> getTopics(List<String> ids);
}
