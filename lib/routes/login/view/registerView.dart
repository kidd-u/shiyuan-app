import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key key,
    this.onSuccess,
  }) : super(key: key);
  final Function onSuccess;

  @override
  State<StatefulWidget> createState() {
    return new RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {
  String _yaoqingCode, _account, _passWord, _passWord2, _name, _idCard, _phone;

  void initState() {
    super.initState();
  }

  register() async {
    if (_yaoqingCode == null || _yaoqingCode == '') {
      DialogUtil.dialogAlert('请填写邀请码');
      return;
    }
    if (_account == null || _account == '') {
      DialogUtil.dialogAlert('请填写账号');
      return;
    }
    if (_passWord == null || _passWord == '') {
      DialogUtil.dialogAlert('请填写密码');
      return;
    }
    if (_passWord2 == null || _passWord2 == '') {
      DialogUtil.dialogAlert('请再次确认密码');
      return;
    }
    if (_name == null || _name == '') {
      DialogUtil.dialogAlert('请填写姓名');
      return;
    }
    if (_idCard == null || _idCard == '') {
      DialogUtil.dialogAlert('请填写身份证号');
      return;
    }
    if (_passWord != _passWord2) {
      DialogUtil.dialogAlert('两次输入密码不一致');
      return;
    }
    DialogUtil.showLoading();
    var res = await HttpUtil.post(
      '/account/register',
      params: {
        "inviteCode": _yaoqingCode,
        "userName": _account,
        "password": _passWord,
        "name": _name,
        "idCard": _idCard,
        "phone": _phone ?? '',
      },
    );
    DialogUtil.toastSuccess('注册成功');
    widget.onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 70 * ScaleWidth),
//      height: ScreenHeight,
      child: Column(
        children: <Widget>[
          yaoqingCode(
              title: '邀请码:',
              src: 'imgs/login/yaoqingma.png',
              onChange: (text) {
                _yaoqingCode = text;
              }),
          yaoqingCode(
              title: '账号:',
              src: 'imgs/login/zhanghao.png',
              onChange: (text) {
                _account = text;
              }),
          yaoqingCode(
              title: '密码:',
              src: 'imgs/login/mima.png',
              onChange: (text) {
                _passWord = text;
              }),
          yaoqingCode(
              title: '确认密码:',
              src: 'imgs/login/code.png',
              onChange: (text) {
                _passWord2 = text;
              }),
          yaoqingCode(
              title: '姓名:',
              src: 'imgs/login/xingming.png',
              onChange: (text) {
                _name = text;
              }),
          yaoqingCode(
              title: '身份证号:',
              src: 'imgs/login/shenfenzhenghao.png',
              onChange: (text) {
                _idCard = text;
              }),
          phoneInput(onChange: (text) {
            _phone = text;
          }),
          doneBtn(),
        ],
      ),
    );
  }

  Widget yaoqingCode({String title, String src, Function onChange}) {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 25 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25 * ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Label('*', textColor: WarningColor),
                ImageView(
                  src: src,
                  margin: EdgeInsets.only(left: 15 * ScaleWidth),
                  width: 32 * ScaleWidth,
                ),
              ],
            ),
          ),
          Expanded(
            child: InputView(
              padding: EdgeInsets.only(left: 15 * ScaleWidth, right: 15 * ScaleWidth),
              placeholder: title,
              onChanged: (text) {
                onChange(text);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget phoneInput({Function onChange}) {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 25 * ScaleWidth),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25 * ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ImageView(
                  src: 'imgs/login/denglu.png',
                  margin: EdgeInsets.only(left: 15 * ScaleWidth),
                  width: 32 * ScaleWidth,
                ),
              ],
            ),
          ),
          Expanded(
            child: InputView(
              padding: EdgeInsets.only(left: 15 * ScaleWidth, right: 15 * ScaleWidth),
              maxLength: 11,
              showCounterText: false,
              placeholder: '手机号',
              keyboardType: TextInputType.number,
              onChanged: (text) {
                onChange(text);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget doneBtn() {
    return Button(
      child: MainTitleLabel(
        '注 册',
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
      onPressed: () {
        register();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
