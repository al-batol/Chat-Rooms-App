import 'dart:async';
import 'package:chat_rooms/src/features/home/domain/usecases/search_by_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/home/domain/usecases/get_all_rooms.dart';
import 'package:equatable/equatable.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  final GetAllRooms _getAllRooms;
  final SearchByName _searchByName;

  RoomsCubit({
    required GetAllRooms getAllRooms,
    required SearchByName searchByName,
  })  : _getAllRooms = getAllRooms,
        _searchByName = searchByName,
        super(const RoomsInitial());

  void signedIn(bool isSignedIn) {
    emit(SignedInOrCreateRoom(signInOrCreateRoom: isSignedIn));
  }

  void getAllRooms() {
    return _getAllRooms().fold(
        (failure) => emit(RoomsError(message: failure.message)),
        (allRooms) => emit(LoadedRooms(allRooms: allRooms)));
  }

  late RoomsState roomState;

  Future<void> searchByName(String name, RoomsState state) async {
    if (state is LoadedRooms && name.length == 1) {
      roomState = LoadedRooms(allRooms: state.allRooms);
    }
    emit(const Searching());
    final searchResult = await _searchByName(name: name);
    searchResult.fold((failure) => emit(RoomsError(message: failure.message)),
        (foundRooms) {
      if (name.isNotEmpty) {
        emit(SearchResult(foundRooms: foundRooms));
      } else {
        emit(roomState);
      }
    });
  }
}
