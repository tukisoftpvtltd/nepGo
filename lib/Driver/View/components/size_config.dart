import 'package:flutter/material.dart';

class SizeConfig {
  late BuildContext _context;
  late double _height, _width;

  SizeConfig(context) {
    _context = context;
    final _queryData = MediaQuery.of(_context);
    _height = _queryData.size.height;
    _width = _queryData.size.width;
  }

  double nameSize() {
    double nameSize = _width < 400 ? 17 : 20;
    return nameSize;
  }

  double titleSize() {
    double titleSize = _width < 400 ? 22 : 26;
    return titleSize;
  }

  double textSize() {
    double textSize = _width < 400 ? 13 : 15;
    return textSize;
  }

  double iconSize() {
    double iconSize = _width < 400 ? 22 : 30;
    return iconSize;
  }

  double containerHeight() {
    double height = _height < 800 ? _height / 2.3 : _height / 3;
    return height;
  }

  double buttonHorizontalPadding() {
    double size = _width < 400 ? 40 : 60;
    return size;
  }

  double deviceHeight() {
    return _height;
  }
}
