import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'e_bill.dart';


class EmergencyRequest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(

        backgroundColor: Colors.transparent,
        content: Container(

          // width: Gen.Screenwidth(context)/2,
          height: Gen.Screenheight(context)/2,
          child: Image.asset("assets/eme.png",fit: BoxFit.fill,),


        )


    );
  }


}
