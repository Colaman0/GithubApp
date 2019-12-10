import 'package:flutter/material.dart';
import 'package:github/view/widget/BaseWidget.dart';
import 'package:github/view/widget/TextView.dart';
import 'package:github/view/widget/View.dart';

class ViewRoute extends StatefulWidget {
  @override
  _ViewRouteState createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  @override
  Widget build(BuildContext context) {
    // wrap 100dp
    return Center(
        child: View(
      child: BlueBox(),
    ).size(width: View.MATCH, height: 100).margin(left: 20, top: 20).padding(both: 12).backgroundColor(Colors.red));
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
