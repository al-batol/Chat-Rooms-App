import 'dart:io';

import 'package:chat_rooms/core/utils/show_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class PickPhoto {
  const PickPhoto();

  static Future<File?> pickPhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    File? photo;
    try {
      final pickedPhoto = await picker.pickImage(source: ImageSource.gallery);
      if (pickedPhoto != null) {
        photo = File(pickedPhoto.path);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString(), false);
      }
    }
    return photo;
  }
}
