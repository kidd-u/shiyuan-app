import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultUtil {
  // 工厂模式
  factory DefaultUtil() => _getInstance();
  static DefaultUtil get instance => _getInstance();
  static DefaultUtil _instance;
  DefaultUtil._internal() {
    // 初始化
  }
  static DefaultUtil _getInstance() {
    if (_instance == null) {
      _instance = new DefaultUtil._internal();
    }
    return _instance;
  }

  static double scal = ScreenUtil().scaleWidth;
  static double screenWidth = ScreenUtil.screenWidth;
  static double screenHeight = ScreenUtil.screenHeight;
  static final navKey = new GlobalKey<NavigatorState>();
  static BuildContext mainContext;

  static Color mianColor = Color.fromRGBO(44, 109, 210, 1);
  static Color darkColor = Color.fromRGBO(188, 188, 188, 1);
  static Color lineGrayColor = Color.fromRGBO(236, 235, 238, 1);
}
