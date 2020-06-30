import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import './jihuajianchaTab.dart';

class JiHuaJianCha extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new JiHuaJianChaState();
  }
}

class JiHuaJianChaState extends State<JiHuaJianCha> with SingleTickerProviderStateMixin {
  int _selectIndex = 0;
  TabController _controller;
  List _pageView = <Widget>[
    new JiHuaJianChaTab(type: 'TEMP_CHECK'),
    new JiHuaJianChaTab(type: 'REGULAR_CHECK_RECORD'),
  ];

  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      if (_selectIndex == _controller.index) return;
      setState(() {
        _selectIndex = _controller.index;
      });
    });
  }

  void _handleTap(index) {
    setState(() {
      if (_selectIndex == index) return;
      print('点击了$index');
      _selectIndex = index;
      _controller.animateTo(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: <Widget>[
            LineView(),
            Expanded(
//              height: ScreenHeight - DefaultUtil.navHeight,
              child: DefaultTabController(
                length: 2,
                child: TabBarView(
                  controller: _controller,
                  children: _pageView,
                ),
              ),
            )
          ],
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: segmented(),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 49, 191, 1), Color.fromRGBO(18, 113, 224, 1)],
          ),
        ),
      ),
    );
  }

  Widget segmented() {
    return Container(
      width: 210,
      height: 27,
      //边框设置
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: new Border.all(width: 1, color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextButton(
              '临时检查',
              color: _selectIndex == 0 ? Colors.white : Colors.transparent,
              textColor: _selectIndex == 0 ? Colors.black : Colors.white,
              fontSize: 13,
              onPressed: () {
                setState(() {
                  _handleTap(0);
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              '计划检查',
              color: _selectIndex == 0 ? Colors.transparent : Colors.white,
              textColor: _selectIndex == 0 ? Colors.white : Colors.black,
              fontSize: 13,
              onPressed: () {
                setState(() {
                  _handleTap(1);
                });
              },
            ),
          ),
        ],
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
