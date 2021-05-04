import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageStorage{

  firebase_storage.FirebaseStorage storageInstance = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(File file) async {
    try {
      await storageInstance
          .ref('file-to-upload.png')
          .putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future<String> downloadURL() async {
    String downloadURL = await storageInstance
        .ref('file-to-upload.png')
        .getDownloadURL();

    return downloadURL;
  }

}