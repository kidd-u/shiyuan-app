import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new TodoViewState();
  }
}

class TodoViewState extends State<TodoView> {
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
          itemCount: 9,
          itemExtent: 195 * ScaleWidth,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 714 * ScaleWidth,
                    height: 172 * ScaleWidth,
                    decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)), boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                          blurRadius: 3.0, //阴影模糊程度
                          spreadRadius: 1 //阴影扩散程度
                          )
                    ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 35 * ScaleWidth),
                          padding: EdgeInsets.only(left: 35 * ScaleWidth, right: 35 * ScaleWidth),
                          child: Row(
                            children: <Widget>[Expanded(child: MainTitleLabel('安全会议-全体人员-A306')), MainTitleLabel('已完成')],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50 * ScaleWidth),
                          padding: EdgeInsets.only(left: 35 * ScaleWidth, right: 35 * ScaleWidth),
                          child: Row(
                            children: <Widget>[
                              MainTextLabel('2020-05-29'),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
            return null;
          }),
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
