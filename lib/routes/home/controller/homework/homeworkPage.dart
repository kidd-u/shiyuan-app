import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class HomeWorkPage extends StatefulWidget {
  const HomeWorkPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkPageState();
  }
}

class HomeWorkPageState extends State<HomeWorkPage> {
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
          padding: EdgeInsets.only(bottom: 40),
          itemCount: 9,
          itemExtent: 395 * ScaleWidth,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 30 * ScaleWidth),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                      child: Container(
                        width: 690 * ScaleWidth,
                        height: 365 * ScaleWidth,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: SuccessColor,
                              height: 92 * ScaleWidth,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MainTitleLabel(
                                      '2020年冬季防火专项培训',
                                      textColor: Colors.white,
                                      margin: EdgeInsets.only(left: 36 * ScaleWidth),
                                    ),
                                  ),
                                  MainTextLabel(
                                    '2020-03-08',
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    margin: EdgeInsets.only(right: 32 * ScaleWidth),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 690 * ScaleWidth,
                                padding: EdgeInsets.only(top: 26 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    MainTextLabel('结束时间：2020-03-12'),
                                    MainTextLabel('培训类别：年度教育', margin: EdgeInsets.only(top: 16 * ScaleWidth)),
                                    MainTextLabel('培训对象：全体员工', margin: EdgeInsets.only(top: 16 * ScaleWidth)),
                                  ],
                                ),
                              ),
                            ),
                            LineView(),
                            Container(
                              height: 77 * ScaleWidth,
                              padding: EdgeInsets.only(right: 17 * ScaleWidth),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  textBtn('待审核'),
                                  textBtn('监管中', color: LoadingColor),
                                  textBtn('作业结束'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                PageUtil.push('HomeWorkDetail');
              },
            );
            return null;
          }),
    );
  }

  Widget textBtn(String text, {Color color = Colors.white, String path, double width}) {
    return TextButton(
      text,
      margin: EdgeInsets.only(left: 10 * ScaleWidth),
      width: width == null ? 132 * ScaleWidth : width,
      height: 50 * ScaleWidth,
      textColor: color == Colors.white ? Color(0xFFC2C2C2) : Colors.white,
      decoration: color == Colors.white
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
              border: new Border.all(width: 1, color: Color(0xFFC2C2C2)),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
            ),
      onPressed: (){
        PageUtil.push('homeworkCheck');
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
