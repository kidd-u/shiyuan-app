import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './shangjiPage.dart';

class ShangJiList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShangJiListState();
  }
}

class ShangJiListState extends State<ShangJiList> {
  //定义Tab标签
  var tabTexts = ["全部数据", "待整改", "待验收", "已办结", "已超期"];
  var tabTexts1 = ["", "待整改", "待验收", "已办结", "已超期"];

  //定义ab标签对应的Page
  List<ShangJiPage> pages;
  List<ShangJiPageController> controllers;

  String _keyword = '';
  int _index = 0;

  void initState() {
    super.initState();
    controllers = tabTexts1.map((e) => ShangJiPageController()).toList();
    pages = [];
    for (int i = 0; i < tabTexts1.length; i++) {
      String status = tabTexts1[i];
      pages.add(ShangJiPage(type: 'LEADER_CHECK', status: status, controller: controllers[i]));
    }
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
      onPressed: () {
//        PageUtil.push('shangjiApply');
        PageUtil.push('YinhuanAdd', arguments: {'title': '', 'procId': '', 'submitForm': true, 'type': 'LEADER_CHECK','navTitle':'检查发起'});
      },
    );
    return Scaffold(
        appBar: buildAppBar(context, '上级检查', actions: [btn]),
        body: Column(
          children: <Widget>[
            Container(
              height: 88 * ScaleWidth,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 528 * ScaleWidth,
                    height: 50 * ScaleWidth,
                    margin: EdgeInsets.only(left: 50 * ScaleWidth),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
                      border: new Border.all(width: 1, color: Color(0xFFD6D6D6)),
                    ),
                    child: Row(
                      children: <Widget>[
                        ImageView(
                          src: 'imgs/icon/search.png',
                          width: 30 * ScaleWidth,
                          height: 30 * ScaleWidth,
                          margin: EdgeInsets.only(left: 17 * ScaleWidth),
                        ),
                        InputView(
//                          height: 30 * ScaleWidth,
                          width: 450 * ScaleWidth,
                          margin: EdgeInsets.only(left: 14 * ScaleWidth),
                          placeholder: '请输入关键词搜索',
                          contentPadding: EdgeInsets.only(bottom: 10),
                          onChanged: (text) {
                            _keyword = text;
                          },
                        )
                      ],
                    ),
                  ),
                  TextBtn(
                    '搜索',
                    width: 86 * ScaleWidth,
                    height: 50 * ScaleWidth,
                    textColor: Colors.white,
                    fontSize: 24 * ScaleWidth,
                    margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    //边框设置
                    decoration: new BoxDecoration(
                      color: MainDarkBlueColor,
                      borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                    ),
                    onPressed: () {
                      controllers[_index].search(_keyword);
                    },
                  )
                ],
              ),
            ),
            LineView(),
            Expanded(
              child: TabBarPageView(
                  isScrollable: true,
                  tabTexts: tabTexts,
                  pages: pages,
                  onTabChanged: (index) {
                    print("onTabChanged-->index:$index");
                    _index = index;
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
