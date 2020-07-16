import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './yinhuanPage.dart';

class YinHuanList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new YinHuanListState();
  }
}

class YinHuanListState extends State<YinHuanList> {
  //定义Tab标签
  var tabTexts = ["全部数据", "待整改", "待验收", "已办结", "已超期", "验收未通过"];
  var tabTexts1 = ["", "待整改", "待验收", "已办结", "已超期", "验收未通过"];

  //定义ab标签对应的Page
  var pages;

  void initState() {
    super.initState();
    pages = tabTexts1.map((e) => YinHuanPage(type: 'DANGER_ELIMI', status: e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, '隐患治理'),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarPageView(
                  tabTexts: tabTexts,
                  pages: pages,
                  isScrollable: true,
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
