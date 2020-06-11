import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class YinHuanDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new YinHuanDetailState();
  }
}

class YinHuanDetailState extends State<YinHuanDetailPage> {
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
      appBar: buildAppBar(context, '待复检', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '编号:',value: '20200308'),
          WorkSelect(title: '地点或项目：',value: 'A306'),
          WorkSelect(title: '计划：',value: '2020年3月安全综合检查'),
          WorkSelect(title: '检查人:',value: '高帅'),
          WorkSelect(title: '日期:',value: '2020-03-08'),
          WorkSelect(title: '检查部门:',value: '后勤保障部'),
          WorkTitle(title: '安全隐患:',margin: EdgeInsets.only(top: 20*ScaleWidth)),
          WorkInputArea(value: '设备缺乏保养',enabled: false),
          WorkTitle(title: '隐患照片:'),
          Container(color: Colors.white,height: 20*ScaleWidth),
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
