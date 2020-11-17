import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/loaderdialog.dart';
import 'package:enxa/logic/phone_auth.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/values/gen.dart';
import 'Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp_sheet.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String phone;
  String pwd1;
  String pwd2;
  PhoneAuth _phoneAuth;
  bool tnc=false;
  bool otpsent=false;
  var _key=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text("SIGN UP",style: TextStyle(fontSize: 20,letterSpacing: 2),),
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
                    if(a.length<6) return "Password must be atleast 6 characters";
                    if(pwd1!=pwd2) return "Both password should be same.";
                    pwd1=a;
                    return null;
                  },
                  onChanged: (a){
                    pwd1=a;
                  },
                ),
                SizedBox(height: 25,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Re-Enter password"
                  ),
                  validator: (a){
                    if(a.isEmpty) return "Please re-enter password";
                    if(a.length<6) return "Password must be atleast 6 characters";
                    if(pwd1!=pwd2) return "Both password should be same.";
                    pwd2=a;
                    return null;
                  },
                  onChanged: (a){
                    pwd2=a;
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Checkbox(
                      value: tnc,
                      onChanged: (a){
                        setState(() {
                          tnc=a;
                        });
                      },
                    ),
                    Text("I agree to the "),
                    Text("terms & conditions",style: TextStyle(color: Colors.deepPurpleAccent),)
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(15),
                    color: CupertinoColors.black,
                    child: Text(otpsent?"Enter otp":"Create Account",style: GoogleFonts.muli(color: Colors.white),),
                    onPressed: (){
                      if(otpsent){
                        showOtpBottomSheet(_phoneAuth, context);
                        return;
                      }
                      if(_key.currentState.validate()){
                        if(!tnc){
                          showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return Container(
                                  height: 100,
                                  child: ListTile(
                                    leading: Icon(Icons.error,color: Colors.deepPurpleAccent,),
                                    title: Text("Read and accept terms & conditions"),
                                  ),
                                );
                              }
                          );
                          return;
                        }
                        _register();
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
                    Text("Already have an account? ",style: GoogleFonts.muli(color: Colors.grey,fontSize: 18),),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Login",style: GoogleFonts.muli(color: Colors.deepPurpleAccent),)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async{
    LoaderDialog(context, false);
    if(await Gen().CheckIfExist(phone)){
      MyToast("User already registered", context);
      Navigator.pop(context);
      return;
    }else{
      Navigator.pop(context);
    }
    _phoneAuth=PhoneAuth(FirebaseAuth.instance, context, phone, oncodesent, onautoretrivaltimeout, onsuccess, onfailure);
    _phoneAuth.startPhoneAuth();
  }


  void oncodesent() {
    otpsent=true;
    showOtpBottomSheet(_phoneAuth, context);
    MyToast('code sent', context);
  }

  onfailure(String error) {
    MyToast(error, context);
  }

  void onsuccess() {
    LoaderDialog(context, false);
    FirebaseFirestore.instance.collection('user').add({
      'phone':phone,
      'password':pwd1,
      'datetime':DateTime.now(),
      'balance':0
    }).then((value)async{
      await Gen.setUser(value.id);
      Navigator.pop(context);
      value.get().then((mvalue){
        Gen.Navigateto(context, Charging());
      });
    });
  }

  void onautoretrivaltimeout(){
    MyToast("Auto retrieval timeout", context);
  }


}
