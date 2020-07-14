import 'dart:async';
import 'package:flutter/material.dart';
import '../../../states/default.dart';

class RegisterView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {
  bool _closeEye = true;
  bool _xieyi = true;
  String _radio = 'a';
  int _seconds = 60;
  Timer _timer;
  String _phone, _code;
  String _vftext = '发送验证码';
  bool _clickable = false;

  void initState() {
    super.initState();
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
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void closeEye() {
    setState(() {
      _closeEye = !_closeEye;
    });
  }
  _startTimer() {
    _seconds = 60;
    _clickable = false;
    _vftext = '$_seconds(S)后重试';
    if(mounted) setState(() {});
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if(_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds --;
      _vftext = '$_seconds(S)后重试';
      if(mounted) setState(() {});
      if(_seconds == 0) {
        _vftext = '重新发送';
        _clickable = true;
      }
    });
  }

  _cancelTimer() {
    _timer.cancel();
  }

  Widget layout(BuildContext context) {
    return Container(
      color: Colors.white,
//      height: ScreenHeight,
      child: Column(
        children: <Widget>[
          phoneInput(),
          codeInput(),
          passwordInput(),
          xieyi(),
          doneBtn(),
        ],
      ),
    );
  }

  Widget phoneInput() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 140 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          ImageView(
            src: 'imgs/login/denglu.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 32 * ScaleWidth,
          ),
          Expanded(
              child: InputView(
                margin: EdgeInsets.only(left: 15 * ScaleWidth),
                placeholder: '登录账号',
              ))
        ],
      ),
    );
  }

  Widget codeInput() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 50 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          ImageView(
            src: 'imgs/login/code.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 32 * ScaleWidth,
          ),
          Expanded(
              child: InputView(
                margin: EdgeInsets.only(left: 15 * ScaleWidth),
                placeholder: '短信验证码',
              )),
          MainTextLabel(
            _vftext,
            enabled: _clickable,
            textColor: NormalColor,
            textAlign: TextAlign.right,
            onClick: () {
              _startTimer();
            },
          )
        ],
      ),
    );
  }

  Widget passwordInput() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 50 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          ImageView(
            src: 'imgs/login/denglu.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 32 * ScaleWidth,
          ),
          Expanded(
              child: InputView(
                obscureText: true,
                margin: EdgeInsets.only(left: 15 * ScaleWidth),
                placeholder: '登录密码',
              )),
          ImageView(
            src: _closeEye ? 'imgs/login/close.png' : 'imgs/login/open.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 42 * ScaleWidth,
            onClick: () {
              closeEye();
            },
          )
        ],
      ),
    );
  }

  Widget xieyi() {
    return Container(
      margin: EdgeInsets.only(top: 48 * ScaleWidth),
      padding: EdgeInsets.only(left: 15 * ScaleWidth),
      width: 604 * ScaleWidth,
      child: Row(
        children: <Widget>[
          ImageView(
            src: _xieyi ? 'imgs/login/select.png' : 'imgs/login/select_de.png',
            width: 30 * ScaleWidth,
            onClick: () {
              setState(() {
                _xieyi = !_xieyi;
              });
            },
          ),
          SubTextLabel(
            '已阅读并同意',
            margin: EdgeInsets.only(left: 25 * ScaleWidth),
          ),
          SubTextLabel(
            '《用户使用协议》',
            textColor: Color.fromRGBO(0, 136, 255, 1),
            onClick: () {
              print('用户使用协议');
            },
          )
        ],
      ),
    );
  }

  Widget doneBtn() {
    return Button(
      child: MainTitleLabel(
        '确 认',
        textColor: Colors.white,
      ),
//            color: MainBlueColor,
      width: 540 * ScaleWidth,
      height: 80 * ScaleWidth,
      margin: EdgeInsets.only(top: 105 * ScaleWidth),
      decoration: new BoxDecoration(
        //背景
        color: MainBlueColor,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
    );
  }
}
