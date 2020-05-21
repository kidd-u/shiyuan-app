import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';
import '../../../states/default.dart';
import '../view/login.dart';
import '../view/register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<LoginPage> {
  int _selectIndex = 0;
  List _pageView = <Widget>[new LoginView(), new RegisterView()];
  PageController _pageController = PageController(initialPage: 0, keepPage: false);

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

  void _handleTap(index) {
    setState(() {
      print('点击了$index');
      _selectIndex = index;
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void _pageChange(index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          new Column(children: <Widget>[
            headerImage(), //顶部图片
            centerView(), //中间切换
            Container(
                width: 750 * ScaleWidth,
                height: ScreenHeight - 515 * ScaleWidth,
                child: PageView(
//              scrollDirection: Axis.vertical,
                    onPageChanged: (currentPage) {
                      _pageChange(currentPage);
                    },
                    controller: _pageController,
                    children: _pageView)),
            //密码
          ])
        ],
      ),
    );
  }

  Widget headerImage() {
    return new Container(
      color: MianColor,
      height: 430 * ScaleWidth,
    );
  }

  Widget centerView() {
    return new Container(
      color: Color.fromRGBO(226, 226, 226, 1),
      height: 85 * ScaleWidth,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Button(
            onPressed: () {
              _handleTap(0);
            },
            child: Text(
              '登录',
              style: new TextStyle(color: _selectIndex == 0 ? MianColor : DarkColor, fontSize: 28 * ScaleWidth),
            ),
          )),
          new Expanded(
              child: new Button(
                  onPressed: () {
                    _handleTap(1);
                  },
                  child: Text(
                    '注册',
                    style: new TextStyle(color: _selectIndex == 1 ? MianColor : DarkColor, fontSize: 28 * ScaleWidth),
                  )))
        ],
      ),
    );
  }
}
