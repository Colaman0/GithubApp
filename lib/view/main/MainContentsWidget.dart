import 'package:flutter/material.dart';

class MainContentsWidget extends StatefulWidget {
  @override
  _MainContentsWidgetState createState() => _MainContentsWidgetState();
}

class _MainContentsWidgetState extends State<MainContentsWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return getWBItemWidget(context,index);
      }),
    );
  }

  refresh() async {
    return Future.value(true);
  }

  Widget getWBItemWidget(BuildContext context, int index) {}
  
}
