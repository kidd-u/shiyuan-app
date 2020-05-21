import 'package:flutter/material.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';
import '../../../states/default.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
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
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Expanded(
        child: Container(
      child: Column(
        children: <Widget>[
          phoneInput(),
          passwordInput()
        ],
      ),
    ));
  }
  Widget phoneInput() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 140 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineGrayColor))),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.people),
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
          ),
          Expanded(
              child: InputView(
                margin: EdgeInsets.only(left: 15 * ScaleWidth),
                placeholder: '登录账号',
              ),
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
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineGrayColor))),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.people),
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
          ),
          Expanded(
            child: InputView(
              margin: EdgeInsets.only(left: 15 * ScaleWidth),
              obscureText: true,
              placeholder: '登录密码',
            ),
//              child: Container(
//                margin: EdgeInsets.only(left: 15 * ScaleWidth),
////            color: Colors.red,
//                child: TextField(
//                  obscureText: true,
//                  decoration: InputDecoration(
//                      hintText: '登录密码',
//                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
//                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))),
//                ),
//              )
          ),
          Container(
            child: Icon(Icons.remove_red_eye),
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
          ),
        ],
      ),
    );
  }
}
