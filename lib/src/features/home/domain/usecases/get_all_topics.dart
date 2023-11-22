import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class GetAllTopics {
  final HomeRepository _homeRepository;

  GetAllTopics(this._homeRepository);

  ResultStream<List<Topic>> call() {
    return _homeRepository.getAllTopics();
  }
}
