import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';

class EBill extends StatefulWidget {
  @override
  _EBillState createState() => _EBillState();
}

class _EBillState extends State<EBill> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "e_bill",
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: customColor.dark_back,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: customColor.dark_back,
            elevation: 0,
            title: CText("Bill", 20,color: customColor.grey,fontWeight: FontWeight.bold),
          ),
          body: Container(
            width: Gen.Screenwidth(context),
            height: Gen.Screenheight(context),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CText("Total amount due", 15,color: customColor.grey),
                CText("Rs. 131.81", 30,color: customColor.white),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info,color: customColor.grey,),
                    CText("Auto bill pay schedule", 15,color: customColor.grey),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  width: Gen.Screenwidth(context)*.8,
                  child: RaisedButton(
                    onPressed: (){},
                    color: customColor.orange,
                    child: CText("Pay now",20,fontWeight: FontWeight.bold,color: customColor.white),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CText("Current Charges", 17,color: customColor.white,fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CText("Due Feb 9,2018", 17,color: customColor.grey),
                    CText("\$131.81", 17,color: customColor.grey),
                  ],
                ),
                SizedBox(height: 20,),
                Divider(
                  height: 2,
                  color: customColor.grey,
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CText("Bill Options",16,color: customColor.grey,fontWeight: FontWeight.bold),
                    CText("Payments Options",16,color: customColor.grey,fontWeight: FontWeight.bold)
                  ],
                ),
                SizedBox(height: 16,),
                ListTile(
                  title: CText("Edit payments", 16,color: customColor.white),
                  trailing: Icon(Icons.arrow_forward_ios,color: customColor.darkgrey,),
                ),
                Divider(height: 1,color: customColor.grey,),
                ListTile(
                  title: CText("Payment methods", 16,color: customColor.white),
                  trailing: Icon(Icons.arrow_forward_ios,color: customColor.darkgrey,),
                ),
                Divider(height: 1,color: customColor.grey,),
                ListTile(
                  title: CText("Auto bill pay", 16,color: customColor.white),
                  trailing: Icon(Icons.arrow_forward_ios,color: customColor.darkgrey,),
                ),
                Divider(height: 1,color: customColor.grey,),
                ListTile(
                  title: CText("Payment history", 16,color: customColor.white),
                  trailing: Icon(Icons.arrow_forward_ios,color: customColor.darkgrey,),
                ),
                Divider(height: 1,color: customColor.grey,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
