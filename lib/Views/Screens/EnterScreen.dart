import '../Component/MyButton.dart';
import 'package:flutter/material.dart';

class EnterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'Logo',
              child: Container(
                height: height*.3,
                width: width*.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/Logo.png')
                    )
                ),
              ),
            ),
            SizedBox(height: height * .04),
            MyButton(
              myButtonColor: Colors.blue,
              width: width,
              height: height,
              myText: 'Login',
              horizontalPadding: 0,
              verticalPadding: height*.02,
              myTextColor: Colors.white,
              myFunc: () {
                Navigator.pushNamed(context, '/Login');
              },
            ),
            SizedBox(height: height * .02),
            MyButton(
              myButtonColor: Colors.blue,
              width: width,
              height: height,
              myText: 'Register',
              horizontalPadding: 0,
              verticalPadding: height*.02,
              myTextColor: Colors.white,
              myFunc: () {
                Navigator.pushNamed(context, '/Register');
              },
            ),
            SizedBox(height: height * .02),
            MyButton(
              myButtonColor: Colors.blue,
              width: width,
              height: height,
              myText: 'Guest',
              horizontalPadding: 0,
              verticalPadding: height*.02,
              myTextColor: Colors.white,
              myFunc: () {
                Navigator.pushNamed(context, '/MyHomePage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
