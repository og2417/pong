import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  double x;
  double y;
  double bwidth;
  MyBrick({required this.x,required this.y,required this.bwidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:Alignment((2*x+bwidth)/(2-bwidth),y) ,
      child: ClipRRect(
        child: Container(
          color:Colors.white,
          height: 10,
          width:80,
        ),
      ),
    );
  }
}
