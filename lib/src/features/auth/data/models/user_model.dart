import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.userId,
    super.name,
    super.avatar,
    super.phoneNumber,
    super.email,
    super.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name ?? '',
      'avatar': avatar ?? '',
      'phoneNumber': phoneNumber ?? '',
      'email': email ?? '',
      'bio': bio ?? '',
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String userId) {
    return UserModel(
      userId: userId,
      name: map['name'],
      avatar: map['avatar'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      bio: map['bio'],
    );
  }
}
