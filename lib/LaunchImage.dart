import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:async';

class LaunchImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LaunchImageState();
  }
}

class LaunchImageState extends State<LaunchImagePage> {
  Timer _timer;

  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  _startTimer() {
    int _seconds = 3;
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        String page = UserInfo().token() == null ? 'loginPage' : 'mainTabPage';
        PageUtil.pushAndReplace(page);
      }
      _seconds--;
    });
  }

  _cancelTimer() {
    _timer.cancel();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      body: ImageView(
        src: 'imgs/nav/LaunchImage.png',
        width: ScreenWidth,
        height: ScreenHeight,
      ),
    );
  }
}
