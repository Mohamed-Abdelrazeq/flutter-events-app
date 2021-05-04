import 'package:flutter/material.dart';

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
