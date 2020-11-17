import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/components/schedule_dialog.dart';
import 'package:enxa/ui/pages/emergencyrequest.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Scheduler extends StatefulWidget {
  LatLng latLng;
  Position position;
  Scheduler(this.latLng,this.position);
  @override
  _SchedulerState createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: customColor.dark_back,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Icon(FontAwesomeIcons.heart,color: customColor.white,),
          SizedBox(width: 10,)
,          Icon(FontAwesomeIcons.share,color: customColor.white,),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/rp.jpeg",),
                    fit: BoxFit.cover
                  )
                ),
                height: Gen.Screenheight(context)/3,
                width: Gen.Screenwidth(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [Icon(Icons.camera,color: customColor.white,),
                    CText("Add Photo", 16,color: customColor.white)
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                width: Gen.Screenwidth(context),
                color: customColor.darkgrey,
                child: Stack(
                  overflow:Overflow.visible,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText("260 W Hubbard St,Chicago", 15,color: customColor.white),
                        CText("Hubbard Charge Station #2", 17,color: customColor.white),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: -20,
                      child: FloatingActionButton(
                        onPressed: (){
                          _launchMapsUrl();
                        },
                        backgroundColor: customColor.white,
                        child: Icon(Icons.my_location,color: customColor.orange,),
                      ),
                    )
                  ],
                ),

              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.battery_charging_full,color: customColor.orange,),
                      CText("ChargePoint Network", 12,color: customColor.white)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RaisedButton(onPressed: (){},
                      child: CText("ENXA", 12,color: customColor.black),
                        color: customColor.orange,
                      ),
                      SizedBox(width: 5,),
                      RaisedButton(onPressed: (){},
                      child: CText("THIRD PARTY", 12,color: customColor.black),
                        color: customColor.orange,
                      ),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      RaisedButton(onPressed: (){
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: CText("Available",12,color: customColor.white),
                      ),
                      SizedBox(height: 10,),

                      CText("10 - 20 mi/hr", 12,color: customColor.grey),
                      SizedBox(height: 10,),

                      CText("3.3 - 6.6 kW", 12,color: customColor.grey),
                      SizedBox(height: 10,),

                      CText("(J1772)", 12,color: customColor.grey),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(FontAwesomeIcons.chargingStation,color: customColor.white,size: 65,),
                     SizedBox(height: 20,),
                      CText("Shared Power", 12,color: customColor.grey),
                    ],
                  ),
                  Column(
                    children: [
                      RaisedButton(onPressed: (){
                        },
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: CText("In Use",12,color: customColor.white),
                      ),
                      SizedBox(height: 10,),
                      CText("10 - 20 mi/hr", 12,color: customColor.grey),
                      SizedBox(height: 10,),
                      CText("3.3 - 6.6 kW", 12,color: customColor.grey),
                      SizedBox(height: 10,),
                      CText("(J1772)", 12,color: customColor.grey),
                    ],
                  )
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(onPressed: (){
                    showDialog(context: context,
                    builder: (context){
                      return ShedulerDialog();
                    }
                    );
                  },
                    child: CText("SCHEDULE", 12,color: customColor.black),
                    color: customColor.orange,
                  ),
                  RaisedButton(onPressed: (){
                    showDialog(context: context,
                        builder: (context){
                          return EmergencyRequest();
                        }
                    );
                  },
                    child: CText("REQUEST IN EMERGENCY", 12,color: customColor.black),
                    color: customColor.blue,
                  ),
                ],
              ),
              Container(
                height: 30,
                alignment: Alignment.center,
                width: Gen.Screenwidth(context)*.8,
                color: customColor.blue.withOpacity(0.3),
                child: CText("Just tap your phone on the station", 14,color: customColor.white),

              ),
              Divider(height: 2,color: customColor.grey,),
              ListTile(
                leading: Icon(Icons.info,color: customColor.grey,),
                title: CText("Station info", 16,color: customColor.grey),
                subtitle: CText("2nd LEVEL UP RAMP", 16,color: customColor.white),
              ),
              Divider(height: 2,color: customColor.grey,),
              ListTile(
                leading: Icon(Icons.money,color: customColor.grey,),
                title: CText("Price (Set by Hubbard Place)", 16,color: customColor.grey),
                subtitle: CText("Free", 16,color: customColor.white),
              ),
              Divider(height: 2,color: customColor.grey,),
              ListTile(
                leading: Icon(Icons.money,color: customColor.grey,),
                title: CText("Popular Times", 16,color: customColor.grey),
                subtitle: CText("100% usage", 16,color: customColor.darkgrey),
                trailing: CText("Mondays", 12,color: customColor.darkgrey),
              ),
              ...List.generate(10, (index){
                return ListTile(
                  leading: Column(
                    children: [
                      Icon(Icons.location_on,color: Colors.green,),
                      Icon(Icons.cached,color: Colors.deepOrange,),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText("360 W Hubbard St,chicago", 13,color: customColor.grey),
                      CText("Hubbard Charge", 16,color: customColor.grey),
                      CText("Station #2", 16,color: customColor.grey),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(onPressed: (){
                },
                        child: CText("Available", 12,color: customColor.white),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),),
                      CText("AC", 16,color: customColor.darkgrey),
                      CText("FREE", 16,color: customColor.darkgrey),
                    ],
                  ),
                  trailing: CText("281 mi", 12,color: customColor.darkgrey),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
  void _launchMapsUrl() async {
    if(widget.latLng==null) return;
    final url = 'https://www.google.com/maps/dir/?api=1&origin=${widget.position.latitude},${widget.position.longitude}&destination=${widget.latLng.latitude},${widget.latLng.longitude}&travelmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
