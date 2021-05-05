import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class ImageStorage with ChangeNotifier {

  firebase_storage.FirebaseStorage _storageInstance = firebase_storage.FirebaseStorage.instance;
  String _downloadURL;

  Future<void> uploadFile(File file,String name) async {
    try {
      await _storageInstance
          .ref('$name.png')
          .putFile(file);
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadURL(String name) async {
    String downloadURL = await _storageInstance
        .ref('$name.png')
        .getDownloadURL();
    this._downloadURL = downloadURL;
    print(_downloadURL);
    notifyListeners();
  }

  String get getDownloadURL => _downloadURL;

}