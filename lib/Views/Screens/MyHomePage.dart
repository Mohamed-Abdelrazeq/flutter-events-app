import 'package:events_app/Controllers/PageProvider.dart';
import 'package:events_app/Views/Component/MyBottomNavigationBar.dart';
import 'package:events_app/Views/Component/MyFloatingActionButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AccountPage.dart';
import 'HomePage.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: ,
      body: Stack(
        children: [
          //BottomNavigationBar
          MyBottomNavigationBar(height: height, width: width),
          //TheApp
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: height * .92,
              width: width,
              child: PageView(
                controller: Provider.of<CurrentPageContoller>(context).pageController,
                onPageChanged: (newPage) {
                  Provider.of<CurrentPageContoller>(context, listen: false)
                      .changePage(newPage);
                },
                children: [
                  HomePage(),
                  AccountPage(),
                ],
              ),
            ),
          ),
          //FloatingActionButton
          Positioned(
            top: height * .87,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/AddEventScreen');
              },
              child: MyFloatingActionButton(height: height, width: width),
            ),
          ),
        ],
      ),
    );
  }
}
