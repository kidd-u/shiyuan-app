import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import './blueCart.dart';

class OnLineView extends StatefulWidget {
  const OnLineView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new OnLineViewState();
  }
}

class OnLineViewState extends State<OnLineView> {
  String getTitle() {
    print('key===');
    return widget.title;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MainTextLabel(
                '本月线上培训计划发起',
                fontWeight: FontWeight.bold,
                margin: EdgeInsets.only(left: 43 * ScaleWidth, top: 29 * ScaleWidth),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 67 * ScaleWidth, left: 65 * ScaleWidth),
            child: Row(
              children: <Widget>[
                ImageView(src: 'imgs/library/yueduleiji.png', width: 118 * ScaleWidth, height: 118 * ScaleWidth),
                Container(
                  width: 100 * ScaleWidth,
                  height: 118 * ScaleWidth,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label('45', fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      Label('月度累计',
                          fontSize: 24 * ScaleWidth, textColor: Color.fromRGBO(118, 118, 118, 1), margin: EdgeInsets.only(top: 10 * ScaleWidth))
                    ],
                  ),
                ),
                ImageView(
                    src: 'imgs/library/tongbishangyue.png',
                    width: 118 * ScaleWidth,
                    height: 118 * ScaleWidth,
                    margin: EdgeInsets.only(left: 43 * ScaleWidth)),
                Container(
//                  width: 100 * ScaleWidth,
                  height: 118 * ScaleWidth,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10 * ScaleWidth),
                        child: Row(
                          children: <Widget>[
                            ImageView(src: 'imgs/library/UP.png', width: 34 * ScaleWidth, height: 44 * ScaleWidth),
                            Label('45', textColor: Color.fromRGBO(97, 204, 162, 1), fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      Label('同比上月',
                          fontSize: 24 * ScaleWidth, textColor: Color.fromRGBO(118, 118, 118, 1), margin: EdgeInsets.only(top: 10 * ScaleWidth))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 67 * ScaleWidth, left: 65 * ScaleWidth),
            child: Row(
              children: <Widget>[
                ImageView(src: 'imgs/library/yiwancheng.png', width: 118 * ScaleWidth, height: 118 * ScaleWidth),
                Container(
                  width: 100*ScaleWidth,
                  height: 118 * ScaleWidth,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label('45', fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      Label('已完成',
                          fontSize: 24 * ScaleWidth, textColor: Color.fromRGBO(118, 118, 118, 1), margin: EdgeInsets.only(top: 10 * ScaleWidth))
                    ],
                  ),
                ),
                ImageView(
                    src: 'imgs/library/daizhixing.png',
                    width: 118 * ScaleWidth,
                    height: 118 * ScaleWidth,
                    margin: EdgeInsets.only(left: 43 * ScaleWidth)),
                Container(
                  width: 100*ScaleWidth,
                  height: 118 * ScaleWidth,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label('45', fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      Label('待执行',
                          fontSize: 24 * ScaleWidth, textColor: Color.fromRGBO(118, 118, 118, 1), margin: EdgeInsets.only(top: 10 * ScaleWidth))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75 * ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlueCartView(title: '本月累计培训人数', width: 202 * ScaleWidth),
                BlueCartView(title: '累计培训时长(h)', margin: EdgeInsets.only(left: 20 * ScaleWidth), width: 202 * ScaleWidth),
                BlueCartView(title: '人均培训时长(h)', margin: EdgeInsets.only(left: 20 * ScaleWidth), width: 202 * ScaleWidth),
              ],
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
