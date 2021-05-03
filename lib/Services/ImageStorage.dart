import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageStorage{

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('file-to-upload.png')
          .putFile(file);
    } catch (e) {
      print(e);
    }
  }

}