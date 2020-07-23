import 'package:flutter/material.dart';
import 'package:shiyuan/routes/login/model/UserInfo.dart';
import 'package:shiyuan/states/default.dart';
import '../../home/controller/home.dart';
import '../../library/controller/library.dart';
import '../../todo/controller/todo.dart';
import '../../message/controller/message.dart';
import '../../mine/controller/mine.dart';
import 'dart:async';

class HomeMainPage extends StatefulWidget {
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<HomeMainPage> {
  StreamSubscription<PageEvent> _bus;
  Timer _timer;
  int _num = 0;
  int _selectedIndex = 0;
  var pageList = [new HomePage(), new LibraryPage(), new TodoPage(), new MessagePage(), new MinePage()];
  var icons = [
    ['imgs/tabbar/shouye_se.png', 'imgs/tabbar/shouye.png'],
    ['imgs/tabbar/shujuzhongxin_se.png', 'imgs/tabbar/shujuzhongxin.png'],
    ['imgs/tabbar/daiban_se.png', 'imgs/tabbar/daiban.png'],
    ['imgs/tabbar/xiaoxi_se.png', 'imgs/tabbar/xiaoxi.png'],
    ['imgs/tabbar/wode_se.png', 'imgs/tabbar/wode.png'],
  ];
  var appBarTitles = ['首页', '数据中心', '待办', '消息', '我的'];

  @override
  void initState() {
    super.initState();
    getUser();
    startTime();
    getMessageNum();
    _bus=EventBusUtil.getInstance().on<PageEvent>().listen((data) {
      if (data.name != 'Message') {
        return;
      }
      print(data.name);
      getMessageNum();
    });
  }
  startTime(){
    _timer = new Timer.periodic(new Duration(seconds: 15), (timer) {
      getMessageNum();
    });
  }

  getUser() async {
    try {
      var res = await HttpUtil.get('/account/mine');
      UserInfo.userInfo = UserInfoModel.fromJson(res);
    } catch (err) {
      PageUtil.pushAndRemoveAll('loginPage');
    }
  }
  getMessageNum()async{
    var res=await HttpUtil.get('/message/unread/amount');
    setState(() {
      _num=res;
    });
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
          new BottomNavigationBarItem(
              title: getTabTitle(3),
              icon: new Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    tabbarItem(3),
                    ..._num>0?[Positioned(  // draw a red marble
                      top: -6.0,
                      right: -10.0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: new Text(
                          '${_num}',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )]:[],
                  ]
              ),
          ),
          BottomNavigationBarItem(icon: tabbarItem(4), title: getTabTitle(4)),
        ],
        currentIndex: _selectedIndex,
        fixedColor: MainBlueColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget tabbarItem(index) {
    List icon_item = icons[index];
    return Image(
      image: AssetImage(_selectedIndex == index ? icon_item[0] : icon_item[1]),
      width: 22,
      height: 22,
      fit: BoxFit.cover,
    );
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: new TextStyle(fontSize: 14.0, color: MainBlueColor));
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
    _timer?.cancel();
    _timer = null;
    _bus.cancel();
    super.dispose();
  }
}
