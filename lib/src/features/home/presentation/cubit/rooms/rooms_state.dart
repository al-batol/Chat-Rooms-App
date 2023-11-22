part of 'rooms_cubit.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

class RoomsInitial extends RoomsState {
  const RoomsInitial();
}

class LoadedRooms extends RoomsState {
  final Stream<List<Room>> allRooms;

  const LoadedRooms({required this.allRooms});

  @override
  List<Object> get props => [allRooms];
}

class RoomsError extends RoomsState {
  final String message;

  const RoomsError({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedRoomsData extends RoomsState {
  final Stream<List<Room>> allRooms;
  final Stream<List<Topic>> allTopics;

  const LoadedRoomsData({
    required this.allRooms,
    required this.allTopics,
  });

  @override
  List<Object> get props => [allRooms, allTopics];
}

class SignedInOrCreateRoom extends RoomsState {
  final bool signInOrCreateRoom;

  const SignedInOrCreateRoom({required this.signInOrCreateRoom});

  @override
  List<Object> get props => [signInOrCreateRoom];
}

class Searching extends RoomsState {
  const Searching();
}

class SearchResult extends RoomsState {
  final List<Room> foundRooms;

  const SearchResult({required this.foundRooms});

  @override
  List<Object> get props => [foundRooms];
}
