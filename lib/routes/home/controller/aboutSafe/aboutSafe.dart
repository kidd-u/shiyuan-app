import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkEmpty.dart';
import 'package:shiyuan/common/WorkUI/WorkTitle.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class AboutSafePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AboutSafeState();
  }
}

class AboutSafeState extends State<AboutSafePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '确定',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '相关方安全工作', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 20 * ScaleWidth, left: 26 * ScaleWidth, right: 26 * ScaleWidth),
            //边框设置
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
            ),
            child: Column(
              children: <Widget>[
                WorkEmpty(
                  color: Colors.transparent,
                  showTopLine: false,
                  showBottomLine: false,
                  leftActions: [MainTitleLabel('高帅')],
                  rightActions: [MainTitleLabel('相关方公司1')],
                ),
                WorkEmpty(
                  color: Colors.transparent,
                  showBottomLine: false,
                  leftActions: [MainTitleLabel('本月需填写报表2份', textColor: Color(0xFFB3B3B3))],
                  rightActions: [MainTitleLabel('2020-03-20', textColor: Color(0xFFB3B3B3))],
                ),
              ],
            ),
          ),
          WorkSelect(title: '安全教育', color: Colors.transparent, must: true, placeholder: ''),
          WorkImageTitle(leftActions: [MainTitleLabel('本月安全教育记录:')]),
          LineView(),
          WorkImageWithMessage(paddingTop: 20 * ScaleWidth),
          WorkSelect(title: '安全巡查', color: Colors.transparent, must: true, placeholder: ''),
          WorkImageTitle(leftActions: [MainTitleLabel('本月安全巡查记录:')]),
          LineView(),
          WorkImageWithMessage(paddingTop: 20 * ScaleWidth),
          WorkEmpty(
            showBottomLine: false,
            margin: EdgeInsets.only(top: 20*ScaleWidth),
            leftActions: [MainTitleLabel('安全工作日志:')],
            rightActions: [MainTextLabel('添加',textColor: MainDarkBlueColor,)],
          ),
          WorkInputArea(),
          WorkImageTitle(leftActions: []),
          WorkImageWithMessage(),
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
