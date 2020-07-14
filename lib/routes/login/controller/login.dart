import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiyuan/common/UIKit/UIKit.dart';
import '../../../states/default.dart';
import '../view/login.dart';
import '../view/registerView.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<LoginPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectIndex = 0;
  List _pageView = <Widget>[new LoginView(), new RegisterView()];

//  PageController _pageController = PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      if (_selectIndex == _controller.index) return;
      setState(() {
        _selectIndex = _controller.index;
      });
    });
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
      if (_selectIndex == index) return;
      print('点击了$index');
      _selectIndex = index;
      _controller.animateTo(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
//      _pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  void _pageChange(index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: new ListView(
          physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
          children: <Widget>[
            headerImage(), //顶部图片
            centerView(), //中间切换
            Container(
              width: ScreenWidth,
              height: ScreenHeight - 430 * ScaleWidth - 85 *ScaleWidth,
              child: DefaultTabController(
                  length: 2,
                  child: TabBarView(
                    controller: _controller,
                    children: _pageView,
                  )),
//              child: PageView(
//                onPageChanged: (currentPage) {
//                  _pageChange(currentPage);
//                },
//                controller: _pageController,
//                children: _pageView,
//              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerImage() {
    return new ImageView(
      color: MainBlueColor,
      height: 430 * ScaleWidth,
      src: 'imgs/login/top.png',
    );
  }

  Widget centerView() {
    return new Container(
        color: Color.fromRGBO(226, 226, 226, 1),
        height: 85 * ScaleWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Button(
                  onPressed: () {
                    _handleTap(0);
                  },
                  child: Text(
                    '登录',
                    style: new TextStyle(color: _selectIndex == 0 ? MainBlueColor : DarkColor, fontSize: 28 * ScaleWidth),
                  ),
                )),
                new Expanded(
                    child: new Button(
                        onPressed: () {
                          _handleTap(1);
                        },
                        child: Text(
                          '注册',
                          style: new TextStyle(color: _selectIndex == 1 ? MainBlueColor : DarkColor, fontSize: 28 * ScaleWidth),
                        ))),
              ],
            ),
            Positioned(
              left: _selectIndex == 0 ? (750 / 4 - 22 / 2) * ScaleWidth : (750 / 4 * 3 - 22 / 2) * ScaleWidth,
              bottom: 0,
              child: ImageView(
                src: 'imgs/login/sanjiao.png',
                width: 22 * ScaleWidth,
              ),
            )
          ],
        ));
  }
}
