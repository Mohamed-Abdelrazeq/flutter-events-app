import 'package:events_app/Controllers/UserInfoController.dart';
import 'package:events_app/Views/Component/UserDataCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PleaseLogin.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Provider.of<UserInfoController>(context).username != null ? Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            minRadius: width*.3,
            backgroundImage: AssetImage('images/me.jpg'),
          ),
          Column(
            children: [
              UserDataCard(width: width, height: height,text: Provider.of<UserInfoController>(context).username,myFunc: (){},icon: Icons.account_circle,),
              UserDataCard(width: width, height: height,text:  Provider.of<UserInfoController>(context).phone,myFunc: (){},icon: Icons.phone,),
            ],
          ),
        ],
      ),
    ) : PleaseLogin(width: width, height: height);
  }
}

