import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './jihuajianchaPage.dart';

class JiHuaJianCha extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new JiHuaJianChaState();
  }
}

class JiHuaJianChaState extends State<JiHuaJianCha> {
  bool _isLeft = true;
  String _type='TEMP_CHECK';

  //定义Tab标签
  var tabTexts = ["待执行", "已完成", "超期未执行"];

  //定义ab标签对应的Page
  var pages = [
    JiHuaPage(type: 'TEMP_CHECK'),
    JiHuaPage(type: 'TEMP_CHECK'),
    JiHuaPage(type: 'TEMP_CHECK'),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, '计划检查'),
        body: Column(
          children: <Widget>[
            LineView(),
            Expanded(
              child: TabBarPageView(
                  tabTexts: tabTexts,
                  pages: pages,
                  onTabChanged: (index) {
                    print("onTabChanged-->index:$index");
                  }),
            )
          ],
        ));
  }

  Widget buildAppBar(BuildContext context, String title) {
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
              color: _isLeft ? Colors.white : Colors.transparent,
              textColor: _isLeft ? Colors.black : Colors.white,
              fontSize: 13,
              onPressed: () {
                setState(() {
                  _isLeft = true;
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              '计划检查',
              color: _isLeft ? Colors.transparent : Colors.white,
              textColor: _isLeft ? Colors.white : Colors.black,
              fontSize: 13,
              onPressed: () {
                setState(() {
                  _isLeft = false;
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
