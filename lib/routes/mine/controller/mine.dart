import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<MinePage> {
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
  void loginOut()async{
    DialogUtil.dialogConfim('确定退出登录？',onConfirm: (){
      UserInfo().cleanUserInfo();
      PageUtil.pushAndRemoveAll('loginPage');
    });
  }
  Widget layout(BuildContext context) {
    return new Scaffold(
//      appBar: buildAppBar(context),
      body: Container(
        color: BackgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            headerImg(context),
            topCart(context),
            userHeader(context),
            Container(
              margin: EdgeInsets.only(top: 549 * ScaleWidth),
              child: Column(
                children: <Widget>[
                  line1(context),
                  line2(context),
                  line3(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget headerImg(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageView(src: 'imgs/mine/bg2.png', width: ScreenWidth, height: 465 * ScaleWidth),
      ],
    );
  }

  Widget topCart(BuildContext context) {
    return Positioned(
        top: 239 * ScaleWidth,
        child: Container(
          width: 680 * ScaleWidth,
//          height: 280 * ScaleWidth,
          decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth))),
          child: Column(
            children: <Widget>[
              MainTitleLabel('赵小刚', margin: EdgeInsets.only(top: 90 * ScaleWidth)),
              MainTitleLabel('13111112222', margin: EdgeInsets.only(top: 28 * ScaleWidth), fontWeight: FontWeight.w400),
              LineView(margin: EdgeInsets.only(top: 32 * ScaleWidth)),
              Container(
                  height: 76 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: MainTitleLabel('后勤管理部'),
                        ),
                      ),
                      Container(color: LineColor, height: 54 * ScaleWidth, width: 0.5),
                      Expanded(
                        child: Center(
                          child: MainTitleLabel('后勤管理部'),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget userHeader(BuildContext context) {
    return Positioned(
        top: 174 * ScaleWidth,
        child: ImageView(
          src: 'imgs/home/banner.png',
          width: 136 * ScaleWidth,
          height: 136 * ScaleWidth,
          borderRadius_Img: 78 * ScaleWidth,
          //边框设置
          decoration: new BoxDecoration(
            //背景
            color: BackgroundColor,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(78 * ScaleWidth)),
            //设置四周边框
            border: new Border.all(width: 5, color: Colors.white),
          ),
        ));
  }

  Widget line1(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 680 * ScaleWidth,
        height: 88 * ScaleWidth,
        margin: EdgeInsets.only(top: 30 * ScaleWidth),
        //边框设置
        decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Row(
          children: <Widget>[
            ImageView(
              src: 'imgs/mine/xiugaimima.png',
              width: 40 * ScaleWidth,
              height: 40 * ScaleWidth,
              margin: EdgeInsets.only(left: 25 * ScaleWidth),
            ),
            Expanded(
              child: MainTitleLabel(
                '修改密码',
                margin: EdgeInsets.only(left: 24 * ScaleWidth),
              ),
            ),
            ImageView(
              src: 'imgs/mine/right_icon.png',
              width: 12 * ScaleWidth,
              height: 23 * ScaleWidth,
              margin: EdgeInsets.only(right: 29 * ScaleWidth),
            ),
          ],
        ),
      ),
      onTap: (){
        DialogUtil.toastSuccess('111');
//        showToast("hello world");
      },
    );
  }

  Widget line2(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 680 * ScaleWidth,
        height: 88 * ScaleWidth,
        margin: EdgeInsets.only(top: 30 * ScaleWidth),
        //边框设置
        decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Row(
          children: <Widget>[
            ImageView(
              src: 'imgs/mine/tuichudenglu.png',
              width: 40 * ScaleWidth,
              height: 40 * ScaleWidth,
              margin: EdgeInsets.only(left: 25 * ScaleWidth),
            ),
            Expanded(
              child: MainTitleLabel(
                '退出登录',
                margin: EdgeInsets.only(left: 24 * ScaleWidth),
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        loginOut();
      },
    );
  }

  Widget line3(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 680 * ScaleWidth,
        height: 88 * ScaleWidth,
        margin: EdgeInsets.only(top: 30 * ScaleWidth),
        //边框设置
        decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Row(
          children: <Widget>[
            ImageView(
              src: 'imgs/mine/dangqianbanben.png',
              width: 40 * ScaleWidth,
              height: 40 * ScaleWidth,
              margin: EdgeInsets.only(left: 25 * ScaleWidth),
            ),
            Expanded(
              child: MainTitleLabel(
                '当前版本',
                margin: EdgeInsets.only(left: 24 * ScaleWidth),
              ),
            ),
            MainTitleLabel(
              '测试版 1.0.1 ',
              margin: EdgeInsets.only(right: 30 * ScaleWidth),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        title: const Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white);
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
