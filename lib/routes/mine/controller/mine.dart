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

  Widget layout(BuildContext context) {
    return new Scaffold(
//      appBar: buildAppBar(context),
      body: Container(
        color: BackgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                ImageView(src: 'imgs/mine/bg2.png', width: ScreenWidth, height: 465 * ScaleWidth),
              ],
            ),
            Positioned(
                top: 239 * ScaleWidth,
                child: Container(
                  width: 680 * ScaleWidth,
                  height: 280 * ScaleWidth,
                  decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth))),
                  child: Column(
                    children: <Widget>[
                      MainTitleLabel('赵小刚', margin: EdgeInsets.only(top: 90 * ScaleWidth)),
                      MainTitleLabel('13111112222', margin: EdgeInsets.only(top: 28 * ScaleWidth), fontWeight: FontWeight.w400),
                      LineView(margin: EdgeInsets.only(top: 32 * ScaleWidth)),
                      Expanded(
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
                )),
            Positioned(
                top: 174 * ScaleWidth,
                child: ImageView(
                  src: 'imgs/home/banner.png',
                  width: 136 * ScaleWidth,
                  height: 136 * ScaleWidth,
                  //边框设置
                  decoration: new BoxDecoration(
                    //背景
                    color: BackgroundColor,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(78 * ScaleWidth)),
                    //设置四周边框
                    border: new Border.all(width: 5, color: Colors.white),
                  ),
                ))
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
