import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier{

  UserCredential _userCredential;
  String _username;
  String _phone;

  void userCredentialSetter(UserCredential newUserCredential){
    _userCredential = newUserCredential;
    notifyListeners();
  }

  void userAdditionalInfoSetter(String username,String phone){
    _username = username;
    _phone = phone;
  }

  UserCredential get userCredential => _userCredential;
  String get username => _username;
  String get phone => _phone;

}