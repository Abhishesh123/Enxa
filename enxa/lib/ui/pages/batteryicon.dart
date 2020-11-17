import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/chargingvehicle.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'e_bill.dart';


class BatteryCharging extends StatelessWidget {
  String data='Positron 1';

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
        backgroundColor: customColor.dark_back,

    //     content: Container(
    //       // // width: Gen.Screenwidth(context)/2,
    //       // height: Gen.Screenheight(context)/3,
    //       child: Image.asset("assets/chargingbattery.png",fit: BoxFit.fill,),
    //
    //
    // ),

      actions: <Widget>[
        FlatButton(
            child: Image.asset("assets/chargingbattery.png",fit: BoxFit.fill,),

            onPressed: (){
              Gen.Navigateto(context, ChargingVehicle(''));
            },

        ),

      ],

    );

  }


}
