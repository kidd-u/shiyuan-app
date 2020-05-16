import 'package:flutter/material.dart';
import '../../home/controller/home.dart';
import '../../library/controller/library.dart';
import '../../todo/controller/todo.dart';
import '../../message/controller/message.dart';
import '../../mine/controller/mine.dart';

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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('数据中心')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('待办')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('消息')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
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
