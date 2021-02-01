import 'package:flutter/material.dart';

class MyLocationProvider with ChangeNotifier{
  var x;
  var y;

  var partyX;
  var partyY;

  bool selectionState = false;

  void selectionStateSetter(state){
    selectionState = state;
    notifyListeners();
  }

  void locationSetter(myX,myY){
    x = myX;
    y = myY;
    notifyListeners();
  }

  void partyLocationSetter(myPartyX,myPartyY){
    partyX = myPartyX;
    partyY = myPartyY;
    notifyListeners();
  }
}