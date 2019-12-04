import 'package:flutter/material.dart';
import 'package:github/view/widget/TextView.dart';

/// 首页homepage
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextView("main"),
    );
  }
}
