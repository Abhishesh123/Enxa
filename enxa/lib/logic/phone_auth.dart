import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth{
   FirebaseAuth _firebaseAuth;
   BuildContext _context;
   String _phone;
   Function(String error) onfailure;
   VoidCallback onsuccess;
   VoidCallback oncodesent;
   VoidCallback onautoretrivaltimeout;
   String myvarificationid;

   PhoneAuth(FirebaseAuth firebaseAuth,
   BuildContext context,
   String phone,
   this.oncodesent,
   this.onautoretrivaltimeout,
   this.onsuccess,
   this.onfailure){
     this._phone=phone;
     this._context=context;
     this._firebaseAuth=firebaseAuth;
   }

   String get phone=>_phone;

  startPhoneAuth() async{
    FocusScope.of(_context).requestFocus(FocusNode());
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91" + _phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }



   void verificationCompleted(AuthCredential phoneAuthCredential) async{

     _firebaseAuth.signInWithCredential(phoneAuthCredential)
         .then((UserCredential value) {
       if (value.user != null) {
         onsuccess();
       } else {
         onfailure("Invalid code/invalid authentication");
       }
     }).catchError((error) {
       onfailure("Something has gone wrong, please try later");
     });
   }

   codeSent(String verificationId, [int forceResendingToken]) async {
     myvarificationid=verificationId;
     oncodesent();
   }

   codeAutoRetrievalTimeout(String verificationId) {
     onautoretrivaltimeout();
   }
   verificationFailed (FirebaseAuthException authException) {

     if (authException.message.contains('not authorized')){
     onfailure("Something has gone wrong, please try later");
     }
     else if (authException.message.contains('Network')){
       onfailure("Please check your internet connection and try again");}
     else{
       onfailure("Something has gone wrong, please try later");
     }
   }

   void signInWithPhoneNumber(String smsCode) async {
     var _authCredential = await PhoneAuthProvider.getCredential(
         verificationId: myvarificationid, smsCode: smsCode);
     _firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
       onfailure("Something has gone wrong, please again");
     }).then((user) async {
       if(user==null){
         onfailure("wrong otp");
         return;
       }
       if(user.user!=null){
         onsuccess();
       }
       else{
         onfailure("wrong otp");
       }
     });
   }
}

