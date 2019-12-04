import 'package:flutter/material.dart';
import 'package:github/view/widget/TextView.dart';

/// 首页homepage
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextView("My"),
    );
  }
}
