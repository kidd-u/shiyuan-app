import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import '../../home/controller/home.dart';
import '../../library/controller/library.dart';
import '../../todo/controller/todo.dart';
import '../../message/controller/message.dart';
import '../../mine/controller/mine.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeMainPage extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<HomeMainPage> {
  int _selectedIndex = 0;
  var pageList = [
    new HomePage(),
    new LibraryPage(),
    new TodoPage(),
    new MessagePage(),
    new MinePage()
  ];
  var icons = [
    ['imgs/tabbar/shouye_se.png','imgs/tabbar/shouye.png'],
    ['imgs/tabbar/shujuzhongxin_se.png','imgs/tabbar/shujuzhongxin.png'],
    ['imgs/tabbar/daiban_se.png','imgs/tabbar/daiban.png'],
    ['imgs/tabbar/xiaoxi_se.png','imgs/tabbar/xiaoxi.png'],
    ['imgs/tabbar/wode_se.png','imgs/tabbar/wode.png'],
  ];
  var appBarTitles = ['首页','数据中心','待办','消息','我的'];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // 底部导航
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: tabbarItem(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: tabbarItem(1), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: tabbarItem(2), title: getTabTitle(2)),
          BottomNavigationBarItem(icon: tabbarItem(3), title: getTabTitle(3)),
          BottomNavigationBarItem(icon: tabbarItem(4), title: getTabTitle(4)),
        ],
        currentIndex: _selectedIndex,
        fixedColor: MainBlueColor,
        onTap: _onItemTapped,
      ),
    );
  }
  Widget tabbarItem(index){
    List icon_item = icons[index];
    return Image(
      image: AssetImage(_selectedIndex == index ? icon_item[0]:icon_item[1]),
      width: 22,
      height: 22,
      fit: BoxFit.cover,
    );
  }
  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex],
        style: new TextStyle(fontSize: 14.0, color: MainBlueColor));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
