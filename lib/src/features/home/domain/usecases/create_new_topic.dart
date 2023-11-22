import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class CreateNewTopic {
  final HomeRepository _homeRepository;

  CreateNewTopic(this._homeRepository);

  ResultFuture<String> call(Topic topic) async {
    return await _homeRepository.createNewTopic(topic: topic);
  }
}
