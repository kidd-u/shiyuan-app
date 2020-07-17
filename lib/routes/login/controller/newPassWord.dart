import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class NewPassWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewPassWordState();
  }
}

class NewPassWordState extends State<NewPassWordPage> {
  String password, passwordAgan;

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

  submit() async {
    if (password == null || password == '') {
      DialogUtil.dialogAlert('请输入新密码');
      return;
    }
    if (passwordAgan == null || passwordAgan == '') {
      DialogUtil.dialogAlert('请确认新密码');
      return;
    }
    if (password.length < 6) {
      DialogUtil.dialogAlert('密码长度最低6位');
      return;
    }
    if (password != passwordAgan) {
      DialogUtil.dialogAlert('两次输入密码不一致');
      return;
    }
    DialogUtil.showLoading();
    var res = await HttpUtil.put('/account/password', params: {'password': password});
    await DialogUtil.toastSuccess('修改密码成功，请重新登录');
    UserInfo().cleanUserInfo();
    PageUtil.pushAndRemoveAll('loginPage');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context, '修改密码'),
        body: new Container(
          width: ScreenWidth,
          child: new Column(
            children: <Widget>[
              passInput(),
              passInput1(),
              doneBtn(),
            ],
          ),
        ));
  }

  Widget passInput() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 140 * ScaleWidth),
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
              placeholder: '请输入新密码',
              maxLength: 18,
              showCounterText: false,
              onChanged: (text) {
                password = text;
              },
            ),
          )
        ],
      ),
    );
  }

  Widget passInput1() {
    return new Container(
      width: 604 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 80 * ScaleWidth),
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
              placeholder: '请确认新密码',
              maxLength: 18,
              showCounterText: false,
              onChanged: (text) {
                passwordAgan = text;
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
        '修 改',
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
        submit();
      },
    );
  }
}
