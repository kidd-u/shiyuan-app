import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../../model/AnswerModel.dart';

class XianXiaPeiXunPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<XianXiaPeiXunPage> {
  List<AnswerModel> modelAry = [
    AnswerModel(
      index: '第一题',
      title: '单位应当将容易发生火灾、一旦发生火灾可能严重危机人身和财产以及对消防安全有重大影细响的部位，确定为（C ）',
      answer: 'C',
      userSelect: 'C',
      isRight: true,
      answerList: ['A、重点部位', 'B、要害部位', 'C、消防安全重点部位', 'D、重点防范部位'],
    ),
    AnswerModel(
      index: '第二题',
      title: '单位应当将容易发生火灾、一旦发生火灾可能严重危机人身和财产以及对消防安全有重大影细响的部位，确定为（C ）',
      answer: 'C',
      userSelect: 'B',
      isRight: false,
      answerList: ['A、重点部位', 'B、要害部位', 'C、消防安全重点部位', 'D、重点防范部位'],
    )
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context, '线上培训考试结果'),
      backgroundColor: BackgroundColor,
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育'),
                WorkSelect(title: '满分:'),
                WorkSelect(title: '及格分数:', value: '80分'),
                WorkFenshu(title: '考试分数:', value: '后勤保障部'),
                WorkTitleTest(title: '考试详情', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
              ],
            );
          }
          return WorkTestRadio(model: modelAry[index - 1]);
        },
        itemCount: modelAry.length + 1,
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
