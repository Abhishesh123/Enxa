import 'package:enxa/Start/logindecider.dart';
import 'package:flutter/material.dart';

import 'ui/pages/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Enxa",
      home: LoginDecider(),
    )
  );
}
