import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './xianshangPage.dart';

class XianShangList extends StatefulWidget {
  const XianShangList({
    Key key,
    this.type = 'ONLINE_CLASS',
    this.title = '线上培训',
  }) : super(key: key);
  final String type;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new XianShangListState();
  }
}

class XianShangListState extends State<XianShangList> {
  //定义Tab标签
  var tabTexts;

  //定义ab标签对应的Page
  List<XianShangController> controllers = [
    XianShangController(),
    XianShangController(),
    XianShangController(),
    XianShangController(),
    XianShangController(),
    XianShangController(),
  ];
  List<Widget> pages = [];
  String _keyword = '';
  int _index = 0;

  void initState() {
    super.initState();
    if (widget.type == 'ONLINE_CLASS') {
      tabTexts = ["所有数据", "待审核", "待执行", "未开始", "已办结", "已超期"];
      pages = [
        XianShangPage(type: widget.type, status: '', controller: controllers[0]),
        XianShangPage(type: widget.type, status: '待审核', controller: controllers[1]),
        XianShangPage(type: widget.type, status: '待执行', controller: controllers[2]),
        XianShangPage(type: widget.type, status: '未开始', controller: controllers[3]),
        XianShangPage(type: widget.type, status: '已办结', controller: controllers[4]),
        XianShangPage(type: widget.type, status: '已超期', controller: controllers[5]),
      ];
    } else {
      tabTexts = ["所有数据", "未开始", "待执行", "已超期", "已办结"];
      pages = [
        XianShangPage(type: widget.type, status: '', controller: controllers[0]),
        XianShangPage(type: widget.type, status: '未开始', controller: controllers[1]),
        XianShangPage(type: widget.type, status: '待执行', controller: controllers[2]),
        XianShangPage(type: widget.type, status: '已超期', controller: controllers[3]),
        XianShangPage(type: widget.type, status: '已办结', controller: controllers[4]),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, widget.title),
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
                  TextButton(
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
                  tabTexts: tabTexts,
                  pages: pages,
                  isScrollable: true,
                  onTabChanged: (index) {
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
