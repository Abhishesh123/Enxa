import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/choosevehicle.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShedulerDialog extends StatefulWidget {
  @override
  _ShedulerDialogState createState() => _ShedulerDialogState();
}

class _ShedulerDialogState extends State<ShedulerDialog> {
  get value => null;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: customColor.dark_back,
      title: CText("SCHEDULE", 15,color: Colors.white),
      content: Container(
        alignment: Alignment.center,
        height: Gen.Screenheight(context)/2,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                CText("DATE", 12,color: customColor.white),
                CText("MONTH", 12,color: customColor.white),
                CText("YEAR", 12,color: customColor.white),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: customColor.white
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CText("23", 20,fontWeight: FontWeight.bold,color: customColor.black),
                  CText("09", 20,fontWeight: FontWeight.bold,color: customColor.black),
                  CText("20", 20,fontWeight: FontWeight.bold,color: customColor.black),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: customColor.white,width: 2),
                color: customColor.black
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CText("10", 20,fontWeight: FontWeight.bold,color: customColor.white),
                  CText("15", 20,fontWeight: FontWeight.bold,color: customColor.white),
                ],
              ),
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                CText("HOUR", 20,color: customColor.white),
                CText("MINUTES", 20,color: customColor.white),
              ],
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                showDialog(context: context,builder: (context){
                  return ChargeType();
                });
              },
              child: Container(

                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: customColor.white,width: 2),
                ),
                child: CText("CHARGING TYPE", 20,color: customColor.white),
              ),
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                showDialog(context: context,builder: (context){
                  return ChooseVehicle();
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: customColor.white,width: 2),
                ),
                child: CText("Choose Vehicle", 20,color: customColor.white),
              ),
            ),
            SizedBox(height: 16,),

           RaisedButton(
              child: CText("DONE", 20,color: customColor.black),
              onPressed: (){

                Navigator.pop(context);
              },
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}


class ChargeType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: customColor.dark_back,
      content: GestureDetector(
        onTap:(){
          Navigator.pop(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText("AC-Wall Outlet", 15),
            SizedBox(height: 7,),
            CText("AC-J1772", 15),
            SizedBox(height: 7,),
            CText("AC-NEMA 12-50", 15),
            SizedBox(height: 7,),
            CText("AC-Tesla", 15),
            SizedBox(height: 7,),
            CText("AC-Fast-CHADEMO", 15),
            SizedBox(height: 7,),
            CText("AC-Fast Combo", 15),
            SizedBox(height: 7,),
            CText("SuperCharhe Tesla", 15),
            SizedBox(height: 7,),
          ],
        ),
      ),
    );
  }
}
