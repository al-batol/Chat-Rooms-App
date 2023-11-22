import 'package:equatable/equatable.dart';

class AllExceptions extends Equatable implements Exception {
  final String message;

  const AllExceptions(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthException extends AllExceptions {
  const AuthException(super.message);
}

class RoomException extends AllExceptions {
  const RoomException(super.message);
}

class TopicException extends AllExceptions {
  const TopicException(super.message);
}

class UsersException extends AllExceptions {
  const UsersException(super.message);
}

class MessageException extends AllExceptions {
  const MessageException(super.message);
}

class ProfileException extends AllExceptions {
  const ProfileException(super.message);
}
