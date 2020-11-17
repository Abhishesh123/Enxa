import 'package:enxa/values/customColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text CText(String text,double size,{Color color=customColor.white,FontWeight fontWeight=FontWeight.normal, EdgeInsets contentPadding}){
 return Text(text,style: GoogleFonts.muli(color: color,fontSize: size,fontWeight: fontWeight));
}

RaisedButton CRaisedButton({String text,VoidCallback onclick,Color color,double radius=0}){
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius)
    ),
    child: CText(text, 16,color: customColor.white),
    onPressed:onclick,
    color: color,
  );
}
