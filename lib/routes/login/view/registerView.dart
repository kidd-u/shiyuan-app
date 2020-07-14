import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new RegisterViewState();
  }
}

class RegisterViewState extends State<RegisterView> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 70*ScaleWidth),
      child: Column(
        children: <Widget>[
          yaoqingCode(title: '邀请码:',onChange: (){}),
          yaoqingCode(title: '账号:',onChange: (){}),
          yaoqingCode(title: '密码:',onChange: (){}),
          yaoqingCode(title: '确认密码:',onChange: (){}),
          yaoqingCode(title: '姓名:',onChange: (){}),
          yaoqingCode(title: '身份证号:',onChange: (){}),
          phoneInput(onChange: (){}),
          doneBtn(),
        ],
      ),
    );
  }

  Widget yaoqingCode({String title,Function onChange}) {
    return new Container(
      width: 540 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 25 * ScaleWidth),
//      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          Container(
            width: 135*ScaleWidth,
            margin: EdgeInsets.only(right: 25*ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Label('*', textColor: WarningColor),
                MainTextLabel(title),
              ],
            ),
          ),
          Expanded(
            child: InputView(
              height: 60*ScaleWidth,
              padding: EdgeInsets.only(left: 15*ScaleWidth,right: 15*ScaleWidth),
              placeholder: '',
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5*ScaleWidth)),
                  border: new Border.all(width: 1, color: LineColor),
              ),
              onChanged: (text){
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
      width: 540 * ScaleWidth,
      height: 85 * ScaleWidth,
      margin: EdgeInsets.only(top: 25 * ScaleWidth),
//      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: LineColor))),
      child: Row(
        children: <Widget>[
          Container(
            width: 135*ScaleWidth,
            margin: EdgeInsets.only(right: 25*ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MainTextLabel('手机号'),
              ],
            ),
          ),
          Expanded(
            child: InputView(
              height: 60*ScaleWidth,
              padding: EdgeInsets.only(left: 15*ScaleWidth,right: 15*ScaleWidth),
              maxLength: 11,
              showCounterText: false,
              placeholder: '',
              keyboardType: TextInputType.number,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5*ScaleWidth)),
                border: new Border.all(width: 1, color: LineColor),
              ),
              onChanged: (text){
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
