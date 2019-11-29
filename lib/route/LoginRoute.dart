import 'package:flutter/material.dart';
import 'package:github/base/bloc.dart';
import 'package:github/bloc/LoginBloc.dart';
import 'package:github/view/widget/BaseWidget.dart';
import 'package:github/view/widget/TextView.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = LoginBloc();
    return BlocProvider(
      bloc: bloc,
      child: Layout(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[loginTitle(context, bloc), loginContent(context, bloc)],
          ),
        ),
      ).backgroundColorStr("#363636"),
    );
  }

  Widget loginTitle(BuildContext context, LoginBloc bloc) {
    return StreamBuilder<int>(
      stream: bloc.loginTypeStream,
      initialData: LoginBloc.LOING_PSW,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextView(
              "账号密码",
              textColor: isPswLogin(snapshot.data) ? Colors.black26 : Colors.white,
            ).size(width: 200, height: 64).corner(leftTop: 5, rightTop: 5).backgroundColor(isPswLogin(snapshot.data) ? Colors.white : Colors.black26).click(() {
              bloc.switchLoginType(LoginBloc.LOING_PSW);
            }),
            TextView(
              "Token",
              textColor: isTokenLogin(snapshot.data) ? Colors.black26 : Colors.white,
            ).size(width: 200, height: 64).corner(leftTop: 5, rightTop: 5).backgroundColor(isTokenLogin(snapshot.data) ? Colors.white : Colors.black26).click(() {
              bloc.switchLoginType(LoginBloc.LOING_TOKEN);
            }),
          ],
        );
      },
    );
  }

  final Widget pswContent = LoginPswContentWidget();
  final Widget tokenContent = LoginTokenWidget();

  Widget loginContent(BuildContext context, LoginBloc bloc) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return Layout(
      child: StreamBuilder(
        stream: bloc.loginTypeStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            child: snapshot.data == LoginBloc.LOING_PSW ? pswContent : tokenContent,
          );
        },
        initialData: LoginBloc.LOING_PSW,
      ),
    ).size(width: 500, height: 500).backgroundColor(Colors.white).corner(leftBottom: 5, rightBottom: 5);
  }

  Widget getTokenContent(BuildContext context, LoginBloc bloc) {
    return Container();
  }

  bool isPswLogin(int type) => type == LoginBloc.LOING_PSW;

  bool isTokenLogin(int type) => type == LoginBloc.LOING_TOKEN;
}

class LoginTokenWidget extends StatefulWidget {
  @override
  _LoginTokenWidgetState createState() => _LoginTokenWidgetState();
}

class _LoginTokenWidgetState extends State<LoginTokenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LoginPswContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getContent(context);
  }

  Widget content;

  Widget getContent(BuildContext context) {
    if (content == null) {
      LoginBloc bloc = BlocProvider.of(context);

      content = Layout(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Layout(
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextView(
                  "账号",
                  textColor: Colors.black,
                  textSize: 20,
                ).margin(right: 12),
                Expanded(
                  flex: 1,
                  child: Layout(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Account',
                      ),
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.blue,
                      onChanged: (data) => bloc.updateUserName(data),
                    ),
                  ).padding(left: 16).size(height: 80).corner(both: 5),
                )
              ]),
            ).size(height: 100),
            Layout(
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextView(
                  "密码",
                  textColor: Colors.black,
                  textSize: 20,
                ).margin(right: 12),
                Expanded(
                  flex: 1,
                  child: Layout(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PassWord',
                      ),
                      onChanged: (data) => bloc.updateUserPsw(data),
                    ),
                  ).padding(left: 16).size(height: 80).corner(both: 5),
                )
              ]),
            ).size(height: 100),
            StreamBuilder(
              initialData: false,
              stream: bloc.loginInfoAvail,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return TextView(
                  "登录",
                  textColor: Colors.white,
                )
                    .size(height: 80)
                    .margin(top: 32)
                    .corner(both: 5)
                    .backgroundColor(
                      snapshot.data ? Colors.blue : Colors.grey,
                    )
                    .click(snapshot.data ? () {} : null);
              },
            ),
            Spacer(),
            StreamBuilder(
              initialData: false,
              stream: bloc.autoLoginStream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      onChanged: (bool newValue) {
                        bloc.updateAutoLogin(newValue);
                      },
                      value: snapshot.data,
                    ),
                    TextView(
                      "自动登录",
                      textColor: Colors.black,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ).padding(top: 32, left: 32, right: 32);
    }
    return content;
  }
}
