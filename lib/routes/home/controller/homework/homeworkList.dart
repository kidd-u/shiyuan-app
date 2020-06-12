import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './homeworkPage.dart';

class HomeWorkList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWorkListState();
  }
}

class HomeWorkListState extends State<HomeWorkList> {
  //定义Tab标签
  var tabTexts = ["全部数据", "待审核", "监管中","作业结束","审核未通过"];

  //定义ab标签对应的Page
  var pages = [
    HomeWorkPage(
      title: '1',
    ),
    HomeWorkPage(
      title: '2',
    ),
    HomeWorkPage(
      title: '3',
    ),
    HomeWorkPage(
      title: '3',
    ),
    HomeWorkPage(
      title: '3',
    ),
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, '线下培训'),
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
