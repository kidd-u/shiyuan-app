import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';

class TodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<TodoPage> {
  //定义Tab标签
  var tabTexts = ["全部", "待支付", "已完成"];

  //定义ab标签对应的Page
  var pages = [Center(child: Text("内容（全部）")), Center(child: Text("内容（待支付）")), Center(child: Text("内容（已完成）"))];

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: TabBarPageView(
          tabTexts: tabTexts,
          pages: pages,
          onTabChanged: (index) {
            print("onTabChanged-->index:$index");
          }),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 1,
      title: const Text(
        '待办',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.white,
    );
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
