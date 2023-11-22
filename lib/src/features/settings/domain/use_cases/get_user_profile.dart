import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/settings/domain/entities/user_profile.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';

class GetUserProfile {
  final SettingsRepository _settingsRepository;

  const GetUserProfile(this._settingsRepository);

  ResultFuture<UserProfile> call(String userId) async {
    return await _settingsRepository.getUserProfile(userId);
  }
}
