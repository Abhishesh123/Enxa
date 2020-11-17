import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'e_bill.dart';


class ChargingPoint extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: customColor.dark_back,

        body: Container(
          width: Gen.Screenwidth(context),
          height: Gen.Screenheight(context),
          child: Image.asset("assets/chargingpoint.png",fit: BoxFit.fill,),
        )
    );
  }


}
