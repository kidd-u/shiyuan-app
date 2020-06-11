import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class XianXiaDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new XianXiaDetailState();
  }
}

class XianXiaDetailState extends State<XianXiaDetailPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '线下培训详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育'),
          WorkSelect(title: '培训对象：', value: '全体员工'),
          WorkSelect(title: '培训地点：', value: 'A306'),
          WorkSelect(title: '培训老师:', value: '高帅'),
          WorkSelect(title: '计划开始日期:', value: '2020-03-08'),
          WorkSelect(title: '培训时长:', value: '2小时'),
          WorkSelect(title: '签到方式:', value: '现场扫码'),
          WorkEmpty(
              leftActions: [MainTitleLabel('计划状态', fontWeight: FontWeight.w400)],
              rightActions: [MainTitleLabel('已完成', fontWeight: FontWeight.w400, textColor: SuccessColor)]),
          WorkEmpty(
              leftActions: [MainTitleLabel('我的参与情况:', fontWeight: FontWeight.w400)],
              rightActions: [MainTitleLabel('未打卡', fontWeight: FontWeight.w400, textColor: ErrorColor)]),
          WorkEmpty(leftActions: [
            MainTitleLabel('已签到记录（', fontWeight: FontWeight.w400),
            MainTitleLabel(
              '121',
              fontWeight: FontWeight.w400,
              textColor: MainDarkBlueColor,
            ),
            MainTitleLabel('）', fontWeight: FontWeight.w400),
          ], rightActions: [
            MainTitleLabel(
              '查看浏览详情',
              fontWeight: FontWeight.w400,
              textColor: MainDarkBlueColor,
              onClick: (){
                PageUtil.push('signList');
              },
            )
          ]),
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
