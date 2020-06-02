import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'states/default.dart';
import 'routes/login/controller/login.dart';
import 'routes/login/controller/findPassWord.dart';
import 'routes/login/controller/newPassWord.dart';
import 'routes/main/controller/HomeMain.dart';
import 'routes/home/controller/home.dart';
import 'routes/library/controller/library.dart';
import 'routes/todo/controller/todo.dart';
import 'routes/message/controller/message.dart';
import 'routes/mine/controller/mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        //收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: new MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(platform: TargetPlatform.iOS, brightness: Brightness.light, backgroundColor: Colors.white),
        navigatorKey: DefaultUtil.navKey,
        home: new HomePage(),
        routes: <String, WidgetBuilder>{
          'loginPage': (BuildContext context) => new LoginPage(),
          'mainTabPage': (BuildContext context) => new HomeMainPage(),
          'homePage': (BuildContext context) => new HomePage(),
          'libraryPage': (BuildContext context) => new LibraryPage(),
          'todoPage': (BuildContext context) => new TodoPage(),
          'messagePage': (BuildContext context) => new MessagePage(),
          'minePage': (BuildContext context) => new MinePage(),
          'findPassWord': (BuildContext context) => new FindPassWordPage(),
          'newPassWord': (BuildContext context) => new NewPassWordPage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  initState() {
    super.initState();
    UserInfo().getUserInfo(); //初始化项目，获取本地缓存的用户数据
  }

  Widget build(BuildContext context) {
    print('=============');
    print(context);
    print('=============');
    ScreenUtil.init(context, width: 750, height: 1334);
    DefaultUtil.mainContext = context;
    return UserInfo().token() == null ? LoginPage() : HomeMainPage();
  }
}
