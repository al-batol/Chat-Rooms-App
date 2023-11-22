import 'package:chat_rooms/core/errors/exception.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/src/features/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Stream<List<UserModel>> getAllUsers();

  Future<Unit> setUserData({required UserModel user, bool isSigningIn = false});

  Future<Unit> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Stream<User?> getUserChanges();

  Future<UserModel> signInWithGoogle();
}

class AuthenticationRemoteDataSourceImp extends AuthenticationRemoteDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthenticationRemoteDataSourceImp(this._auth, this._firestore);

  @override
  Future<String> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await _auth.currentUser?.sendEmailVerification();

      return Future.value(_auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const AuthException(WEAK_PASSWORD_ERROR);
      } else if (e.code == 'email-already-in-use') {
        throw const AuthException(EMAIL_ALREADY_IN_USE);
      } else {
        throw const AuthException(UNEXPECTED_ERROR);
      }
    } catch (e) {
      throw const AuthException(UNEXPECTED_ERROR);
    }
  }

  @override
  Future<Unit> setUserData({
    required UserModel user,
    bool isSigningIn = false,
  }) async {
    try {
      final ref = _firestore.collection('users').doc(user.userId);
      await ref.get().then((doc) {
        if ((doc.exists && !isSigningIn) || !doc.exists) {
          _auth.currentUser!.updateDisplayName(user.name);
          _auth.currentUser!.updatePhotoURL(user.avatar);
          ref.set(
            user.toMap(),
            SetOptions(merge: true),
          );
        }
      });

      return Future.value(unit);
    } catch (e) {
      throw const AuthException(UNEXPECTED_ERROR);
    }
  }

  @override
  Future<Unit> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        if (!_auth.currentUser!.emailVerified) {
          _auth.currentUser!.sendEmailVerification();
        }
      }
      return Future.value(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const AuthException(USER_NOT_FOUND);
      } else if (e.code == 'wrong-password') {
        throw const AuthException(WRONG_PASSWORD);
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw const AuthException(WRONG_PASSWORD);
      } else {
        throw const AuthException(UNEXPECTED_ERROR);
      }
    }
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    try {
      return _firestore.collection('users').snapshots().asyncMap((users) {
        final List<UserModel> allUsers = [];
        for (var user in users.docs) {
          allUsers.add(UserModel.fromMap(user.data(), user.id));
        }
        return allUsers;
      });
    } catch (e) {
      throw const UsersException(CAN_NOT_LOAD_USERS);
    }
  }

  @override
  Stream<User?> getUserChanges() {
    try {
      return _auth.userChanges();
    } catch (e) {
      throw const UsersException(CAN_NOT_SEND_CONFIRMATION);
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final UserModel userModel = UserModel(
        name: userCredential.user?.displayName,
        userId: userCredential.user?.uid,
        avatar: userCredential.user?.photoURL,
        email: userCredential.user?.email,
        phoneNumber: userCredential.user?.phoneNumber,
      );

      return userModel;
    } catch (e) {
      throw const AuthException(TRY_AGAIN);
    }
  }
}
