import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Gen{
  static Screenheight(BuildContext context)=>MediaQuery.of(context).size.height;
  static Screenwidth(BuildContext context)=>MediaQuery.of(context).size.width;
  static SharedPreferences _prefs;



  Future<bool> UpdateUser() async{
   await  FirebaseFirestore.instance.collection("user").doc(Home.user.id).get().then((value){
      Home.user=value;
    });
    return true;
  }


  Future<bool> CheckIfExist(phone) async{
   QuerySnapshot querySnapshot=await  FirebaseFirestore.instance.collection('user').where('phone',isEqualTo: phone).get();
   if(querySnapshot.docs.length>0){
     return true;
   }else{
     return false;
   }
  }

  static Future<String> getUser()async{
    _prefs=await SharedPreferences.getInstance();
    if(_prefs.containsKey('user')){
      if(_prefs.getString('user')!='0'){
        return _prefs.getString('user');
      }
    }
    return null;
  }

  static Future<void> setUser(String value)async{
    _prefs=await SharedPreferences.getInstance();
    _prefs.setString('user', value);
  }



  static Navigateto(BuildContext context,Widget destination){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return destination;
    }));
  }
}

MyToast(text,context){
  Toast.show(text, context,backgroundRadius: 5,backgroundColor: customColor.black,textColor: customColor.grey,duration: Toast.LENGTH_LONG,gravity: Toast.CENTER);
}
