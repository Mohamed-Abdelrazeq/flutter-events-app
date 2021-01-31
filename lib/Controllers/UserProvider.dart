import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String userEmail = '';

  void userEmailSetter(email){
    this.userEmail = email;
    notifyListeners();
  }

}