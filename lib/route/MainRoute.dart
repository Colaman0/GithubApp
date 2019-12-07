import 'package:flutter/material.dart';
import 'package:github/route/main/MainPage.dart';
import 'package:github/view/bind/BindViewPager.dart';
import 'package:github/view/main/MainContentsWidget.dart';
import 'package:github/view/widget/BaseWidget.dart';
import 'package:github/view/widget/TextView.dart';
import 'package:rxdart/rxdart.dart';

class MainRoute extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  final PageController _controller = new PageController();
  final PublishSubject<int> _pageStream = new PublishSubject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamPageView(
        PageView(
          physics: ScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (page)=>_pageStream.add(page),
          children: <Widget>[
            MainContentsWidget(),
            Layout().size(width: 200, height: 200).backgroundColor(Colors.cyan),
            Layout().size(width: 200, height: 200).backgroundColor(Colors.black26),
          ],
        ),
        stream: _pageStream,
      )),
      bottomNavigationBar: StreamBuilder(
        stream: _pageStream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> data) {
          return Container(
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('搜索'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  title: Text('我'),
                ),
              ],
              currentIndex: data.data,
              selectedItemColor: Colors.blue,
              onTap: (page) => _pageStream.add(page),
            ),
          );
        },
      ),
    );
  }
}
