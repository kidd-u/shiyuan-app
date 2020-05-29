import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<MessagePage> {
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        body: new Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  children: <Widget>[
                    ImageView(
                        src: 'imgs/message/xiaoxi1.png',
                        width: 100 * ScaleWidth,
                        height: 100 * ScaleWidth,
                        margin: EdgeInsets.only(left: 22 * ScaleWidth, right: 25 * ScaleWidth)),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30 * ScaleWidth),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Label('安全培训', fontSize: 34 * ScaleWidth),
                              ),
                              SubTextLabel('12:21', margin: EdgeInsets.only(right: 25 * ScaleWidth))
                            ],
                          ),
                        ),
                        MainTextLabel(
                          '2020年全体员工消防教育',
                          margin: EdgeInsets.only(top: 18 * ScaleWidth, right: 25 * ScaleWidth),
                        ),
                        MainTextLabel(
                          '2020年全体员工消防教育',
                          margin: EdgeInsets.only(top: 15 * ScaleWidth, right: 25 * ScaleWidth),
                        ),
                        MainTextLabel(
                          '开始时间：2020/3/9 9:00',
                          margin: EdgeInsets.only(top: 15 * ScaleWidth, right: 25 * ScaleWidth),
                        ),
                        LineView(margin: EdgeInsets.only(top: 25*ScaleWidth))
                      ],
                    ))
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        elevation: 1,
        title: const Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white);
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }
}
