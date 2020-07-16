import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './jihuajianchaPage.dart';

class JiHuaJianChaTab extends StatefulWidget {
  JiHuaJianChaTab({
    Key key,
    @required this.type,
  }) : super(key: key);
  String type;

  @override
  State<StatefulWidget> createState() {
    return new JiHuaJianChaTabState();
  }
}

class JiHuaJianChaTabState extends State<JiHuaJianChaTab> {
  //定义Tab标签
  var tabTexts = ["全部数据", "待执行", "已办结", "超期未执行"];

  //定义ab标签对应的Page
  var pages;

  void initState() {
    pages = [
      JiHuaPage(type: widget.type, status: ""),
      JiHuaPage(type: widget.type, status: "待执行"),
      JiHuaPage(type: widget.type, status: "已办结"),
      JiHuaPage(type: widget.type, status: "超期未执行"),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: TabBarPageView(
                isScrollable: true,
                tabTexts: tabTexts,
                pages: pages,
                onTabChanged: (index) {
                  print("onTabChanged-->index:$index");
                }),
          )
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
