import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './homeworkPage.dart';

class HomeWorkList extends StatefulWidget {
  const HomeWorkList({
    Key key,
    this.arguments,
  }) : super(key: key);
  final Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkListState();
  }
}

class HomeWorkListState extends State<HomeWorkList> {
  //定义Tab标签
  var tabTexts = ["全部数据", "待审核", "监管中", "已办结", "未通过"];

  //定义ab标签对应的Page
  var pages;
  String _type, _title;

  void initState() {
    super.initState();
    _type = widget.arguments['type'];
    _title = widget.arguments['title'];
    pages = [
      HomeWorkPage(type: _type, title: _title, status: ''),
      HomeWorkPage(type: _type, title: _title, status: '待审核'),
      HomeWorkPage(type: _type, title: _title, status: '监管中'),
      HomeWorkPage(type: _type, title: _title, status: '已办结'),
      HomeWorkPage(type: _type, title: _title, status: '未通过'),
    ];
  }

  submit() {
    PageUtil.push('homeworkApply', arguments: widget.arguments);
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '发起',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () => submit(),
    );
    return Scaffold(
        appBar: buildAppBar(context, _title, actions: [btn]),
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
