part of 'settings_cubit.dart';

enum RoomsAndTopicsState {
  loading,
  loaded,
}

enum UserProfileState {
  loading,
  loaded,
  signingOut,
  signedOut,
}

class SettingsState extends Equatable {
  final RoomsAndTopicsState? roomsAndTopicsState;
  final UserProfileState? userProfileState;
  final UserProfile? userProfile;
  final bool? isLoadingUserProfile;
  final List<Room>? myRooms;
  final List<Topic>? topics;
  final String? message;
  final bool? isSignedOut;

  @override
  List<Object?> get props => [
        roomsAndTopicsState,
        userProfileState,
        userProfile,
        myRooms,
        topics,
        isSignedOut,
        isLoadingUserProfile,
      ];

  const SettingsState({
    this.userProfileState,
    this.roomsAndTopicsState,
    this.userProfile,
    this.myRooms,
    this.topics,
    this.message,
    this.isSignedOut,
    this.isLoadingUserProfile,
  });

  SettingsState copyWith({
    UserProfileState? userProfileState,
    RoomsAndTopicsState? roomsAndTopicsState,
    UserProfile? userProfile,
    bool? isLoadingUserProfile,
    List<Room>? myRooms,
    List<Topic>? topics,
    String? message,
    bool? isSignedOut,
  }) {
    return SettingsState(
      userProfileState: userProfileState ?? this.userProfileState,
      roomsAndTopicsState: roomsAndTopicsState ?? this.roomsAndTopicsState,
      userProfile: userProfile ?? this.userProfile,
      isLoadingUserProfile: isLoadingUserProfile ?? this.isLoadingUserProfile,
      myRooms: myRooms ?? this.myRooms,
      topics: topics ?? this.topics,
      message: message ?? this.message,
      isSignedOut: isSignedOut ?? this.isSignedOut,
    );
  }
}

// class SettingsInitial extends SettingsState {
//   const SettingsInitial();
// }
//
// class LoadingUserProfile extends SettingsState {
//   const LoadingUserProfile();
// }

// class LoadedUserProfile extends SettingsState {
//   final UserProfile? userProfile;
//   final List<Room>? myRooms;
//   final List<Topic>? topics;
//
//   const LoadedUserProfile({
//     this.userProfile,
//     this.myRooms,
//     this.topics,
//   });
//
//   LoadedUserProfile copyWith({
//     final UserProfile? userProfile,
//     final List<Room>? myRooms,
//     final List<Topic>? topics,
//   }) {
//     return LoadedUserProfile(
//       userProfile: userProfile ?? this.userProfile,
//       myRooms: myRooms ?? this.myRooms,
//       topics: topics ?? this.topics,
//     );
//   }
//
//   @override
//   List<Object?> get props => [userProfile, myRooms, topics];
// }
//
// class UserProfileError extends SettingsState {
//   final String message;
//
//   const UserProfileError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
//
// class SigningOut extends SettingsState {
//   const SigningOut();
// }
//
// class SignedOut extends SettingsState {
//   const SignedOut();
// }
