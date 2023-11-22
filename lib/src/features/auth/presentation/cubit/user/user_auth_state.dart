part of 'user_auth_cubit.dart';

enum UserStates {
  userData,
  nullUser,
}

enum VerificationStates {
  sendingEmailVerification,
  emailVerified,
}

class UserAuthState extends Equatable {
  final VerificationStates? verificationState;
  final UserStates? userState;
  final User? user;
  final String? errorMessage;
  final String? verifyingMessage;
  final String? verifyingTextButton;

  const UserAuthState({
    this.verificationState,
    this.userState,
    this.user,
    this.errorMessage,
    this.verifyingMessage = UNVERIFIED,
    this.verifyingTextButton = VERIFY_NOW,
  });

  UserAuthState copyWith({
    VerificationStates? verificationState,
    UserStates? userState,
    User? user,
    String? errorMessage,
    String? verifyingMessage,
    String? verifyingTextButton,
  }) {
    return UserAuthState(
      verificationState: verificationState ?? this.verificationState,
      user: user ?? this.user,
      userState: userState ?? this.userState,
      errorMessage: errorMessage ?? this.errorMessage,
      verifyingMessage: verifyingMessage ?? this.verifyingMessage,
      verifyingTextButton: verifyingTextButton ?? this.verifyingTextButton,
    );
  }

  @override
  List<Object?> get props => [
        verificationState,
        userState,
        user,
        errorMessage,
        verifyingMessage,
      ];
}

// class UserAuthInitial extends UserAuthState {}
//
// class LoadingUserData extends UserAuthState {}
//
// class LoadedUserData extends UserAuthState {
//   final User user;
//
//   const LoadedUserData(this.user);
// }
//
// class UserError extends UserAuthState {
//   const UserError();
// }
//
// class VerifyingEmail extends UserAuthState {
//   final String message;
//
//   const VerifyingEmail(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class UnVerifiedEmail extends UserAuthState {
//   final String message;
//
//   const UnVerifiedEmail(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
//
// class VerifiedEmail extends UserAuthState {
//   const VerifiedEmail();
// }
//
// class VerificationError extends UserAuthState {
//   final String message;
//
//   const VerificationError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
