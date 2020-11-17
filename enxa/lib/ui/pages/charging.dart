import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/chargingvehicle.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:enxa/values/vehicles.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/loaderdialog.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/home.dart';

import 'home.dart';

class Charging extends StatefulWidget {
  @override
  _ChargingState createState() => _ChargingState();
}

class _ChargingState extends State<Charging> {
  String selected_vehicle="";
  get value => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.dark_back,
      appBar: AppBar(
        backgroundColor: customColor.dark_back,
        title: CText("Charging", 15),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: CText("Your vehicle : "+selected_vehicle,16,color: customColor.white),
            ),
//              Container(
//                height: 100,
//                child: Image.asset("asset/two_wheeler"),
//              ),
            _heading("assets/two_wheeler.jpeg","Two wheeler"),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: Vehicles.two_wheelers.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: () async{
                      setState(() {
                        selected_vehicle=Vehicles.two_wheelers[index];
                      });
                      _moveto();
                    },
                    leading: CircleAvatar(
                      backgroundColor: customColor.orange,
                      child: CText(Vehicles.two_wheelers[index][0],15),
                    ),
                    title: CText(Vehicles.two_wheelers[index],15,color: customColor.white),
                  );
                },
              ),
              Divider(),
              _heading("assets/car.jpeg","Car"),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: Vehicles.cars_three_wheelers.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      setState(() {
                        selected_vehicle=Vehicles.cars_three_wheelers[index];
                      });
                      _moveto();
                    },
                    leading: CircleAvatar(
                      backgroundColor: customColor.orange,
                      child: CText(Vehicles.cars_three_wheelers[index][0],15),
                    ),
                    title: CText(Vehicles.cars_three_wheelers[index],15,color: customColor.white),
                  );
                },
              ),
              Divider(),
              _heading("assets/truck1.jpeg","Truck"),
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: Vehicles.trucks.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      setState(() {
                        selected_vehicle=Vehicles.trucks[index];
                      });
                      _moveto();
                    },
                    leading: CircleAvatar(
                      backgroundColor: customColor.orange,
                      child: CText(Vehicles.trucks[index][0],15),
                    ),
                    title: CText(Vehicles.trucks[index],15,color: customColor.white),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  _heading(name,text){
    return Container(
     height: 100,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20)
     ),
     alignment: Alignment.center,
     width: Gen.Screenwidth(context),
     child: Stack(
       fit: StackFit.expand,
       children: [
         ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(name,fit: BoxFit.cover,)),
         Align(
           alignment: Alignment.center,
             child: CText(text,25))
       ],
     ),
    );
  }

  void _moveto() async{
    // String a=await scan();
    // if(a!=null){

      var data=Map();
      data['name']=selected_vehicle;

      Gen.Navigateto(context, Home(value));
    }
  }
// }
