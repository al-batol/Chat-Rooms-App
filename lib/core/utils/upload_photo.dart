import 'dart:io';

import 'package:chat_rooms/core/errors/failure.dart';
import 'package:chat_rooms/core/errors/strings.dart';
import 'package:chat_rooms/core/services/injection_container.dart';
import 'package:chat_rooms/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPhoto {
  static final FirebaseStorage _firebaseStorage = sl();

  static ResultFuture<String> uploadPhoto(
      {required File image, required String path}) async {
    try {
      final List splitPath = path.split('/');
      final String pathToRemove = splitPath[0] + '/' + splitPath[1];
      try {
        final ListResult result = await _firebaseStorage.ref().child(pathToRemove).listAll();
        for (var ref in result.items) {
          ref.delete();
        }
      } catch (e) {

      }
      final uploadPhoto =
          await _firebaseStorage.ref().child(path).putFile(image);
      String photoUrl = await uploadPhoto.ref.getDownloadURL();
      return Right(photoUrl);
    } catch (e) {
      return left(const StorageFailure(message: PHOTO_WAS_NOT_UPLOADED));
    }
  }
}
