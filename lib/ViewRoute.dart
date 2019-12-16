import 'package:flutter/material.dart';
import 'package:github/view/widget/view/AnimationView.dart';
import 'package:github/view/widget/view/TextView.dart';
import 'package:github/view/widget/view/View.dart';

class ViewRoute extends StatefulWidget {
  @override
  _ViewRouteState createState() => _ViewRouteState();
}

class _ViewRouteState extends State<ViewRoute> {
  int margin = 10;

  @override
  Widget build(BuildContext context) {
    // wrap 100dp
    return Center(
        child: View(
      child: BlueBox(),
    )
            .size(
              width: View.MATCH,
              height: View.MATCH,
            )
           .circle()
            .margin(both: margin)
            .backgroundColor(Colors.red).click((){}));
  }
}

class BlueBox extends StatelessWidget {
  final int height = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height.toDouble(),
      height: height.toDouble(),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class WhiteBox extends StatefulWidget {
  int height;

  WhiteBox(this.height);

  @override
  _WhiteBoxState createState() => _WhiteBoxState(height);
}

class _WhiteBoxState extends State<WhiteBox> {
  int height;

  _WhiteBoxState(this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height.toDouble(),
      height: height.toDouble(),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
      ),
    );
  }
}
