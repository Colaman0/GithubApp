import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/util/util.dart';

class View extends StatelessWidget {
  static const int MATCH = -1;
  static const int WRAP = -2;
  EdgeInsets _defalut = CustomMP().getParams();
  CustomMP _padding, _margin;
  Color _color, _storkeColor;
  int _width = View.WRAP;
  int _height = View.WRAP;
  double _storkeWidth;
  BoxDecoration _boxDecoration;
  int _bothRadius, _leftTop, _leftBottom, _rightTop, _rightBottom;
  bool _circleShpae = false;
  Function _onTap, onDoubleTap;
  bool _touchAnimation = true;
  Widget child;

  View({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    child = child ?? Container();
    if (_touchAnimation == false) {
      return GestureDetector(
        child: Container(
          decoration: getBoxDecoration(),
          margin: _margin?.getParams() ?? _defalut,
          child: child,
        ),
        onTap: _onTap,
        onDoubleTap: onDoubleTap,
      );
    }
    return getInkWellBackgroud(getSizeWidget(child));
  }

  Widget getInkWellBackgroud(Widget child) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: _margin?.getParams() ?? _defalut,
        child: Ink(
          decoration: getBoxDecoration(),
          child: InkWell(
            child: child,
            onTap: _onTap,
            onDoubleTap: onDoubleTap,
          ),
        ),
      ),
    );
  }

  Widget getSizeWidget(Widget child) {
    Widget _body;
    if (_width == View.WRAP && _height == View.WRAP) {
      _body = Padding(
        child: child,
        padding: _padding?.getParams() ?? _defalut,
      );
    } else if (_width == View.MATCH && _height == View.MATCH) {
      _body = Container(
        padding: _padding?.getParams() ?? _defalut,
        child: child,
        constraints: BoxConstraints.expand(),
      );
    } else if (_width == View.WRAP && _height == View.MATCH) {
      _body = Padding(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[expandCheck(child)],
        ),
        padding: _padding?.getParams() ?? _defalut,
      );
    } else if (_width == View.MATCH && _height == View.WRAP) {
      _body = Padding(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[expandCheck(child)],
        ),
        padding: _padding?.getParams() ?? _defalut,
      );
    } else {
      _body = sizeWrapper();
    }
    return _body;
  }

  Widget sizeWrapper() {
    Widget sizeWrapper;
    if (isDpValue(_width) && isDpValue(_height)) {
      sizeWrapper = Container(
        width: DP.get(_width.toInt()),
        height: DP.get(_height.toInt()),
        alignment: Alignment.center,
        child: child,
        padding: _padding?.getParams() ?? _defalut,
      );
    } else {
      if (isDpValue(_width)) {
        sizeWrapper = SizedBox(
          width: DP.get(_width.toInt()),
          child: Padding(
              padding: _padding?.getParams() ?? _defalut,
              child: Column(
                mainAxisSize:
                    _height == View.WRAP ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[expandCheck(child)],
              )),
        );
      } else if (isDpValue(_height)) {
        sizeWrapper = SizedBox(
          height: DP.get(_height.toInt()),
          child: Padding(
            padding: _padding?.getParams() ?? _defalut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize:
                  _width == View.WRAP ? MainAxisSize.min : MainAxisSize.max,
              children: <Widget>[expandCheck(child)],
            ),
          ),
        );
      }
    }
    return sizeWrapper;
  }

  Widget buildChild() {
    Widget body;
    if (_touchAnimation) {
      if (_width == View.MATCH && _height == View.MATCH) {
        body = Container(
          padding: _padding?.getParams() ?? _defalut,
          margin: _margin?.getParams() ?? _defalut,
          alignment: Alignment.center,
          decoration: getBoxDecoration(),
          constraints: BoxConstraints.expand(),
          child: child,
        );
      } else if (_width == View.WRAP && _height == View.WRAP) {
        body = Container(
          padding: _padding?.getParams() ?? _defalut,
          margin: _margin?.getParams() ?? _defalut,
          alignment: Alignment.center,
          decoration: getBoxDecoration(),
          child: child,
        );
      } else if (_width == View.MATCH && _height == View.WRAP) {
        body = Container(
          padding: _padding?.getParams() ?? _defalut,
          margin: _margin?.getParams() ?? _defalut,
          width: double.infinity,
          alignment: Alignment.center,
          constraints: BoxConstraints.tightForFinite(),
          decoration: getBoxDecoration(),
          child: child,
        );
      } else if (_width == View.WRAP && _height == View.MATCH) {
        body = Container(
          padding: _padding?.getParams() ?? _defalut,
          margin: _margin?.getParams() ?? _defalut,
          height: double.infinity,
          alignment: Alignment.center,
          constraints: BoxConstraints.tightForFinite(),
          decoration: getBoxDecoration(),
          child: child,
        );
      }
    } else {}

    return body;
  }

  Widget expandCheck(Widget child) =>
      (child is Column || child is Row) ? Expanded(child: child) : child;

  bool isDpValue(int value) => value >= 0;

  View padding({int both, int left, int right, int top, int bottom}) {
    _padding = CustomMP(
        both: both, left: left, right: right, top: top, bottom: bottom);
    return this;
  }

  View margin({int both, int left, int right, int top, int bottom}) {
    _margin = CustomMP(
        both: both, left: left, right: right, top: top, bottom: bottom);
    return this;
  }

  View backgroundColorStr(String color) {
    _color = HexColor(color);
    return this;
  }

  View backgroundColor(Color color) {
    _color = color;
    return this;
  }

  View touchAnimation(bool anim) {
    _touchAnimation = anim;
    return this;
  }

  View size({int width = View.WRAP, int height = View.WRAP}) {
    _width = width;
    _height = height;
    return this;
  }

  View corner(
      {int both, int leftTop, int leftBottom, int rightTop, int rightBottom}) {
    _bothRadius = both;
    _leftTop = leftTop;
    _leftBottom = leftBottom;
    _rightTop = rightTop;
    _rightBottom = rightBottom;
    return this;
  }

  View circle() {
    _circleShpae = true;
    return this;
  }

  View storke({String color, int width}) {
    _storkeColor = HexColor(color);
    _storkeWidth = DP.get(width);
    return this;
  }

  BoxDecoration getBoxDecoration() {
    if (_boxDecoration == null) {
      _boxDecoration = BoxDecoration(
          color: _color ?? Colors.transparent,
          borderRadius: getRadius(),
          shape: _circleShpae ? BoxShape.circle : BoxShape.rectangle,
          border: (_storkeWidth == 0 || _storkeColor == null)
              ? null
              : Border.all(color: _storkeColor, width: _storkeWidth));
    }
    return _boxDecoration;
  }

  BorderRadius getRadius() {
    if (_circleShpae) {
      return null;
    }
    var bothRadius = DP.get(_bothRadius);
    return BorderRadius.only(
      topLeft:
          Radius.circular(_leftTop == null ? bothRadius : DP.get(_leftTop)),
      topRight:
          Radius.circular(_rightTop == null ? bothRadius : DP.get(_rightTop)),
      bottomLeft: Radius.circular(
          _leftBottom == null ? bothRadius : DP.get(_leftBottom)),
      bottomRight: Radius.circular(
          _rightBottom == null ? bothRadius : DP.get(_rightBottom)),
    );
  }

  View click(Function callback) {
    _onTap = callback;
    return this;
  }

  View doubleClick(Function callback) {
    onDoubleTap = callback;
    return this;
  }
}
