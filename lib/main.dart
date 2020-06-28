import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:shiyuan/routes/home/controller/jihua/jihuajianchaPage.dart';
import 'states/default.dart';
import './LaunchImage.dart';
import 'routes/login/controller/login.dart';
import 'routes/login/controller/findPassWord.dart';
import 'routes/login/controller/newPassWord.dart';
import 'routes/main/controller/HomeMain.dart';
import 'routes/home/controller/home.dart';
import 'routes/library/controller/library.dart';
import 'routes/todo/controller/todo.dart';
import 'routes/message/controller/message.dart';
import 'routes/mine/controller/mine.dart';
import 'routes/home/controller/yinhuanfaqi.dart';
import 'routes/home/controller/xianshang/xianshangList.dart';
import 'routes/home/controller/xianshang/xianshangpeixun.dart';
import 'routes/home/controller/xianshang/testError.dart';
import 'routes/home/controller/xianshang/zaixiankaoshi.dart';
import 'routes/home/controller/xianshang/wendangjiaoyu.dart';
import 'routes/home/controller/xianshang/imagejiaoyu.dart';
import 'routes/home/controller/xianshang/videojiaoyu.dart';
import 'routes/home/controller/xianshang/xianshangshenhe.dart';
import 'routes/home/controller/jihua/jihuajiancha.dart';
import 'routes/home/controller/jihua/jianchaDetail.dart';
import 'routes/home/controller/jihua/jianchaForm.dart';
import 'routes/home/controller/jihua/YinhuanAdd.dart';
import 'routes/home/controller/xianxia/signOne.dart';
import 'routes/home/controller/xianxia/signTwo.dart';
import 'routes/home/controller/xianxia/xianxiaList.dart';
import 'routes/home/controller/qrcode.dart';
import 'routes/home/controller/xianxia/xianxiaDetail.dart';
import 'routes/home/controller/xianxia/signList.dart';
import 'routes/home/controller/xianxia/signNot.dart';
import 'routes/home/controller/yinhuan/yinhuanList.dart';
import 'routes/home/controller/yinhuan/yinhuanDetail.dart';
import 'routes/home/controller/homework/homework.dart';
import 'routes/home/controller/homework/homeworkList.dart';
import 'routes/home/controller/homework/homeworkApply.dart';
import 'routes/home/controller/homework/homeworkCheck.dart';
import 'routes/home/controller/testOnLine/testList.dart';
import 'routes/home/controller/testFile/testFileList.dart';
import 'routes/home/controller/testFile/testFileDetail.dart';
import 'routes/home/controller/specialPeople/specialPeopleList.dart';
import 'routes/home/controller/specialPeople/specialPeopleDetail.dart';
import 'routes/home/controller/falv/falvList.dart';
import 'routes/home/controller/aboutSafe/aboutSafe.dart';
import 'routes/home/controller/safeMeet/safeMeetList.dart';
import 'routes/home/controller/safeMeet/safeMeetSignOne.dart';
import 'routes/home/controller/safeMeet/safeMeetSignTwo.dart';
import 'routes/home/controller/safeMeet/safeMeetDetail.dart';
import 'routes/home/controller/safeMeet/safeMeetSignList.dart';
import 'routes/home/controller/shangji/shangjiList.dart';
import 'routes/home/controller/shangji/shangjiApply.dart';
import 'package:shiyuan/common/WorkUI/WorkChooseStore.dart';
import 'routes/home/controller/notice.dart';

void main() {
  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(new MyApp());
}

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
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(platform: TargetPlatform.iOS, brightness: Brightness.light, backgroundColor: Colors.white),
        navigatorKey: DefaultUtil.navKey,
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [Locale('zh', 'CH')],
//        localeResolutionCallback: S.delegate.resolution(),
        home: new LaunchImagePage(),
        routes: <String, WidgetBuilder>{
          'LaunchImage': (BuildContext context) => new LaunchImagePage(),
          'loginPage': (BuildContext context) => new LoginPage(),
          'mainTabPage': (BuildContext context) => new HomeMainPage(),
          'homePage': (BuildContext context) => new HomePage(),
          'WorkChooseStore': (BuildContext context) {
            Map arguments = ModalRoute.of(context).settings.arguments;
            return new WorkChooseStorePage(arguments: arguments);
          },
          'libraryPage': (BuildContext context) => new LibraryPage(),
          'todoPage': (BuildContext context) => new TodoPage(),
          'messagePage': (BuildContext context) => new MessagePage(),
          'minePage': (BuildContext context) => new MinePage(),
          'findPassWord': (BuildContext context) => new FindPassWordPage(),
          'newPassWord': (BuildContext context) => new NewPassWordPage(),
          'yinhuanfaqi': (BuildContext context) => new YinhuanFaqiPage(),
          'xianshangList': (BuildContext context) => new XianShangList(),
          'xianshangpeixun': (BuildContext context) => new XianXiaPeiXunPage(),
          'testError': (BuildContext context) => new TestErrorPage(),
          'zaixiankaoshi': (BuildContext context) => new ZaiXianKaoShiPage(),
          'wendangjiaoyu': (BuildContext context) => new WenDangJiaoYuPage(),
          'imagejiaoyu': (BuildContext context) => new ImageJiaoYuPage(),
          'videojiaoyu': (BuildContext context) => new VideoJiaoYuPage(),
          'xianshangshenhe': (BuildContext context) => new XianShangShenHePage(),
          'jihuajiancha': (BuildContext context) => new JiHuaJianCha(),
          'jianchaDetail': (BuildContext context) {
            Map arguments = ModalRoute.of(context).settings.arguments;
            return new JianChaDetailPage(
              procId: arguments['procId'],
              taskId: arguments['taskId'],
              showHistory: arguments['showHistory'],
            );
          },
          'jianchaForm': (BuildContext context) {
            Map arguments = ModalRoute.of(context).settings.arguments;
            return new JianChaFormPage(
              title: arguments['title'],
              procId: arguments['procId'],
              taskId: arguments['taskId'],
              showForm: arguments['showForm'],
            );
          },
          'YinhuanAdd': (BuildContext context) {
            Map arguments = ModalRoute.of(context).settings.arguments;
            return new YinhuanAddPage(arguments: arguments);
          },
          'signOne': (BuildContext context) => new SignOnePage(),
          'signTwo': (BuildContext context) => new SignTwoPage(),
          'xianxiaList': (BuildContext context) => new XianXiaList(),
          'qrcode': (BuildContext context) => new QrCodePage(),
          'xianxiaDetail': (BuildContext context) => new XianXiaDetailPage(),
          'signList': (BuildContext context) => new SignListPage(),
          'signNot': (BuildContext context) => new SignNotPage(),
          'yinhuanList': (BuildContext context) => new YinHuanList(),
          'yinhuanDetail': (BuildContext context) => new YinHuanDetailPage(),
          'homework': (BuildContext context) => new HomeWorkPage(),
          'homeworkList': (BuildContext context) => new HomeWorkList(),
          'homeworkApply': (BuildContext context) => new HomeWorkApplyPage(),
          'homeworkCheck': (BuildContext context) => new HomeWorkCheckPage(),
          'testList': (BuildContext context) => new TestList(),
          'testFileList': (BuildContext context) => new TestFileList(),
          'testFileDetail': (BuildContext context) => new TestFileDetailPage(),
          'specialPeopleList': (BuildContext context) => new SpecialPeopleList(),
          'specialPeopleDetail': (BuildContext context) => new SpecialPeopleDetailPage(),
          'falvList': (BuildContext context) => new FaLvList(),
          'aboutSafe': (BuildContext context) => new AboutSafePage(),
          'safeMeetList': (BuildContext context) => new SafeMeetList(),
          'safeMeetSignOne': (BuildContext context) => new SafeMeetSignOnePage(),
          'safeMeetSignTwo': (BuildContext context) => new SafeMeetSignTwoPage(),
          'safeMeetDetail': (BuildContext context) => new SafeMeetDetailPage(),
          'safeMeetSignList': (BuildContext context) => new SafeMeetSignListPage(),
          'shangjiList': (BuildContext context) => new ShangJiList(),
          'shangjiApply': (BuildContext context) => new ShangJiApplyPage(),
          'notice': (BuildContext context) => new NoticePage(),
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
//    UserInfo.getUserInfo(); //初始化项目，获取本地缓存的用户数据
  }

  Widget build(BuildContext context) {
    print('=============');
    print(context);
    print('=============');
    ScreenUtil.init(width: 750, height: 1334);
//    DefaultUtil.mainContext = context;
    return LaunchImagePage();
  }
}
