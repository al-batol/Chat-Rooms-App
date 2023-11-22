import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class StorageFailure extends Failure {
  const StorageFailure({required super.message});
}

class RoomFailure extends Failure {
  const RoomFailure({required super.message});
}

class TopicFailure extends Failure {
  const TopicFailure({required super.message});
}

class MessageFailure extends Failure {
  const MessageFailure({required super.message});
}

class UsersFailure extends Failure {
  const UsersFailure({required super.message});
}

class ProfileFailure extends Failure {
  const ProfileFailure({required super.message});
}
