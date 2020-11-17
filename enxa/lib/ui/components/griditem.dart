import 'package:enxa/values/customColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';


class GridItem extends StatelessWidget {
  IconData icon;
  String text;
  Color bgcolor;
  VoidCallback onclick;
  String tag;
  bool small=false;
  GridItem({this.icon,this.text,this.bgcolor,this.onclick,this.tag,this.small=false});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color:bgcolor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15)
      ),
      child: InkWell(
        onTap: (){
          onclick();
        },
        child: Hero(
          tag: tag,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color:bgcolor
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon,size: 30,color: customColor.white,),
                    Text(text,style: GoogleFonts.muli(color: customColor.white,fontSize: small?10:13),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
