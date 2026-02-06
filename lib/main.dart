import 'package:cpu_z_copy/screen/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: BaseScreen()));
}


class Global {

  static Color mainColor = Colors.deepPurpleAccent;
  static Color mainColorDark = Colors.deepPurple;
  static Color grey = Colors.grey.shade700;
  static Color lightGrey = Colors.grey.shade200;
  static Color linkBlue = Colors.indigo;

  static NumberFormat floatDot2 = NumberFormat('#.##');

}