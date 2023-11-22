import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/data/models/room_model.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';

class GetMyRooms {
  final SettingsRepository _settingsRepository;

  const GetMyRooms(this._settingsRepository);

  ResultFuture<List<RoomModel>> call(String userId) async {
    return await _settingsRepository.getMyRooms(userId);
  }
}
