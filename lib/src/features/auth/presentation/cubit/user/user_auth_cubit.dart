import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_rooms/core/utils/app_strings.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/core/utils/user_auth.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';
import 'package:chat_rooms/src/features/auth/presentation/cubit/users/users_cubit.dart';
import 'package:equatable/equatable.dart';

part 'user_auth_state.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  UserAuthCubit() : super(const UserAuthState());

  void getUserData({User? user}) async {
    // emit(LoadingUserData());
    try {
      final currentUser = user ?? await UserAuth.getUserData();
      emit(state.copyWith(userState: UserStates.userData, user: currentUser));
    } catch (e) {
      // emit(const UserError());
    }
    return null;
  }

  void sendEmailVerification() async {
    try {
      emit(state.copyWith(
        verificationState: VerificationStates.sendingEmailVerification,
        verifyingMessage: VERIFYING,
        verifyingTextButton: RESEND,
      ));
      // emit(const VerifyingEmail(VERIFYING));
      if (!UserAuth.auth.currentUser!.emailVerified) {
        await UserAuth.sendEmailVerification();
        final Timer timer;
        timer = Timer.periodic(
            const Duration(seconds: 2),
            (timer) => isEmailVerified(
                  UserAuth.auth.currentUser!.emailVerified,
                  UserAuth.auth.currentUser == null,
                  timer,
                ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: CAN_NOT_SEND_VERIFICATION));
    }
  }

  void isEmailVerified(bool isVerified, bool stillLoggedIn, Timer timer) {
    if (isVerified || stillLoggedIn) {
      emit(state.copyWith(
        verificationState: VerificationStates.emailVerified,
        verifyingMessage: '',
      ));
      timer.cancel();
    } else {
      UserAuth.auth.currentUser!.reload();
    }
  }
}
