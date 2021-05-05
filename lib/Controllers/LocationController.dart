import 'package:flutter/material.dart';

class LocationController with ChangeNotifier{

  //CurrentLocation
  double _currentLocationXAxis;
  double _currentLocationYAxis;

  double get getCurrentLocationXAxis => _currentLocationXAxis;
  double get getCurrentLocationYAxis => _currentLocationYAxis;

  set setCurrentLocationXAxis(currentLocationXAxis){
    _currentLocationXAxis = currentLocationXAxis;
    notifyListeners();
  }
  set setCurrentLocationYAxis(currentLocationYAxis){
    _currentLocationYAxis = currentLocationYAxis;
    notifyListeners();
  }


  var _selectedPartyLocationXAxis;
  var _selectedPartyLocationYAxis;
  bool   _selectionBool = false;

  bool   get getSelectionBool => _selectionBool;

  set setSelectedPartyLocationXAxis(selectedPartyLocationXAxis){
    _selectedPartyLocationXAxis = selectedPartyLocationXAxis;
    notifyListeners();
  }
  set setSelectedPartyLocationYAxis(selectedPartyLocationYAxis){
    _selectedPartyLocationYAxis = selectedPartyLocationYAxis;
    notifyListeners();
  }
  set setSelectionBool (bool state) {
    this._selectionBool = state;
    notifyListeners();
  }

}