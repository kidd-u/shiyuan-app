import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkInput.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class ShangJiApplyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ShangJiApplyState();
  }
}

class ShangJiApplyState extends State<ShangJiApplyPage> {
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
      appBar: buildAppBar(context, '上级检查发起', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkInput(title: '检查地点或项目：', placehoder: '请填写检查地点或项目'),
          WorkInput(title: '上级检查部门/单位：', placehoder: '填写上级部门/单位'),
          WorkSelect(title: '日期：', value: '2020-03-08', placeholder: '请选择日期'),
          WorkInput(title: '检查人:', placehoder: '填写检查人'),
          WorkTitle(title: '安全隐患', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkInputArea(placehoder: '填写隐患说明......',height: 240*ScaleWidth,showTopLine: false,showBottomLine: false),
          WorkImageWithMessage(),
          WorkTitle(title: '整改要求',margin: EdgeInsets.only(top: 20*ScaleWidth)),
          WorkInputArea(placehoder: '请输入整改要求......',showTopLine: false,height: 215*ScaleWidth),
          WorkChoose(title: '责任部门或单位:',placeholder: '选择责任部门或单位'),
          WorkChoose(title: '整改人:',placeholder: '选择整改人'),
          WorkChoose(title: '限期整改时间:',placeholder: '请选择日期'),
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
