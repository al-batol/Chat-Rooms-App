import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/data/models/topic_model.dart';
import 'package:chat_rooms/src/features/settings/domain/repositories/settings_repository.dart';

class GetTopics {
  final SettingsRepository _settingsRepository;

  const GetTopics(this._settingsRepository);

  ResultFuture<List<TopicModel>> call(List<String> ids) async {
    return await _settingsRepository.getTopics(ids);
  }
}
