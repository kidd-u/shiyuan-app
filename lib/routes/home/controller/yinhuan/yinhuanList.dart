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
  var tabTexts = ["全部数据", "待整改", "待验收", "已完成", "已超期", "验收未通过"];

  //定义ab标签对应的Page
  var pages = [
    YinHuanPage(
      title: '1',
    ),
    YinHuanPage(
      title: '2',
    ),
    YinHuanPage(
      title: '3',
    ),
    YinHuanPage(
      title: '4',
    ),
    YinHuanPage(
      title: '5',
    ),
    YinHuanPage(
      title: '6',
    ),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, '隐患整改'),
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
