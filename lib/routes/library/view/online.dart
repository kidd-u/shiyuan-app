import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import './blueCart.dart';

class OnLineView extends StatelessWidget {
  const OnLineView({
    Key key,
    this.data,
  }) : super(key: key);
  final Map data;

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    String finished=data.safe(['current','finished'])??'0';
    String pending=data.safe(['current','pending'])??'0';

    String total=data.safe(['current','total'])??'0';
    String lastTotal=data.safe(['previous','total'])??'0';
    int than=int.parse(total) - int.parse(lastTotal);
    bool isAdd = than>=0;
    String thanStr=than.abs().toString();


    String total1=data.safe(['current','amount'])??'0';
    String lastTotal1=data.safe(['previous','amount'])??'0';
    int than1=int.parse(total1) - int.parse(lastTotal1);
    bool isAdd1 = than1>=0;
    String thanStr1=than1.abs().toString();

    String total2=data.safe(['current','duration'])??'0';
    String lastTotal2=data.safe(['previous','duration'])??'0';
    int than2=int.parse(total2) - int.parse(lastTotal2);
    bool isAdd2 = than2>=0;
    String thanStr2=than2.abs().toString();

    String total3=data.safe(['current','avgDuration'])??'0';
    String lastTotal3=data.safe(['previous','avgDuration'])??'0';
    int than3=int.parse(total3) - int.parse(lastTotal3);
    bool isAdd3 = than3>=0;
    String thanStr3=than3.abs().toString();

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
                  width: 160 * ScaleWidth,
                  height: 118 * ScaleWidth,
//                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label(total, fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
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
                  width: 160 * ScaleWidth,
                  height: 118 * ScaleWidth,
//                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10 * ScaleWidth),
                        child: Row(
                          children: <Widget>[
                            ImageView(src: isAdd?'imgs/library/UP.png':'imgs/library/down.png', width: 34 * ScaleWidth, height: 44 * ScaleWidth),
                            Label(thanStr, textColor: isAdd?SuccessColor:ErrorColor, fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold),
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
                  width: 160 * ScaleWidth,
                  height: 118 * ScaleWidth,
//                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label(finished, fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
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
                  width: 160 * ScaleWidth,
                  height: 118 * ScaleWidth,
//                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  child: Column(
                    children: <Widget>[
                      Label(pending, fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
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
                BlueCartView(title: '本月累计培训人数', width: 202 * ScaleWidth,total: total1,isAdd: isAdd1,add: thanStr1),
                BlueCartView(title: '累计培训时长(h)', margin: EdgeInsets.only(left: 20 * ScaleWidth), width: 202 * ScaleWidth,total: total2,isAdd: isAdd2,add: thanStr2),
                BlueCartView(title: '人均培训时长(h)', margin: EdgeInsets.only(left: 20 * ScaleWidth), width: 202 * ScaleWidth,total: total3,isAdd: isAdd3,add: thanStr3),
              ],
            ),
          )
        ],
      ),
    );
  }
}

