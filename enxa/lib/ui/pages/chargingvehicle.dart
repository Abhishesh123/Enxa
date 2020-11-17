import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/ui/components/griditem.dart';
import 'package:enxa/ui/components/payments.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/passbook.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:enxa/values/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qrscan/qrscan.dart';
import 'package:toast/toast.dart';

import '../../loaderdialog.dart';
import 'home.dart';

class ChargingVehicle extends StatefulWidget {
  var data;
  ChargingVehicle(this.data);
  @override
  _ChargingVehicleState createState() => _ChargingVehicleState();
}

class _ChargingVehicleState extends State<ChargingVehicle> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.dark_back,
      appBar: AppBar(
        backgroundColor: customColor.dark_back,
        title: CText("CHARGING - > "+"POSITRON 1",15),
      ),
      body: Container(
        decoration: BoxDecoration(
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CText("Supercharging",25),
            CText("40 mins remaining",15),
            SpinKitChasingDots(color: customColor.orange,),
            Image.asset(_getImage(),width: Gen.Screenwidth(context),height: Gen.Screenheight(context)/4,fit: BoxFit.cover,),
            GridView.count(
              childAspectRatio: 2,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              children: [
                GridItem(text: "20% charged",icon: Icons.battery_charging_full,bgcolor: customColor.dark_back,onclick: (){},tag:"passbook" ,),
                GridItem(text: "POSITRON 1",icon: Icons.local_car_wash,bgcolor: customColor.dark_back,onclick: (){},tag: "add_money",),
                GridItem(text:  "20KMs",icon: Icons.map,bgcolor: customColor.dark_back,onclick: (){},tag: "support",),
                GridItem(text: "Rs. 1",icon: Icons.money,bgcolor: customColor.dark_back,onclick: (){},tag: "nearest_station",),
              ],
            ),
            Container(
              width: Gen.Screenwidth(context),
              child: RaisedButton(onPressed: ()async{
                Map response = await  Navigator.push(context, MaterialPageRoute(builder: (context){
                  return _scanQR();
                }));
                if(response!=null){
                  LoaderDialog(context, false,text: "Completing transaction..");
                  FirebaseFirestore.instance.collection('user').doc(Home.user.id).update({
                    "balance":FieldValue.increment(-1)
                  }).then((value)async{
                    response['userid']=Home.user.id;
                    response['datetime']=DateTime.now().millisecondsSinceEpoch;
                    await  FirebaseFirestore.instance.collection(Constant.PAID_TO_SOMEONE).add(response);
                    await Gen().UpdateUser();
                    Toast.show("success", context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }              },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: customColor.blue,
                child: CText("stop and pay",16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scanQR() async {
    String cameraScanResult = await scan();
    String data='10';
    if ( data != null) {
      Gen.Navigateto(context, Payments(data));
    }
  }
  _getImage(){
    if(Vehicles.two_wheelers.contains("POSITRON 1")){
      return "assets/two_wheeler.jpeg";
    }
     if(Vehicles.trucks.contains("POSITRON 1")){
      return "assets/truck1.jpeg";
    }
     if(Vehicles.cars_three_wheelers.contains("POSITRON 1")){
      return "assets/car.jpeg";
    }

  }

}
