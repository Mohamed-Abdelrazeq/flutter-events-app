import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier{
  DateTime eventDate = DateTime.now();

  void dateSetter(newEventDate){
    eventDate = newEventDate;
    print(eventDate);
    notifyListeners();
  }

}