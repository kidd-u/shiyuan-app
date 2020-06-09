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
  //定义Tab标签
  var tabTexts = ["待执行", "已完成", "超期未执行"];

  //定义ab标签对应的Page
  var pages = [
    JiHuaPage(
      title: '1',
    ),
    JiHuaPage(
      title: '2',
    ),
    JiHuaPage(
      title: '3',
    ),
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
