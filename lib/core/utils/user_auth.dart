import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/core/services/injection_container.dart';
import 'package:chat_rooms/src/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static final FirebaseAuth auth = sl();
  static final FirebaseFirestore firestore = sl();

  const UserAuth();

  static Future<void> sendEmailVerification() async {
    await auth.currentUser?.sendEmailVerification();
  }

  static Future<UserModel?> getUserData() async {
    final String? uid = auth.currentUser?.uid;
    try {
      if (uid != null) {
        final getUser = await firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .get();
        final UserModel userModel = UserModel.fromMap(getUser.data()!, uid);
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      throw const UsersException(CAN_NOT_LOAD_USER);
    }
  }
}
