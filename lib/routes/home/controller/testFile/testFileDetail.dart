import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkFile.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class TestFileDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestFileDetailState();
  }
}

class TestFileDetailState extends State<TestFileDetailPage> {
  List modelAry = [
    {'name': '赵小雨', 'num': 90},
    {'name': '王依依', 'num': 90},
    {'name': '张娟', 'num': 90},
    {'name': '黄薇', 'num': 90},
    {'name': '杨月', 'num': 90},
    {'name': '李思思', 'num': 90},
  ];
  bool isCan = true;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> headerViews = [
      WorkEmpty(
        leftActions: [
          MainTitleLabel('*', textColor: WarningColor),
          MainTitleLabel('考试标题:'),
        ],
        rightActions: [
          MainTitleLabel('2020年全员消防教育'),
          MainTitleLabel('(考试进行中)', textColor: SuccessColor),
        ],
      ),
      WorkSelect(title: '考试对象：', value: '保卫科'),
      WorkDrop(context, title: '科目选择：', actions: ['消防考试', '英语考试', '数学考试']),
      WorkSelect(title: '考试开始日期:', value: '2020/3/12'),
      WorkSelect(title: '考试截止日期:', value: '2020/3/15'),
      WorkFile(title: '考试资料选择:', name: '后勤保障处消防教育考试试卷（一）', type: 'file'),
      WorkEmpty(
        leftActions: [
          MainTitleLabel('是否允许重考/补考:'),
        ],
        rightActions: [
          WorkRadio(title: '是', value: true, model: isCan, margin: EdgeInsets.only(right: 67 * ScaleWidth)),
          WorkRadio(title: '否', value: false, model: isCan),
        ],
      ),
    ];

    if (modelAry.length >= 0) {
      List<Widget> top = [
        WorkTitle(title: '考试详情:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
        WorkSelect(title: '目前已考人数：', value: '57人'),
        WorkSelect(title: '及格人数：', value: '55人'),
        WorkEmpty(
          leftActions: [MainTitleLabel('平均分：')],
          rightActions: [MainTitleLabel('87.3分', textColor: ErrorColor)],
          showTopLine: false,
        ),
        WorkSelect(title: '及格人数：', value: '55人'),
        WorkTitle(title: '分数一览:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
      ];
      headerViews.addAll(top);
    }

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '档案详情'),
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                ...headerViews,
              ],
            );
          }
          return itemCell(modelAry[index - 1]);
        },
        itemCount: modelAry.length + 1,
      ),
    );
  }

  Widget itemCell(Map obj) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 135 * ScaleWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                child: MainTitleLabel(obj['name'], margin: EdgeInsets.only(left: 56 * ScaleWidth)),
              ),
              MainTitleLabel(obj['num'].toString() + '分', width: 70 * ScaleWidth, margin: EdgeInsets.only(right: 140 * ScaleWidth)),
              MainTitleLabel('点击查看试卷', textColor: NormalColor, margin: EdgeInsets.only(right: 39 * ScaleWidth)),
            ],
          ),
        ),
        LineView(),
      ],
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
