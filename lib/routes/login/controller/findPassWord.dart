import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class FindPassWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FindPassWordState();
  }
}

class FindPassWordState extends State<FindPassWordPage> {
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
    return new Scaffold(
      appBar: buildAppBar(context, '忘记密码'),
      backgroundColor: Colors.white,
      body: new Container(
        width: ScreenWidth,
        child: new Column(
          children: <Widget>[
            phoneInput(),
            codeInput(),
            doneBtn(),
          ],
        ),
      )
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
  Widget doneBtn() {
    return Button(
      child: MainTitleLabel(
        '确 认',
        textColor: Colors.white,
      ),
      width: 540 * ScaleWidth,
      height: 80 * ScaleWidth,
      margin: EdgeInsets.only(top: 105 * ScaleWidth),
      decoration: new BoxDecoration(
        //背景
        color: MainBlueColor,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      onPressed: (){
        Navigator.pushNamed(context, "newPassWord");
      },
    );
  }

//*****
//*****
}
