import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String? userId;
  final String? name;
  final String? avatar;
  final String? bio;

  const UserProfile({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.bio,
  });

  @override
  List<Object?> get props => [userId, name, avatar, bio];
}
