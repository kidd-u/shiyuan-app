import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import 'todoPage.dart';

class TodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<TodoPage> {
  //定义Tab标签
  var tabTexts = ["近七日待办", "全部待办"];

  //定义ab标签对应的Page
  var pages = [TodoView(url: '/message/todo/recent',), TodoView(url: '/message/todo',)];

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
      brightness: Brightness.light,
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
