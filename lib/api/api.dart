import 'dart:async';

import 'package:github/api/DioClient.dart';
import 'package:github/entity/ApiConstants.dart';
import 'package:dio/dio.dart';

///
/// * author : kyle
/// * time   : 2019/11/12
/// * desc   : api
///

class ApiManager {
  static ApiManager _api;

  ApiManager._();

  static ApiManager getInstance() {
    if (_api == null) {
      _api = ApiManager._();
    }
    return _api;
  }

}
