import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/Start/Login.dart';
import 'package:enxa/ui/components/filter.dart';
import 'package:enxa/ui/components/griditem.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/energy.dart';
import 'package:enxa/ui/pages/home.dart';
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


class RouteP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: customColor.dark_back,

      body: Container(
        width: Gen.Screenwidth(context),
        height: Gen.Screenheight(context),
        child: Image.asset("assets/rp.jpeg",fit: BoxFit.fill,),
      )
    );
  }


}
