import 'package:events_app/Controllers/UserProvider.dart';
import 'package:events_app/Views/Component/MyButton.dart';
import 'package:events_app/Views/Component/MyTextFieldAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color flushBarColor = Colors.blue;

  Future login({String email, String password, var context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Provider.of<UserProvider>(context, listen: false)
          .userEmailSetter(email);

      return true;
    } on FirebaseAuthException catch (e) {
      print('===================');
      if (e.code == 'user-not-found') {
        return 'email';
      } else if (e.code == 'wrong-password') {
        return 'password';
      } else {
        return 'else';
      }
    }
  }

  void submissionFunction(var context) async {
    //Close Keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    //Check textfields
    if (emailController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your email",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (passwordController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your password",
        backgroundColor: flushBarColor,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      //make request
      var myReturn = await login(
          email: emailController.text,
          password: passwordController.text,
          context: context);
      //test response
      if (myReturn == true) {
        print(true);
        emailController.clear();
        passwordController.clear();
        Navigator.pushNamed(context, '/MyHomePage');
      } else if (myReturn == 'password') {
        Flushbar(
          title: "Warning",
          message: "Your password is not correct",
          backgroundColor: flushBarColor,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      } else if (myReturn == 'email') {
        Flushbar(
          title: "Warning",
          message: "Your email in not correct",
          backgroundColor: flushBarColor,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      } else {
        Flushbar(
          title: "Warning",
          message: "Invalid email and password",
          backgroundColor: flushBarColor,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: height * .18,
              ),
              Hero(
                tag: 'Logo',
                child: Container(
                  height: height * .2,
                  width: width * .4,
                  decoration: BoxDecoration(
                      image:
                      DecorationImage(image: AssetImage('images/Logo.png'))),
                ),
              ),
              SizedBox(height: height * .04),
              MyTextField(
                  myColor: Colors.blue,
                  myController: emailController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'E-Mail',
                  myIcon: Icons.email),
              SizedBox(height: height * .02),
              MyTextField(
                myColor: Colors.blue,
                  myController: passwordController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'Password',
                  myIcon: Icons.lock),
              SizedBox(height: height * .04),
              MyButton(
                myButtonColor: Colors.blue,
                width: width,
                height: height,
                myText: 'Login',
                horizontalPadding: width * .2,
                verticalPadding: height * .02,
                myTextColor: Colors.white,
                myFunc: () {
                  submissionFunction(context);
                },
              ),
              SizedBox(height: height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a User ?'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/Register');
                    },
                    child: Text(
                      ' Join Now',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

