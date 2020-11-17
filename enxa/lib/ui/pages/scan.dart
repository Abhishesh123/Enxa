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

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}
class _ScanState extends State<Scan> {
  String result = "Hello World...!";
  Future _scanQR() async {
    String cameraScanResult = await scan();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _scanQR(); // calling a function when user click on button
            },
            label: Text("Scan")), // Here the scanned result will be shown
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}