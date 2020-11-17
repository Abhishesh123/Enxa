import 'package:enxa/ui/components/griditem.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/passbook.dart';
import 'package:enxa/ui/pages/singleImage.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';


class Energy extends StatefulWidget {
  @override
  _EnergyState createState() => _EnergyState();
}

class _EnergyState extends State<Energy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.dark_back,
      appBar: AppBar(
        backgroundColor: customColor.dark_back,
        title:CText("Energy", 20,color: customColor.grey),
      ),
      body: Container(
        height: Gen.Screenheight(context),
        decoration: BoxDecoration(
        ),
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: Gen.Screenwidth(context),
              child: RaisedButton(onPressed: (){
              },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              color: customColor.blue,
                child: CText("Add Your Product",16),
              ),
            ),
            SizedBox(height: 25,),
            GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              crossAxisCount: 2,children: [
              GridItem(text: "Home Solutions",icon: Icons.calendar_today,bgcolor: customColor.lightblack,onclick: (){Gen.Navigateto(context, SingleImage("hs"));},tag:"hs" ,),
              GridItem(text: "Area Solutions",icon: Icons.calendar_today,bgcolor: customColor.lightblack,onclick: (){Gen.Navigateto(context, SingleImage("as"));},tag:"as" ,),
              GridItem(text: "Charging solutions",icon: Icons.calendar_today,bgcolor: customColor.lightblack,onclick: (){Gen.Navigateto(context, SingleImage("cs"));},tag:"cs" ,),
              GridItem(text: "Portable Solutions",icon: Icons.calendar_today,bgcolor: customColor.lightblack,onclick: (){Gen.Navigateto(context, SingleImage("ps")); },tag:"ps" ,),
            ],),
            SizedBox(height: 25,),

            Container(
              width: Gen.Screenwidth(context),
              child: RaisedButton(onPressed: (){
                Gen.Navigateto(context, Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: customColor.white,
                    title: CText("Enxa", 20,color: customColor.black),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/icon.png",),
                      radius: 30,
                    ),
                  ),
                  body: Container(
                    alignment: Alignment.center,
                      child: ListView(children:[
                        Image.asset("assets/form.jpeg",fit: BoxFit.contain,),
                        SizedBox(height: 10,),
                        Image.asset("assets/a.jpeg",fit: BoxFit.contain,),
                        SizedBox(height: 10,),
                        Image.asset("assets/b.jpeg",fit: BoxFit.contain,),
                        SizedBox(height: 10,),
                        Image.asset("assets/c.jpeg",fit: BoxFit.contain,),
                        SizedBox(height: 10,),
                        Image.asset("assets/d.jpeg",fit: BoxFit.contain,)
                      ])

                  ),
                ));
              },
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: customColor.blue,
                child: CText("+ Join us",16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
