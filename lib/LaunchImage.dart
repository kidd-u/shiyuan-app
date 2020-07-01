import 'package:flutter/material.dart';
import 'package:shiyuan/routes/login/model/UserInfo.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LaunchImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LaunchImageState();
  }
}

class LaunchImageState extends State<LaunchImagePage> {
//  Timer _timer;

  void initState() {
    super.initState();
//    _startTimer();
    checkLogin();
  }

  checkLogin() async {
    await UserInfo().getUserInfo();
    String page = UserInfo().token() == null ? 'loginPage' : 'mainTabPage';
    PageUtil.pushAndReplace(page);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334);
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
//    _timer.cancel();
  }

//  _startTimer() {
//    int _seconds = 3;
//    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
//      if (_seconds == 0) {
//        _cancelTimer();
//        String page = UserInfo().token() == null ? 'loginPage' : 'mainTabPage';
//        PageUtil.pushAndReplace(page);
//      }
//      _seconds--;
//    });
//  }
//
//  _cancelTimer() {
//    _timer.cancel();
//  }

  Widget layout(BuildContext context) {
    return new ImageView(
      color: Colors.transparent,
      src: 'imgs/nav/LaunchImage.png',
      width: ScreenWidth,
      height: ScreenHeight,
    );
  }
}
