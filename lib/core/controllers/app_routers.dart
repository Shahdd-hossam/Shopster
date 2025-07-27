import 'package:flutter/material.dart';

BuildContext? appContext;

class AppRouter {
  static Future push(Widget child) => Navigator.push(
    appContext!, 
    MaterialPageRoute(builder: (context) => child));
}