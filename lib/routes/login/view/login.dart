import 'package:flutter/material.dart';
import '../../../states/default.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  bool _closeEye = true;

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

  void closeEye() {
    setState(() {
      _closeEye = !_closeEye;
    });
  }

  Widget layout(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          phoneInput(),
          passwordInput(),
          doneBtn(),
          password(),
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
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          ImageView(
            src: 'imgs/login/mima.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 32 * ScaleWidth,
          ),
          Expanded(
            child: InputView(
              margin: EdgeInsets.only(left: 15 * ScaleWidth),
              obscureText: _closeEye,
              placeholder: '登录密码',
            ),
          ),
          ImageView(
            src: _closeEye ? 'imgs/login/close.png' : 'imgs/login/open.png',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
            width: 42 * ScaleWidth,
            onClick: () {
              closeEye();
            },
          ),
        ],
      ),
    );
  }
  Widget doneBtn() {
    return Button(
      child: MainTitleLabel(
        '登 录',
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
      onPressed: (){
        print(DefaultUtil.mainContext);

        DefaultUtil.navKey.currentState.pushReplacementNamed("mainTabPage");
//      DialogUtil.toastSuccess('111');
      },
    );
  }

  Widget password() {
    return Label(
      '忘记密码',
      margin: EdgeInsets.only(top: 72 * ScaleWidth),
      textDecoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
      onClick: () {
        Navigator.pushNamed(context, "findPassWord");
      },
    );
  }

}
