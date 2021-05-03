import 'package:events_app/Controllers/UserCredentialController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    ) : Scaffold(
          body: Center(
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/login.png'),
                    width: width*.7,
                  ),
                  Text(
                    'You Need To Login',
                    style: TextStyle(
                      color: Colors.black.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontSize: height*.04
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}

class UserDataCard extends StatelessWidget {
  const UserDataCard({
    @required this.width,
    @required this.height,
    @required this.icon,
    @required this.myFunc,
    @required this.text,

  });

  final double width;
  final double height;
  final IconData icon;
  final Function myFunc;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*.8,
      height: height*.08,
      margin: EdgeInsets.only(bottom: height*.02),
      padding: EdgeInsets.symmetric(horizontal: width*.04),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(width*.5)
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,color: Colors.black,size: height*.05,),
                SizedBox(width: width*.03,),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: width*.04,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: myFunc,
              child: Icon(Icons.drive_file_rename_outline,color: Colors.blue,size: height*.03,),
            ),
          ],
        ),
      ),
    );
  }
}
