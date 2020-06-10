import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';

class SignOnePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignOneState();
  }
}

class SignOneState extends State<SignOnePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new ListView(
              padding: EdgeInsets.zero,
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/xianxia/signtop.png',
                  width: ScreenWidth,
                  height: 500 * ScaleWidth,
                ),
                WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育', showBottomLine: false),
                WorkSelect(title: '教育对象：', value: '全体员工', showBottomLine: false),
                WorkSelect(title: '培训地点：', value: 'A306', showBottomLine: false),
                WorkSelect(title: '培训老师:', value: '高帅', showBottomLine: false),
                WorkSelect(title: '计划开始日期:', value: '2020-03-08', showBottomLine: false),
                WorkSelect(title: '培训时长:', value: '2小时', showBottomLine: false),
                Container(
                  margin: EdgeInsets.only(top: 120 * ScaleWidth),
                  child: Center(
                    child: TextButton(
                      '点击签到',
                      width: 462 * ScaleWidth,
                      height: 98 * ScaleWidth,
                      fontSize: 28*ScaleWidth,
                      textColor: Colors.white,
                      decoration: new BoxDecoration(
                          color: MainDarkBlueColor,
                          borderRadius: BorderRadius.all(Radius.circular(49*ScaleWidth)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          navBar()
        ],
      ),
    );
  }

  Widget navBar() {
    return new Container(
      color: Colors.transparent,
      height: MediaQueryData.fromWindow(window).padding.top + kToolbarHeight,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ImageView(
            src: 'imgs/nav/back.png',
            margin: EdgeInsets.only(left: 15, bottom: 20),
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 15, bottom: 16),
            ),
            onTap: () => PageUtil.pop(),
          ),
          Container(
            height: 20,
            margin: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Text(
                '签到',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
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
