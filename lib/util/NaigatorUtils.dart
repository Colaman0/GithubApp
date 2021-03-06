import 'dart:collection';

import 'package:github/entity/ApiConstants.dart';
import 'package:github/route/LoginRoute.dart';
import 'package:github/route/MainRoute.dart';
import 'package:github/route/SplashRoute.dart';
import 'package:github/util/UserManager.dart';
import 'package:github/view/widget/WebView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ViewRoute.dart';
import '../main.dart';

///
/// * author : kyle
/// * time   : 2019/11/15
/// * desc   : 页面路由工具类
///

class NavigatorUtils {
  static NavigatorUtils _instance;

  static Map<String, WidgetBuilder> routeMap = {
    "/": (BuildContext context) => SplashRoute(),
    "/login": (BuildContext context) => LoginRoute(),
    "/main": (BuildContext context) => ViewRoute(),
  };

  NavigatorUtils._();

  static NavigatorUtils getInstance() {
    if (_instance == null) {
      _instance = NavigatorUtils._();
    }
    return _instance;
  }

  static Map<String, dynamic> getPreArguments(BuildContext context) {
    return ModalRoute.of(context).settings.arguments;
  }

  /// 跳转到登录页面，并且清空其他路由
  void toLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  /// 跳转到主页面，并且清空其他路由
  void toMain(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
  }
}
