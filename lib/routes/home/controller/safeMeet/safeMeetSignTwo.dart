import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';
import '../../view/SignBoard.dart';

class SafeMeetSignTwoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SafeMeetSignTwoState();
  }
}

GlobalKey<SignBoardState> signBoardKey = GlobalKey(debugLabel: 'signBoard');

class SafeMeetSignTwoState extends State<SafeMeetSignTwoPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context, '签到'),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          WorkSelect(title: '会议标题:', value: '安全信息化建设中期会议', showBottomLine: false),
          WorkSelect(title: '教育对象：', value: '全体员工', showBottomLine: false),
          WorkSelect(title: '会议地点：', value: 'A306', showBottomLine: false),
          WorkSelect(title: '组织部门:', value: '后勤管理处', showBottomLine: false),
          WorkSelect(title: '会议开始日期:', value: '2020-03-08', showBottomLine: false),
          WorkSelect(title: '会议预计时长:', value: '2小时', showBottomLine: false),
          WorkSelect(title: '电子签名:', value: '', showBottomLine: false),
          Container(
            height: 226 * ScaleWidth,
            margin: EdgeInsets.only(top: 30 * ScaleWidth),
            child: Center(
              child: Stack(
                children: <Widget>[
                  ImageView(
                    src: 'imgs/home/xianxia/sign.png',
                    width: 562 * ScaleWidth,
                    height: 226 * ScaleWidth,
                    fit: BoxFit.fill,
                  ),
                  SignBoard(key: signBoardKey),
                ],
              ),
            ),
          ),
          signBtn(),
        ],
      ),
    );
  }

  Widget signBtn() {
    return Container(
      margin: EdgeInsets.only(top: 30 * ScaleWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WorkButtonCancel(
            title: '清除',
            onClick: () {
              signBoardKey.currentState.clear();
            },
          ),
          WorkButtonDone(
            title: '完成',
            margin: EdgeInsets.only(left: 56 * ScaleWidth),
            onClick: () async {
//              signBoardKey.currentState.save();
//            DialogUtil.showLoading();
              await DialogUtil.dialogSignSuccess();
            },
          ),
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
