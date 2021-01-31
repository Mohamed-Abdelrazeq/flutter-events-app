import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    @required this.height,
    @required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height*.08,
            width: height*.08,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(height),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Icon(Icons.add,color: Colors.white,size: height*.05,),
          )
        ],
      ),
    );
  }
}
