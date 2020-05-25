import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class NewPassWordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewPassWordState();
  }
}

class NewPassWordState extends State<NewPassWordPage> {
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
    return new Scaffold(
      appBar: buildAppBar(context,'找回密码'),
      body: new Container(
        width: ScreenWidth,
        child: new Column(
          children: <Widget>[
            passInput(),
            passInput1(),
            doneBtn(),
          ],
        ),
      )
    );
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
              placeholder: '请输入新密码',
            ),
          )
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
    );
  }
}
