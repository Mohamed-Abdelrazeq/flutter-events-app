import 'package:events_app/Controllers/UserCredentialController.dart';
import 'package:events_app/Services/Authentication.dart';
import 'package:events_app/Views/Component/MyButton.dart';
import 'package:events_app/Views/Component/MyFlushBar.dart';
import 'package:events_app/Views/Component/MyTextFieldAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

  void dispose() {
    _emailController.clear();
    _passwordController.clear();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> submissionFunction(var context) async {
    //Close Keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    MyFlushBar().show(context, 'Please Wait');
    //Check TextFields
    if (_emailController.text == '') {
      MyFlushBar().show(context, 'Enter your email');
    } else if (_passwordController.text == '') {
      MyFlushBar().show(context, 'Enter your password');
    }
    //Make Request
    else {
      //Get Credentials
      UserCredential userCredential = await Authentication().login(_emailController.text, _passwordController.text);
      //Check Response
      if (userCredential != null) {
        Map userAdditionalInfo = await Authentication().getUser(_emailController.text);
        Provider.of<UserInfoController>(context,listen: false).userCredentialSetter(userCredential);
        Provider.of<UserInfoController>(context,listen: false).userAdditionalInfoSetter(userAdditionalInfo['username'],userAdditionalInfo['phone']);
        dispose();
        Navigator.pushNamed(context, '/MyHomePage');
      }else{
        MyFlushBar().show(context, 'The Email or the Password is not correct');
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
                  myController: _emailController,
                  height: height,
                  width: width,
                  myWidth: .8,
                  myHeight: .1,
                  hint: 'E-Mail',
                  myIcon: Icons.email),
              SizedBox(height: height * .02),
              MyTextField(
                myColor: Colors.blue,
                  myController: _passwordController,
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
                myFunc: () async {
                  await submissionFunction(context);
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

