import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCredentialProvider with ChangeNotifier{

  UserCredential _userCredential;

  void userCredentialSetter(newUserCredential){
    _userCredential = newUserCredential;
    notifyListeners();
  }

  UserCredential get userCredential => _userCredential;

}