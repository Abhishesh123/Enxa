import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';

import 'reusable_components.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  List<bool> _filters=[true,true,false,true,true,false,true,true,false,true,false,true,true,true,];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: customColor.dark_back,
      title: CText("Filters",15,color: customColor.grey),
      content: Container(
        color: customColor.dark_back,
        height: Gen.Screenheight(context)*.9,
        width: Gen.Screenwidth(context)-20,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText("Status", 16,color: customColor.darkgrey,fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Available", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[0],
                    onChanged: (a){
                      setState(() {
                        _filters[0]=a;
                      });
                    },
                  ),
                ],
              ),
              CText("Price", 16,color: customColor.darkgrey,fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Free", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[1],
                    onChanged: (a){
                      setState(() {
                        _filters[1]=a;
                      });
                    },
                  ),
                ],
              ),
              CText("Connector Type", 16,color: customColor.darkgrey,fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Ac-Wall outlet", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[2],
                    onChanged: (a){
                      setState(() {
                        _filters[2]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Ac-J1742", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[3],
                    onChanged: (a){
                      setState(() {
                        _filters[3]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Ac-Nema 1450", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[4],
                    onChanged: (a){
                      setState(() {
                        _filters[4]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Ac-Tesla", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[5],
                    onChanged: (a){
                      setState(() {
                        _filters[5]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Dc- Fastchademo", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[6],
                    onChanged: (a){
                      setState(() {
                        _filters[6]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("DC-fast combo", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[7],
                    onChanged: (a){
                      setState(() {
                        _filters[7]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Sipercharger-Tesla", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[8],
                    onChanged: (a){
                      setState(() {
                        _filters[8]=a;
                      });
                    },
                  ),
                ],
              ),
              CText("Connector Type", 16,color: customColor.darkgrey,fontWeight: FontWeight.bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("ENXA", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[9],
                    onChanged: (a){
                      setState(() {
                        _filters[9]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Blink", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[10],
                    onChanged: (a){
                      setState(() {
                        _filters[10]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Semacharge", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[11],
                    onChanged: (a){
                      setState(() {
                        _filters[11]=a;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("EVgo", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[12],
                    onChanged: (a){
                      setState(() {
                        _filters[12]=a;
                      });

                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  CText("Flo", 15,color: customColor.white,fontWeight: FontWeight.normal),
                  Switch(
                    activeColor: customColor.orange,
                    value: _filters[13],
                    onChanged: (a){
setState(() {
  _filters[13]=a;
});
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
