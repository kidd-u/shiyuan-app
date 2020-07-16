import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

enum TestFileType {
  done, //已办结
  loading, //进行中
  wait, //超期未考
}

class TestFilePage extends StatefulWidget {
  const TestFilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new TestFilePageState();
  }
}

class TestFilePageState extends State<TestFilePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      child: ListView.builder(
          padding: EdgeInsets.all(30 * ScaleWidth),
          itemCount: 9,
//          itemExtent: 323 * ScaleWidth,
//          itemExtent: 365 * ScaleWidth,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return itemCell(TestFileType.done, 99, time: 90);
            if (index == 1) return itemCell(TestFileType.done, 59);
            if (index == 2) return itemCell(TestFileType.loading, 0);
            if (index == 3) return itemCell(TestFileType.wait, 0);
            return null;
          }),
    );
  }

  Widget itemCell(TestFileType type, int num, {int time = 90}) {
    List<Widget> views = [];
    Widget endTime = MainTextLabel('截止时间：2020-03-12', textColor: Color(0xFF7D7D7D));
    Widget people = MainTextLabel('培训对象：全体员工', margin: EdgeInsets.only(top: 16 * ScaleWidth), textColor: Color(0xFF7D7D7D));
    Widget testTime = MainTextLabel('考试时间：90分钟', margin: EdgeInsets.only(top: 16 * ScaleWidth), textColor: Color(0xFF7D7D7D));
    views.add(endTime);
    views.add(people);
    if (type == TestFileType.done) {
      Widget fenshu = MainTextLabel('考试时间：' + time.toString(), margin: EdgeInsets.only(top: 16 * ScaleWidth), textColor: Color(0xFF7D7D7D));
      views.add(fenshu);
    }
    views.add(testTime);
    if (type == TestFileType.done) {
      Widget fenshu = MainTextLabel('考试分数：' + num.toString(),
          margin: EdgeInsets.only(top: 16 * ScaleWidth), textColor: num >= 60 ? Color(0xFF7D7D7D) : ErrorColor);
      views.add(fenshu);
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * ScaleWidth),
//        height: type == TestFileType.loading?295*ScaleWidth:365*ScaleWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
          child: Container(
            width: 690 * ScaleWidth,
//            height: views.length == 4?333 * ScaleWidth:291 * ScaleWidth,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  color: type == TestFileType.done ? SuccessColor : type == TestFileType.loading ? LoadingColor : WaitingColor,
                  height: 92 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('2020年冬季防火专项培训', textColor: Colors.white, margin: EdgeInsets.only(left: 36 * ScaleWidth)),
                      ),
                      SubTextLabel('已办结', textColor: Colors.white, margin: EdgeInsets.only(right: 32 * ScaleWidth)),
                    ],
                  ),
                ),
                Container(
                  width: 690 * ScaleWidth,
                  padding: EdgeInsets.only(top: 26 * ScaleWidth, bottom: 30 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...views,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        PageUtil.push('testFileDetail');
      },
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
