import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/values/gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Register.dart';
import '../ui/pages/home.dart';



class LoginDecider extends StatefulWidget {
  @override
  _LoginDeciderState createState() => _LoginDeciderState();
}

class _LoginDeciderState extends State<LoginDecider> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  DateTime currentBackPressTime;

  @override
  void initState() {
    currentBackPressTime=DateTime.now();
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
         duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.5).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCirc));
    _animationController.forward();
    _getuser();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body:  Center(
        child:
        ScaleTransition(
            scale:_animation,
            child: Center(
                child:
                SizedBox(height: 250.0, child:
                Image.asset("assets/icon.png",height: 200,width: 200,),)))
      )
    );
  }




  _getuser()async{
    await Firebase.initializeApp();
        if(await Gen.getUser()!=null){
          FirebaseFirestore.instance.collection('user').doc(await Gen.getUser()).get().then((value)async{
            DateTime now=DateTime.now();
            if(now.difference(currentBackPressTime)<Duration(milliseconds: 3000)){
              await  Future.delayed(Duration(milliseconds: 3000-now.difference(currentBackPressTime).inMilliseconds));
            }
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder:(context){
                  return Home(value);
                }
            ));
          });
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder:(context){
                return Login();
              }
          ));
        }
      }




@override
  void dispose() {
    if(_animationController!=null){
      _animationController.reset();
    }
  // TODO: implement dispose
    super.dispose();
  }

}



