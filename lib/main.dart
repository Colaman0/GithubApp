import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:github/ViewRoute.dart';
import 'package:github/route/LoginRoute.dart';
import 'package:github/route/MainRoute.dart';
import 'package:github/route/SplashRoute.dart';

void main() {
  debugPaintSizeEnabled = !true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (BuildContext context) => SplashRoute(),
        "/login": (BuildContext context) => LoginRoute(),
        "/main": (BuildContext context) => ViewRoute(),
      },
    );
  }
}
