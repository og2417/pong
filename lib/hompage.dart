import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/brick.dart';
enum dir{up,down,left,right}
class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  double bx=0;
  double by=0;
  double px=0;
  var MAX=10;
  double otherbrick=-0.2;
  double pwidth=0.5;
  double escore=0;
  double pscore=0;
  var ballydir=dir.down;
  var ballxdir=dir.left;
  bool gamestart=false;

  void start(){
    gamestart=true;
    Timer.periodic(Duration(milliseconds: 1),(timer){
      updatedir();
      movedir();
      moveotherbrick();

      if(isloosing()){
        escore++;
        timer.cancel();
        bx=0;
        by=0;
        px=-0.2;
        otherbrick=-0.2;
        if(escore>=MAX){
          setState(() {
            _showDialog(true);
          });
        }

      };
      if(isotherdead()){
        pscore++;
        timer.cancel();
        bx=0;
        by=0;
        px=-0.2;
        otherbrick=-0.2;
        if(pscore>=MAX) {
          setState(() {
            _showDialog(true);
          });
        }
      }
    });
  }
  void _showDialog(bool edied){
    showDialog(
        context:context,
        barrierDismissible:false,
        builder:(BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child:Text(
                edied? "Player two wins":"Player one wins",
                style: TextStyle(color:Colors.black),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap:reset,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.black,
                      child: Text(
                        'Play Again',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
              ),
              GestureDetector(
                  onTap: (){
                    SystemNavigator.pop();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.black,
                      child: Text(
                        'Exit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
              )
            ],
          );
        }
    );
  }
  void moveotherbrick(){
    setState(() {
      otherbrick=bx*0.9;
    });
  }
  void reset(){
    Navigator.pop(context);
    setState(() {
      gamestart=false;
      bx=0;
      by=0;
      px=-0.2;
      pscore=0;
      escore=0;
      otherbrick=-0.2;
    });
  }
  bool isotherdead(){
    if(by<=-1){
      return true;
    }
    return false;
  }
  bool isloosing(){
    if(by>=1){
      return true;
    }
    return false;
  }
  void updatedir(){
    setState(() {
      if(by>=0.9&&px+pwidth>=bx&&px<=bx){
        ballydir=dir.up;
      }
      else if(by<=-0.9&&otherbrick+pwidth>=bx&&otherbrick<=bx){
        ballydir=dir.down;
      }
      if(bx>=1){
        ballxdir=dir.left;
      }
      else if(bx<=-1){
        ballxdir=dir.right;
      }
    });
  }
  void movedir(){
    setState(() {
      if(ballydir==dir.down){
        by+=0.01;
      }
      else if(ballydir==dir.up){
        by-=0.01;
      }

      if(ballxdir==dir.left){
        bx-=0.01;
      }
      else if(ballxdir==dir.right){
        bx+=0.01;
      }
    });
  }
  void moveRight(){
    setState(() {
      if(!(px+pwidth>=1)){
        px+=0.1;
      }

    });
  }
  void moveLeft(){
    setState(() {
      if(!(px-0.1<=-1)){
        px-=0.1;
      }
    });
  }



  @overr ide
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
          if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
            moveLeft();
          }
          else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
            moveRight();
          }


    },

      child: GestureDetector(
        onTap: start,
        child: Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Stack(
              children: [
                MyBrick(x:otherbrick,y:-0.9,bwidth: pwidth,),
                MyBrick(x:px,y:0.9,bwidth: pwidth,),
                MyBall(x:bx,y:by),
                Container(
                  alignment:Alignment(0,0.2) ,
                  child:Text(gamestart ?'' :'TAP TO START',style:TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold,)) ,
                ),
                Container(
                  alignment: Alignment(0,0),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      alignment: Alignment(-0.8,-0.5),
                      child: Text(pscore.toString(),style:TextStyle(color: Colors.white24,fontSize:40),),
                    ),

                    Container(
                      alignment: Alignment(-0.8,0.5),
                      child: Text(escore.toString(),style:TextStyle(color: Colors.white24,fontSize:40),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

