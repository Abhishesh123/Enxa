import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/Start/Login.dart';
import 'package:enxa/ui/components/filter.dart';
import 'package:enxa/ui/components/griditem.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/energy.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/ui/pages/route_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_money.dart';
import 'charging.dart';
import 'nearest_station.dart';
import 'passbook.dart';
import 'scheduler.dart';
import 'support.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'e_bill.dart';

class RoutePlanner extends StatefulWidget {
  @override
  _RoutePlannerState createState() => _RoutePlannerState();
}

class _RoutePlannerState extends State<RoutePlanner> {

  static Position _position;
  double PinPillPosition=-100;
  int pinindex;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(28.555229,77.285257);
  static GoogleMapController _mapcontroller;
  Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  List<DocumentSnapshot> sts=[];

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      _mapcontroller=controller;
      _mapcontroller.setMapStyle(darkMapStyle);
    });
  }



  @override
  void initState() {
    _getCurrentLocation();
    _loadStations();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: customColor.dark_back,

      body: Stack(
        children: <Widget>[

          GoogleMap(
            compassEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onTap: (LatLang) {
              setState(() {
                PinPillPosition =-100;
              });
            },
            onLongPress: (LatLang)async{
              FirebaseFirestore.instance.collection(Constant.STATIONS).add({
                'lat':LatLang.latitude,
                'lang':LatLang.longitude
              }).then((value){
                _markers.add(Marker(
                  // This marker id can be anything that uniquely identifies each marker.
                    markerId: MarkerId(LatLang.toString()),
                    position: LatLng(LatLang.latitude,LatLang.longitude),
                    // ignore: deprecated_member_use
                    icon:BitmapDescriptor.fromAsset( "assets/marker.png") ,
                    onTap: () {
                      setState(() {
                        PinPillPosition=100;
                      });
                    }
                ));
                setState(() {
                  _markers=_markers;
                });
              });
            },
          ),
          _detailWidget(),
        ],
      ),
    );
  }

  _loadStations()async{
    FirebaseFirestore.instance.collection(Constant.STATIONS).get().then((value){
      sts=value.docs;
      if(value.docs.length>0){
        for(int i=0;i<value.docs.length;i++){
          _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
              markerId: MarkerId(value.docs[i].id),
              position: LatLng(value.docs[i]['lat'],value.docs[i]['lang']),
              // ignore: deprecated_member_use
              icon:BitmapDescriptor.fromAsset( "assets/marker.png") ,
              onTap: () {
                setState(() {
                  pinindex=i;
                  PinPillPosition=100;
                });
              }
          ));
        }
        setState(() {
          _markers=_markers;
        });

      }else{
        MyToast("Opps! we don't have a station near you!", context);
      }
    });
  }



  _getCurrentLocation()async{
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(position!=null){
      _position=position;
    }else{
      MyToast("Unable to fetch location", context);
    }
    _mapcontroller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_position.latitude,_position.longitude),
          zoom: 13.0,
        ),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .3,
      initialChildSize: .3,
      minChildSize: .3,
      builder: (context, scrollController) {
        return Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: customColor.dark_back,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(0),
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Gen.Navigateto(context, RouteP());
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    width: Gen.Screenwidth(context)*.8,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: customColor.lightblack
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CText("Rohini sector -5", 15,color: customColor.white),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.settings,color: customColor.white,),
                            Icon(Icons.close,color: customColor.white,),
                          ],
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Gen.Navigateto(context, RouteP());
                  },
                  child: Container(
                    padding: EdgeInsets.all(7),
                    width: Gen.Screenwidth(context)*.8,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: customColor.lightblack
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CText("Ladakh", 15,color: customColor.white),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.settings,color: customColor.white,),
                            Icon(Icons.close,color: customColor.white,),
                          ],
                        )
                      ],
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GridItem(small:false,text: "Settings",icon: Icons.settings,bgcolor: customColor.dark_back,onclick: (){},tag:"jbfe" ,),
                    GridItem(small:false,text: "Reset",icon: Icons.reset_tv,bgcolor: customColor.dark_back,onclick: (){},tag:"hegj" ,),
                    GridItem(small:false,text: "Add",icon: Icons.add_circle_outline,bgcolor: customColor.dark_back,onclick: (){},tag:"jew" ,),

                  ],
                )

              ],
            ),
          ),
        );
      },
    );
  }



}
