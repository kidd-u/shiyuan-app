import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class TestErrorPage extends StatefulWidget {
  TestErrorPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new TestErrorState();
  }
}

class TestErrorState extends State<TestErrorPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '线上培训考试结果'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育'),
          WorkSelect(title: '满分:'),
          WorkSelect(title: '及格分数:', value: '80分'),
          WorkEmpty(
            showTopLine: false,
            leftActions: [MainTitleLabel('考试分数')],
            rightActions: [
              MainTitleLabel(
                '超期未考',
                textColor: ErrorColor,
                margin: EdgeInsets.only(right: 22 * ScaleWidth),
              ),
              TextBtn(
                '点击补考',
                width: 130 * ScaleWidth,
                height: 52 * ScaleWidth,
                textColor: Colors.white,
                fontSize: 24 * ScaleWidth,
                decoration: new BoxDecoration(
                  color: ErrorColor,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 205 * ScaleWidth),
            child: Center(
              child: ImageView(src: 'imgs/nav/empty.png', width: 189 * ScaleWidth, height: 219 * ScaleWidth),
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
