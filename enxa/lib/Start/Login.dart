import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/loaderdialog.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/ui/pages/passbook.dart';
import 'package:enxa/values/gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


import 'Register.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone;
  String pwd;
  var _key=GlobalKey<FormState>();

  get value => null;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop(animated: true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(25),
          alignment: Alignment.center,
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100,),
                  Text("SIGN IN",style: TextStyle(fontSize: 20,letterSpacing: 2),),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Phone"
                    ),
                    validator: (a){

                      if(a.isEmpty) return "Please enter your phone";
                      phone=a;
                      return null;
                    },
                  ),
                  SizedBox(height: 25,),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                    validator: (a){
                      if(a.isEmpty) return "Please enter password";
                      pwd=a;
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  Text("Forgot your password? ",style: TextStyle(color: Colors.grey),),
                  // GestureDetector(
                  //     onTap: (){
                  //       Gen.Navigateto(context, Charging());
                  //     },
                  //     child: Text("password?",style: GoogleFonts.muli(color: Colors.deepPurpleAccent),)),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(15),
                      color: CupertinoColors.black,
                      child: Text("Submit",style: GoogleFonts.muli(color: Colors.white),),
                      onPressed: (){
                        if(_key.currentState.validate()){
                          _login();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 1,color: Colors.grey,width: 50,),
                      Text("Sign in with"),
                      Container(height: 1,color: Colors.grey,width: 50,),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",style: GoogleFonts.muli(color: Colors.grey,fontSize: 18),),
                      GestureDetector(
                          onTap: (){
                            Gen.Navigateto(context, Register());
                          },
                          child: Text("Signup",style: GoogleFonts.muli(color: Colors.deepPurpleAccent),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async{
    LoaderDialog(context, false);
    FirebaseFirestore.instance.collection('user').where('phone',isEqualTo: phone).where('password',isEqualTo: pwd).get().then((value)async{
      Navigator.pop(context);
      if(value.docs.length>0){
       await Gen.setUser(value.docs.first.id);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return Charging();
        }));
      }else{
        MyToast("Wrong phone or password", context);
      }
    });
  }
}
