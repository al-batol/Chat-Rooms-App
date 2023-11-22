import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:chat_rooms/src/features/auth/domain/entities/user.dart';

abstract class AuthenticationRepository {
  ResultFuture<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultStream<List<User>> getAllUsers();

  ResultVoid setUserData({required User user, bool isSigningIn = false});

  ResultVoid signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  ResultStream<dynamic> getUserChanges();

  ResultFuture<User> signInWithGoogle();
}
