import 'package:flutter/material.dart';
class Navigation{
  static void navigateTo(context,widget)=>Navigator.push(context,MaterialPageRoute(builder:(context)=>widget));
  static void navigateToAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>widget),(route)=>false);
}