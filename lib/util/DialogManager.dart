import 'package:flutter/cupertino.dart';

class DialogManager {
  static DialogManager _instance;

  DialogManager._();

  static DialogManager getInstance() {
    if (_instance == null) {
      _instance = DialogManager._();
    }
    return _instance;
  }

  void dismissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
