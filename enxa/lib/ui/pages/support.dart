import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "support",
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: customColor.dark_back,
          appBar: AppBar(
            centerTitle: true,
            title: CText("Support", 15,color: customColor.white),
            backgroundColor: customColor.dark_back,
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _supportItem("Customer Care",Icons.play_arrow),
                SizedBox(height: 15,),
                _supportItem("Battery Swapping Service",Icons.phone_android),
                SizedBox(height: 15,),
                _supportItem("Mobile Charging System",Icons.email),
                SizedBox(height: 15,),
                _supportItem("Instant Stranded Mode Support",Icons.error),
                SizedBox(height: 15,),
                _supportItem("Help",Icons.help),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _supportItem(text,icon){
    return Card(
      color: customColor.lightblack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
          height: 70,
          width: Gen.Screenwidth(context)*.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon,color: customColor.grey,),
              SizedBox(width: 25,),
              CText(text, 16),
            ],
          )),
    );
  }
}
