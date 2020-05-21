import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

export '../common/UIKit/dialog.dart';
export './users.dart';
export '../common/UIKit/ColorTheme.dart';

final double ScaleWidth = ScreenUtil().scaleWidth;
final double ScreenWidth = ScreenUtil.screenWidth;
final double ScreenHeight = ScreenUtil.screenHeight;

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

  static final navKey = new GlobalKey<NavigatorState>();
  static BuildContext mainContext;
}
