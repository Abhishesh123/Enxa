import 'package:enxa/values/customColor.dart';
import 'package:flutter/material.dart';


class SingleImage extends StatelessWidget {
  String name="";
  SingleImage(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.dark_back,
      body: Center(
        child: Hero(
            tag: name,
            child: Material(child: Image.asset("assets/${name}.jpeg"))),
      ),
    );
  }
}
