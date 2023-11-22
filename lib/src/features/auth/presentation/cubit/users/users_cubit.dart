import 'package:bloc/bloc.dart';
import 'package:chat_rooms/core/utils/user_auth.dart';
import 'package:chat_rooms/src/features/auth/domain/usecases/get_all_users.dart';
import 'package:equatable/equatable.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart'
    as entity;
import 'package:firebase_auth/firebase_auth.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUsers _getAllUsers;

  UsersCubit({required GetAllUsers getAllUsers, required FirebaseAuth auth})
      : _getAllUsers = getAllUsers,
        super(const UsersInitial());

  late final UsersState currentState;

  void getAllUsers({UsersState? dataState, entity.User? user}) async {
    try {
      user ??= await UserAuth.getUserData();

      // if (dataState != null) {
      //   if (dataState is LoadUsers) {
      //     emit(dataState.copyWith(user: user));
      //   }
      //   return;
      // }
      _getAllUsers().fold(
          (failure) => emit(LoadingUsersError(
                message: failure.message,
              )), (users) {
        currentState = LoadUsers(
          user: user,
          users: users,
          userChanges: UserAuth.auth.userChanges(),
        );
        emit(LoadUsers(
          user: user,
          users: users,
          userChanges: UserAuth.auth.userChanges(),
        ));
      });
    } catch (e) {
      emit(LoadingUsersError(
        message: e.toString(),
      ));
    }
  }
}
