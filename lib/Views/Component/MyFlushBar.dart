import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class MyFlushBar{
  //Constant
  static const Color flushBarColor = Colors.blue;
  //Function
  show(context,text){
    Flushbar(
      title: "Warning",
      message: text,
      backgroundColor: flushBarColor,
      duration: Duration(seconds: 2),
    ).show(context);
  }
}
