import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? userId;
  final String? name;
  final String? avatar;
  final String? phoneNumber;
  final String? email;
  final String? bio;

  const User({
    this.userId,
    this.name,
    this.avatar,
    this.phoneNumber,
    this.email,
    this.bio,
  });

  @override
  List<Object?> get props => [userId, name, avatar, phoneNumber, email, bio];
}
