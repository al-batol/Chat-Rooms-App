part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {
  const UsersInitial();
}

class LoadUsers extends UsersState {
  final Stream<List<entity.User>> users;
  final Stream<User?> userChanges;
  final entity.User? user;

  const LoadUsers({required this.users, required this.userChanges, this.user});

  LoadUsers copyWith({
    Stream<List<entity.User>>? users,
    Stream<User?>? userChanges,
    entity.User? user,
  }) {
    return LoadUsers(
      users: users ?? this.users,
      userChanges: userChanges ?? this.userChanges,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [users, userChanges];
}

class LoadingUsersError extends UsersState {
  final String message;

  const LoadingUsersError({required this.message});

  @override
  List<Object> get props => [message];
}
