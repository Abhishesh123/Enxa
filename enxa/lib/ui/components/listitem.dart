import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';

import 'reusable_components.dart';

class CListItem extends StatelessWidget {
  String title;
  String subtitle;
  String trailtext;
  Color trailcolor;
  VoidCallback trailonclick;
  CListItem({this.title,this.subtitle,this.trailtext,this.trailcolor,this.trailonclick});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        title:CText(title,16,color: customColor.black),
        subtitle: CText(subtitle, 12,color: customColor.grey),
        trailing: CRaisedButton(text: trailtext,color: trailcolor,onclick: trailonclick),
        leading: CircleAvatar(
        ),
      ),
    );
  }
}
