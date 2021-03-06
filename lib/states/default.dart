import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

export 'package:flutter/material.dart';
export 'dialog.dart';
export '../common/UIKit/RefreshView.dart';
export './userInfo.dart';
export '../common/UIKit/ColorTheme.dart';
export '../common/UIKit/UIKit.dart';
export './http.dart';
export './page.dart';
export './filter.dart';
export './event_util.dart';
export './objExtension.dart';
export './SafeMap.dart';


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

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static final navHeight=MediaQueryData.fromWindow(window).padding.top + kToolbarHeight;
//  static BuildContext mainContext;
}
