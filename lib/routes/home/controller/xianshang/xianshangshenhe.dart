import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class XianShangShenHePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new XianShangShenHeState();
  }
}

class XianShangShenHeState extends State<XianShangShenHePage> {
  bool _agree = true;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '完成',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '线上培训计划审核', actions: [btn]),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
//              color: Colors.white,
              child: new ListView(
                physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
                children: <Widget>[
                  WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育'),
                  WorkSelect(title: '培训对象：', value: '全体员工'),
                  WorkSelect(title: '培训类别：', value: '年度教育'),
                  WorkSelect(title: '发起人：', value: 'admin'),
                  WorkSelect(title: '开始日期：', value: '2020/3/12'),
                  WorkSelect(title: '结束日期：', value: '2020/3/15'),
                  WorkFile(title: '培训资料选择：', name: '全员消防教育（视频）', type: 'video'),
                  WorkFile(title: '试卷选择：', name: '后勤保障处消防教育考试试卷（一）', type: 'file'),
                  WorkNormal(
                    title: '是否允许补考：',
                    children: <Widget>[
                      WorkRadio(
                        title: '是',
                        value: true,
                        model: _agree,
                        margin: EdgeInsets.only(right: 67 * ScaleWidth),
                        onChange: (res) {
                          setState(() {
                            _agree = res;
                          });
                        },
                      ),
                      WorkRadio(
                        title: '否',
                        value: false,
                        model: _agree,
                        margin: EdgeInsets.only(right: 39 * ScaleWidth),
                        onChange: (res) {
                          setState(() {
                            _agree = res;
                          });
                        },
                      )
                    ],
                  ),
                  WorkTitle(title: '审核意见', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
                  WorkInputArea(placehoder: '不予通过', height: 300 * ScaleWidth),
                ],
              ),
            ),
          ),
          Container(
            height: 126 * ScaleWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WorkButtonCancel(),
                WorkButtonDone(
                  margin: EdgeInsets.only(left: 56 * ScaleWidth),
                ),
              ],
            ),
          ),
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
