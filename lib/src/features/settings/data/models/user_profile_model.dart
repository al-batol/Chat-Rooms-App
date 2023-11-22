import 'package:chat_rooms/src/features/settings/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    super.userId,
    super.name,
    super.avatar,
    super.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
      'bio': bio,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      name: map['name'],
      avatar: map['avatar'],
      bio: map['bio'],
    );
  }

  UserProfile copyWith({
    String? userId,
    String? name,
    String? avatar,
    String? bio,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }
}
