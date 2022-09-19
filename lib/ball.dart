import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
double x;
double y;
MyBall({required this.x,required this.y});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:Alignment(x,y) ,

        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle,color:Colors.white,),
          width:25,
          height: 16,
        ),

    );
  }
}
