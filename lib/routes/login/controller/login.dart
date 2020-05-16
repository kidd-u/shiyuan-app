import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../states/dialog.dart';
import '../../../states/default.dart';
import '../../../states/users.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<LoginPage> {
  int _selectIndex = 0;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
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

  action(context) async {
    bool res = await DialogUtil.alertConfim(content: '99999');
    print('点击了确定===');
    print(res);
    DialogUtil.toastSuccess();
  }

  void _handleTap(index) {
    setState(() {
      print('点击了$index');
      _selectIndex = index;
    });
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          new Column(children: <Widget>[
            headerImage(),//顶部图片
            centerView(),//中间切换
            phoneInput(),//手机号
          ])
        ],
      ),
    );
  }

  Widget headerImage() {
    return new Container(
      color: DefaultUtil.mianColor,
      height: 430 * DefaultUtil.scal,
    );
//    return new Image.network(
//      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
//    );
  }
  Widget centerView(){
    return new Container(
      color: Color.fromRGBO(226, 226, 226, 1),
      height: 85 * DefaultUtil.scal,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new FlatButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  _handleTap(0);
                },
                child: Text(
                  '登录',
                  style: new TextStyle(color: _selectIndex == 0 ? DefaultUtil.mianColor : DefaultUtil.darkColor),
                ),
              )),
          new Expanded(
              child: new FlatButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _handleTap(1);
                  },
                  child: Text(
                    '注册',
                    style: new TextStyle(color: _selectIndex == 1 ? DefaultUtil.mianColor : DefaultUtil.darkColor),
                  )))
        ],
      ),
    );
  }
  Widget phoneInput(){
    return new Container(
      width: 604 * DefaultUtil.scal,
      height: 85 * DefaultUtil.scal,
      margin: EdgeInsets.only(top: 140 * DefaultUtil.scal),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1,color: DefaultUtil.lineGrayColor))
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.people),
            margin: EdgeInsets.only(left: 15 * DefaultUtil.scal),
          ),

        ],
      ),
    );
  }
}
