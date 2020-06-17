import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';

class SafeMeetSignListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SafeMeetSignListState();
  }
}

class SafeMeetSignListState extends State<SafeMeetSignListPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double theHeight = 340 * ScaleWidth + MediaQueryData.fromWindow(window).padding.top;
    return Container(
      color: BackgroundColor,
      child: Stack(
        children: <Widget>[
          new ListView.builder(
            padding: EdgeInsets.only(bottom: 40),
            physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: theHeight,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          ImageView(
                            src: 'imgs/home/xianxia/peixunjilu.png',
                            width: ScreenWidth,
                            height: theHeight,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 110 * ScaleWidth + MediaQueryData.fromWindow(window).padding.top),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: MainTitleLabel(
                                    '总人数',
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: MainTitleLabel(
                                    '签到人数',
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: MainTitleLabel(
                                    '缺勤人数 ',
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 170 * ScaleWidth + MediaQueryData.fromWindow(window).padding.top),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Label(
                                    '151',
                                    fontSize: 48 * ScaleWidth,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Label(
                                    '121',
                                    fontSize: 48 * ScaleWidth,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Label(
                                    '33',
                                    fontSize: 48 * ScaleWidth,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.white,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    WorkTitle(title: '已签到人员列表', margin: EdgeInsets.only(top: 18 * ScaleWidth)),
                  ],
                );
              }
              return signCell();
            },
            itemCount: 11,
          ),
          navBar(window, '签到记录'),
        ],
      ),
    );
  }

  Widget signCell() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 142 * ScaleWidth,
            padding: EdgeInsets.only(left: 90 * ScaleWidth, right: 47 * ScaleWidth),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTitleLabel(
                    '余秋雨',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                MainTitleLabel('打卡时间: 03/08 13:01 ')
              ],
            ),
          ),
          LineView()
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
