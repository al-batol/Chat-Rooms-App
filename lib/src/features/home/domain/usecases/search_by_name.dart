import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/repository/home_repository.dart';

class SearchByName {
  final HomeRepository _homeRepository;

  const SearchByName(this._homeRepository);

  ResultFuture<List<Room>> call({required String name}) async {
    return _homeRepository.searchByName(name: name);
  }
}
