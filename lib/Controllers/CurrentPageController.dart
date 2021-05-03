import 'package:flutter/material.dart';

class CurrentPageContoller with ChangeNotifier{
  int pageNumber = 0;

  PageController pageController = PageController();

  void changePage(newPageNumber){
    pageNumber = newPageNumber;
    notifyListeners();
  }
}