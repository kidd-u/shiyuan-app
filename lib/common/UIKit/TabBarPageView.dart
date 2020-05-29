import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

typedef OnTabChanged = Function(int index);

///@describe 自定义TabBarView
///
///@author mi
///
///@time 2019/10/29
// ignore: must_be_immutable
class TabBarPageView extends StatefulWidget {
  TabBarPageView({@required this.tabTexts, @required this.pages, this.onTabChanged,this.isScrollable = false});

  //Tab标签
  List<String> tabTexts;

  //Tab标签对应的Page
  List<Widget> pages;

  //Tab切换回调
  OnTabChanged onTabChanged;
  //tab是否可滑动
  bool isScrollable;

  @override
  State<StatefulWidget> createState() => TabBarViewState();
}

class TabBarViewState extends State<TabBarPageView> with SingleTickerProviderStateMixin {
  TabController _controller;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    if (widget.pages == null) {
      throw StateError('pages cannot be null.');
    }

    if (widget.tabTexts == null) {
      throw StateError('tabTexts cannot be null.');
    }

    if (widget.pages.length != widget.tabTexts.length) {
      throw StateError('pages and tabTexts are not equal in length.');
    }
    _controller = TabController(length: widget.tabTexts.length, vsync: this);

    _controller.addListener(() {
      if (widget.onTabChanged != null) {
        if (_currentIndex == _controller.index) return;

        widget.onTabChanged(_controller.index);
        _currentIndex = _controller.index;
      }
    });

    if (widget.onTabChanged != null) {
      widget.onTabChanged(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.pages.length,
      child: new Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          child: TabBar(
            controller: _controller,
            labelColor: MainBlueColor,
            labelStyle: TextStyle(fontSize: 30 * ScaleWidth, fontWeight: FontWeight.w400),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: 30 * ScaleWidth, fontWeight: FontWeight.w400),
            indicatorColor: MainBlueColor,
            //isScrollable false：平分宽度，true：tab可滚动
            isScrollable: widget.isScrollable,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: widget.tabTexts.map((String name) {
              return Tab(text: name);
            }).toList(),
          ),
          preferredSize: Size.fromHeight(80 * ScaleWidth),
        ),
        body: TabBarView(
          controller: _controller,
          children: widget.pages.map((widget) {
            return widget;
          }).toList(),
        ),
      ),
    );
  }
}
