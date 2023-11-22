import 'package:bloc/bloc.dart';
import 'package:chat_rooms/src/features/home/domain/entities/room.dart';
import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';
import 'package:chat_rooms/src/features/settings/domain/entities/user_profile.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_my_rooms.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_topics.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/get_user_profile.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/sign_out.dart';
import 'package:chat_rooms/src/features/settings/domain/use_cases/update_user_profile.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SignOut _signOut;
  final GetUserProfile _getUserProfile;
  final GetMyRooms _getMyRooms;
  final GetTopics _getTopics;

  SettingsCubit({
    required SignOut signOut,
    required UpdateUserProfile updateUserProfile,
    required GetUserProfile getUserProfile,
    required GetMyRooms getMyRooms,
    required GetTopics getTopics,
  })  : _signOut = signOut,
        _getUserProfile = getUserProfile,
        _getMyRooms = getMyRooms,
        _getTopics = getTopics,
        super(const SettingsState(
          roomsAndTopicsState: RoomsAndTopicsState.loading,
          userProfileState: UserProfileState.loading,
        ));

  Future<void> signOut() async {
    emit(state.copyWith(
      userProfileState: UserProfileState.signingOut,
      isSignedOut: false,
    ));
    final result = await _signOut();
    result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (r) => emit(state.copyWith(
              userProfileState: UserProfileState.signedOut,
              isSignedOut: true,
            )));
  }

  Future<void> getUserProfile(String userId) async {
    final result = await _getUserProfile(userId);
    result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (userProfile) => emit(state.copyWith(
              userProfileState: UserProfileState.loaded,
              userProfile: userProfile,
            )));
  }

  Future<void> getMyRooms(String userId) async {
    final result = await _getMyRooms(userId);
    result.fold((failure) => emit(state.copyWith(message: failure.message)),
        (myRooms) => emit(state.copyWith(myRooms: myRooms)));
  }

  Future<void> getTopics() async {
    final result =
        await _getTopics(state.myRooms!.map((room) => room.topicId!).toList());
    result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (topics) => emit(state.copyWith(
              roomsAndTopicsState: RoomsAndTopicsState.loaded,
              topics: topics,
            )));
  }

  void removeRoomFromState(String roomId) {
    emit(state.copyWith(roomsAndTopicsState: RoomsAndTopicsState.loading));
    if (state.myRooms != null) {
      final int index =
          state.myRooms!.indexWhere((room) => room.roomId == roomId);
      state.myRooms!.removeAt(index);
      emit(state.copyWith(roomsAndTopicsState: RoomsAndTopicsState.loaded));
    }
  }
}
