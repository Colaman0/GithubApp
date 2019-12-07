import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/util/util.dart';

///
/// * Author    : kyle
/// * Time      : 2019/9/10
/// * Function  : Widget基类，封装padding margin等属性
///

abstract class BaseWidget extends StatelessWidget {
  static const int MATCH = -1;
  static const int WRAP = -2;
  EdgeInsets _defalut = CustomMP().getParams();
  CustomMP _padding, _margin;
  Color _color, _storkeColor;
  double _width, _storkeWidth;
  double _height;
  BoxDecoration _boxDecoration;
  int _bothRadius, _leftTop, _leftBottom, _rightTop, _rightBottom;
  bool _circleShpae = false;
  Function _onTap, onDoubleTap;

  BaseWidget([Key key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: _margin?.getParams() ?? _defalut,
        child: Ink(
          decoration: getBoxDecoration(),
          child: InkWell(
            child: getChild() == null ? _getBodyWithoutChild(width: _width, height: _height) : _getBody(width: _width, height: _height),
            onTap: _onTap,
            onDoubleTap: onDoubleTap,
          ),
        ),
      ),
    );
  }

  Widget _getBody({double width, double height}) {
    Widget _body;
    if (width == null && height == null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        alignment: Alignment.center,
        //卡片大小
        child: getChild(),
      );
    } else if (width == null && height != null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        height: DP.get(_height.toInt()),
        alignment: Alignment.center,
        child: getChild(),
      );
    } else if (width != null && height == null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        width: DP.get(_width.toInt()),
        alignment: Alignment.center,
        child: getChild(),
      );
    } else {
      _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        width: DP.get(_width.toInt()),
        height: DP.get(_height.toInt()),
        alignment: Alignment.center,
        child: getChild(),
      );
    }
    return _body;
  }

  Widget _getBodyWithoutChild({double width, double height}) {
    Widget _body;
    if (width == null && height == null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        //卡片大小
      );
    } else if (width == null && height != null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        height: DP.get(_height.toInt()),
      );
    } else if (width != null && height == null) {
      _body = _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        width: DP.get(_width.toInt()),
      );
    } else {
      _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        width: DP.get(_width.toInt()),
        height: DP.get(_height.toInt()),
        alignment: Alignment.center,
      );
    }
    return _body;
  }

  BaseWidget padding({int both, int left, int right, int top, int bottom}) {
    _padding = CustomMP(both: both, left: left, right: right, top: top, bottom: bottom);
    return this;
  }

  BaseWidget margin({int both, int left, int right, int top, int bottom}) {
    _margin = CustomMP(both: both, left: left, right: right, top: top, bottom: bottom);
    return this;
  }

  BaseWidget backgroundColorStr(String color) {
    _color = HexColor(color);
    return this;
  }

  BaseWidget backgroundColor(Color color) {
    _color = color;
    return this;
  }

  BaseWidget size({int width, int height}) {
    if (width != null) {
      _width = width.toDouble();
    }
    if (height != null) {
      _height = height.toDouble();
    }
    return this;
  }

  BaseWidget corner({int both, int leftTop, int leftBottom, int rightTop, int rightBottom}) {
    _bothRadius = both;
    _leftTop = leftTop;
    _leftBottom = leftBottom;
    _rightTop = rightTop;
    _rightBottom = rightBottom;
    return this;
  }

  BaseWidget circle() {
    _circleShpae = true;
    return this;
  }

  BaseWidget storke({String color, int width}) {
    _storkeColor = HexColor(color);
    _storkeWidth = DP.get(width);
    return this;
  }

  BoxDecoration getBoxDecoration() {
    if (_boxDecoration == null) {
      _boxDecoration = BoxDecoration(
          color: _color??Colors.white,
          borderRadius: getRadius(),
          shape: _circleShpae ? BoxShape.circle : BoxShape.rectangle,
          border: (_storkeWidth == 0 || _storkeColor == null) ? null : Border.all(color: _storkeColor, width: _storkeWidth));
    }
    return _boxDecoration;
  }

  BorderRadius getRadius() {
    if (_circleShpae) {
      return null;
    }
    var bothRadius = DP.get(_bothRadius);
    return BorderRadius.only(
      topLeft: Radius.circular(_leftTop == null ? bothRadius : DP.get(_leftTop)),
      topRight: Radius.circular(_rightTop == null ? bothRadius : DP.get(_rightTop)),
      bottomLeft: Radius.circular(_leftBottom == null ? bothRadius : DP.get(_leftBottom)),
      bottomRight: Radius.circular(_rightBottom == null ? bothRadius : DP.get(_rightBottom)),
    );
  }

  BaseWidget click(Function callback) {
    _onTap = callback;
    return this;
  }

  BaseWidget doubleClick(Function callback) {
    onDoubleTap = callback;
    return this;
  }

  Widget getChild();
}

class Layout extends BaseWidget {
  Widget _child;

  Layout({Key key, Widget child}) : super(key) {
    _child = child;
  }

  @override
  Widget getChild() {
    return _child;
  }
}
