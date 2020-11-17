import 'package:flutter/material.dart';

class NearestStation extends StatefulWidget {
  @override
  _NearestStationState createState() => _NearestStationState();
}

class _NearestStationState extends State<NearestStation> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "nearest_station",
      child: Material(
        color: Colors.transparent,
        child: Scaffold(

        ),
      ),
    );
  }
}
