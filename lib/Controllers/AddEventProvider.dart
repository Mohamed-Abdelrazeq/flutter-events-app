import 'package:flutter/material.dart';

class AddEventProvider with ChangeNotifier{
  DateTime eventDate = DateTime.now();
  var location;
  bool locationSelected = false;

  void dateSetter(newEventDate){
    eventDate = newEventDate;
    print(eventDate);
    notifyListeners();
  }

  void locationSelectedSetter(newLocation){
    location = newLocation;
    locationSelected = true;
    notifyListeners();
  }

}