import 'package:flutter/material.dart';

class PleaseLogin extends StatelessWidget {
  const PleaseLogin({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
