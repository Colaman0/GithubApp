import 'package:flutter/material.dart';
import 'package:github/entity/UserInfo.dart';
import 'package:github/util/AppManager.dart';
import 'package:github/util/NaigatorUtils.dart';
import 'package:github/util/UserManager.dart';
import 'package:github/view/widget/TextView.dart';

class SplashRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppManager.getInstance().init(context);
    checkLoginStatus(context);
    return MaterialApp(
      home: Center(
        child: TextView(
          "GitHub",
          textSize: 48,
          textColor: Colors.white,
        ),
      ),
    );
  }

  /// 检查登录状态
  void checkLoginStatus(BuildContext context) async {
    LoginInfo info = await UserManager.getInstance().getLocalUserInfo();
    if (info == null) {
      NavigatorUtils.getInstance().toLogin(context);
    } else {
      NavigatorUtils.getInstance().toMain(context);
    }
  }
}
