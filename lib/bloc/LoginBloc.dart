import 'package:github/base/bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase {
  static final int LOING_PSW = 1;
  static final int LOING_TOKEN = 2;

  PublishSubject<int> loginTypeStream = BehaviorSubject<int>().share();
  PublishSubject<bool> autoLoginStream = BehaviorSubject<bool>().share();
  PublishSubject<bool> loginInfoAvail = BehaviorSubject<bool>().share();

  String _userName = "";
  String _userPsw = "";
  String _userToken = "";
  bool _preLoginInfoAvail = false;
  bool _autoLogin = false;

  LoginBloc() {

  }

  void checkLoginInfo() {
    var pass = _userName.isNotEmpty && _userPsw.isNotEmpty;
    if (pass != _preLoginInfoAvail) {
      _preLoginInfoAvail = pass;
      loginInfoAvail.add(_preLoginInfoAvail);
    }
  }

  /// 切换登录类型
  void switchLoginType(int loginType) {
    loginTypeStream.add(loginType);
  }

  void updateUserName(String str) {
    _userName = str;
    checkLoginInfo();
  }

  void updateUserPsw(String str) {
    _userPsw = str;
    checkLoginInfo();
  }

  void updateUserToken(String str) {
    _userToken = str;
  }

  void updateAutoLogin(bool autoLogin) {
    _autoLogin = !_autoLogin;
    autoLoginStream.add(autoLogin);
  }

  bool autoLogin() => _autoLogin;

  @override
  bool autoRelease() {
    return false;
  }
  @override
  void dispose() {
    loginTypeStream.close();
    _userName = "";
    _userPsw = "";
    _userToken = "";
  }
}
