import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_app/Views/Component/MyButton.dart';
import 'package:events_app/Views/Component/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final Color flushBarColor = Colors.blue;

  Future register({String email,String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'password';
      } else if (e.code == 'email-already-in-use') {
        return 'email' ;
      }
    } catch (e) {
      return 'else';
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
    } else if (usernameController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your username",
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
    }else if (phoneController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your phone number",
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
    else {
      //make request
      var myReturn = await register(
        email: emailController.text,
        password: passwordController.text,
      );
      //test response
      if (myReturn == true) {
        await addUser(email: emailController.text,password: passwordController.text,phone: phoneController.text,username: usernameController.text);
        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        phoneController.clear();
        Navigator.pushNamed(context, '/MyHomePage');
      } else if (myReturn == 'password') {
        passwordController.clear();
        Flushbar(
          title: "Warning",
          message: "Your password is not valid",
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
        emailController.clear();
        Flushbar(
          title: "Warning",
          message: "Your email in not valid",
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
        emailController.clear();
        passwordController.clear();
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

  Future<void> addUser({String email, String password, String username,String phone}) {

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users.add({
      'Email': email,
      'Password': password,
      'Username': username,
      'phone': phone,
    })
        .then((value) => print("sent"))
        .catchError((error) => print("Failed: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              //Logo
              SizedBox(height: height*.1,),
              Hero(
                tag: 'Logo',
                child: Container(
                  height: height*.2,
                  width: width*.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Logo.png')
                      )
                  ),
                ),
              ),
              //UserName
              SizedBox(height: height * .04),
              MyTextField(
                myColor: Colors.blue,
                myController: usernameController,
                height: height,
                width: width,
                myWidth: .8,
                myHeight: .1,
                hint: 'Username',
                myIcon: Icons.account_circle,),
              //Email
              SizedBox(height: height * .02),
              MyTextField(
                  myColor: Colors.blue,
                  myController: emailController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'E-Mail',
                  myIcon: Icons.email),
              //Password
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
              //Phone Number
              SizedBox(height: height * .02),
              MyTextField(
                myColor: Colors.blue,
                  myController: phoneController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'Phone',
                  myIcon: Icons.phone),
              SizedBox(height: height * .04),
              MyButton(
                myButtonColor: Colors.blue,
                width: width,
                height: height,
                myText: 'Register',
                horizontalPadding: width*.2,
                verticalPadding: height*.02,
                myTextColor: Colors.white,
                myFunc: () {
                  submissionFunction(context);
                },
              ),
              SizedBox(height: height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Already a User ?'
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * .1),
            ],
          ),
        ),
      ),
    );
  }
}

