import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/Start/Login.dart';
import 'package:enxa/ui/components/filter.dart';
import 'package:enxa/ui/components/griditem.dart';
import 'package:enxa/ui/components/payments.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/batteryicon.dart';
import 'package:enxa/ui/pages/energy.dart';
import 'package:enxa/ui/pages/route_planner.dart';
import 'package:enxa/ui/pages/scan.dart';
import 'package:enxa/ui/pages/swipeleft.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qrscan/qrscan.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_money.dart';
import 'charging.dart';
import 'chargingvehicle.dart';
import 'navdrwaer.dart';
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

class Home extends StatefulWidget {
  static DocumentSnapshot user;
  Home(userdata){
    user=userdata;
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<CustomPopupMenu> choices=List();

  static Position _position;
  double PinPillPosition=-100;
  int pinindex;
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(28.555229,77.285257);
  static GoogleMapController _mapcontroller;
  Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  List<CustomPopupMenu> stations=[];
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
    choices = <CustomPopupMenu>[
      CustomPopupMenu(title: 'All', icon: Icons.all_inclusive,onclick:(){setState(() {

      });}),
      CustomPopupMenu(title: 'Status', icon: Icons.electrical_services_sharp,onclick:(){setState(() {

      });}),
      CustomPopupMenu(title: 'Price', icon: Icons.money,onclick:(){
        setState(() {

        });       }),
      CustomPopupMenu(title: 'Connector type', icon: Icons.connect_without_contact,onclick:(){setState(() {
      });}),
      CustomPopupMenu(title: 'Network', icon: Icons.av_timer,onclick:(){setState(() {
      });}),

    ];
    _getCurrentLocation();
    _loadStations();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        if(PinPillPosition==100){
          setState(() {
            PinPillPosition=-100;
          });
          return;
        }
        SystemNavigator.pop(animated: true);
      },
      child: Scaffold(
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
              }
              ,
            ),



            navbar(),
            PunctureButton(),

            FloatingButton(),
            _detailWidget(),
            infowindowcustom(),
          ],
        ),
      ),
    );
  }
  // Widget navbar() {
  //   return   NavDrawer();
  // }
Widget FloatingButton(){
  return   Padding(
    padding: const EdgeInsets.only(left: 310.0, right: 20.0, top: 500.0),
    child: FloatingActionButton(
      child: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      backgroundColor: Colors.orange,
      onPressed: (){

        Gen.Navigateto(context, SwipeLeft());
      },


    ),

    // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}

  Widget navbar() {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedContainer(
        curve: Curves.linearToEaseOut,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
        child: Card(
          color: customColor.lightblack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: GestureDetector(
            onTap: (){
              showDialog(context: context,builder: (context){
                return NavDrawer();
              });
            },
            child: Container(

              padding: EdgeInsets.all(10),
              // margin: EdgeInsets.only(left: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[


                  // Text("Filters",style: GoogleFonts.lato(color: customColor.white),textAlign: TextAlign.center,),
                  SizedBox(width: 7,),
                  Icon(Icons.menu,color: customColor.white,size: 20,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget PunctureButton() {
    return Align(
      alignment: Alignment.topRight,
      child: AnimatedContainer(
        curve: Curves.linearToEaseOut,
        duration: Duration(milliseconds: 600),
        margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
        child: Card(
          color: customColor.lightblack,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: GestureDetector(
            onTap: (){
              showDialog(context: context,builder: (context){
                return Filter();
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Filters",style: GoogleFonts.lato(color: customColor.white),textAlign: TextAlign.center,),
                  SizedBox(width: 7,),
                  Icon(Icons.arrow_forward_ios,color: customColor.orange,size: 15,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Widget navdraver() {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: AnimatedContainer(
  //       curve: Curves.linearToEaseOut,
  //       duration: Duration(milliseconds: 600),
  //       margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
  //       child: Card(
  //         color: customColor.lightblack,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20)
  //         ),
  //         child: GestureDetector(
  //           onTap: (){
  //             showDialog(context: context,builder: (context){
  //               return NavDrawer();
  //             });
  //           },
  //           child: Container(
  //             padding: EdgeInsets.all(10),
  //             margin: EdgeInsets.only(left: 10),
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: <Widget>[
  //                 Text("Menu",style: GoogleFonts.lato(color: customColor.white),textAlign: TextAlign.center,),
  //                 SizedBox(width: 7,),
  //                 Icon(Icons.arrow_back,color: customColor.orange,size: 15,)
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .2,
      initialChildSize: .2,
      minChildSize: .2,
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
                Container(
                  width: Gen.Screenwidth(context)*.8,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: customColor.lightblack
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      RaisedButton(onPressed: (){
                        Gen.Navigateto(context, RoutePlanner());
                      },
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        color: customColor.blue,
                        child: CText("Route planner",16),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(icon: Icon(Icons.search,color: customColor.white,),
                              onPressed: ()=>null),
                          GestureDetector(

                          child: Image.asset("assets/yellobattery.png",width: 23.0,
                            height: 16.0,fit: BoxFit.fill,),
                                onTap: () {
                                  showDialog(context: context,
                                      builder: (context){
                                        return BatteryCharging();
                                      }
                                  );
                                },

                            onLongPress: ()async{
                              await Gen.setUser("0");
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return Login();
                              }));
                            },
                          ),
                          IconButton(icon: Icon(Icons.my_location,color: customColor.orange,), onPressed: (){
                            if(_position==null) return;
                            _mapcontroller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(_position.latitude,_position.longitude),
                                  zoom: 13.0,
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GridItem(small:false,text: "Transactions",icon: Icons.calendar_today,bgcolor: customColor.dark_back,onclick: (){Gen.Navigateto(context,Passbook());},tag:"passbook" ,),
                      GridItem(small:false,text: "Support",icon: Icons.support,bgcolor: customColor.dark_back,onclick: (){Gen.Navigateto(context,Support());},tag: "support",),
                      GridItem(small:false,text: "E-bills",icon: Icons.electrical_services_rounded,bgcolor: customColor.dark_back,onclick: (){Gen.Navigateto(context,EBill());},tag: "e_bill",),
                      GridItem(small:false,text: "Pay",icon: Icons.electric_car_outlined,bgcolor: customColor.dark_back,onclick: (){Gen.Navigateto(context, _scanQR());},tag: "Pay",),
                      GridItem(small:false,text: "E-connect",icon: Icons.battery_charging_full,bgcolor: customColor.dark_back,onclick: (){Gen.Navigateto(context,Energy());},tag: "hs",),

                    ],
                  ),
                )

              ],
            ),
          ),
        );
      },
    );
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
  _scanQR() async {
    String cameraScanResult = await scan();
    String data='10';
    if ( data != null) {
      Gen.Navigateto(context, Payments(data));
    }
  }

  Widget infowindowcustom()
  {
    return AnimatedPositioned(
      top: PinPillPosition,right: 0,left: 0,
      duration: Duration(milliseconds: 300),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Gen.Navigateto(context, Scheduler(LatLng(sts[pinindex]['lat'],sts[pinindex]['lang']),_position));
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: customColor.white
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 50, height: 50,
                            child: ClipOval(
                                child:
                                Image.asset(
                                    "assets/marker.png",
                                    fit: BoxFit.contain)                       )
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Positron charging station"
                                  ,
                                  style: GoogleFonts.lato(
                                      color: Colors.grey
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 2,
                                ),
                                Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(int.parse("3").floor(), (index){
                                      return Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,size: 10,);
                                    })

                                ),
                                Text("Geeta colony, Nirman Vihar, New Delhi 110025",
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.grey
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 2,
                                )], // end of Column Widgets
                            ),  // end of Column
                          ),  // end of Container
                        ),
                      ]
                  )
              ),
            ),
          )
      ),

    );
  }


}


class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon,this.onclick});
  String title;
  IconData icon;
  VoidCallback onclick;
}



const darkMapStyle = r'''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
''';