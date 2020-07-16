import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import './blueCart.dart';

class OffLineView extends StatelessWidget {
  const OffLineView({
    Key key,
    this.data,
  }) : super(key: key);
  final Map data;
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    String finished='${data.safe(['current','finished'])??0}';
    String pending='${data.safe(['current','pending'])??0}';

    String total='${data.safe(['current','total'])??0}';
    String lastTotal='${data.safe(['previous','total'])??0}';
    int than=int.parse(total) - int.parse(lastTotal);
    bool isAdd = than>=0;
    String thanStr=than.abs().toString();


    String total1='${data.safe(['current','signed'])??0}';

    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MainTextLabel('本月线下培训计划发起', fontWeight: FontWeight.bold, margin: EdgeInsets.only(left: 43 * ScaleWidth, top: 29 * ScaleWidth))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 67 * ScaleWidth, left: 65 * ScaleWidth),
            child: Row(
              children: <Widget>[
                ImageView(src: 'imgs/library/yueduleiji2.png', width: 118 * ScaleWidth, height: 118 * ScaleWidth),
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
                    src: 'imgs/library/daizhixing2.png',
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
            margin: EdgeInsets.only(top: 67 * ScaleWidth, left: 65 * ScaleWidth),
            child: Row(
              children: <Widget>[
                ImageView(src: 'imgs/library/yiwancheng2.png', width: 118 * ScaleWidth, height: 118 * ScaleWidth),
                Container(
                    width: 160 * ScaleWidth,
                    height: 118 * ScaleWidth,
//                    margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    child: Column(
                      children: <Widget>[
                        Label(finished, fontSize: 54 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                        Label('已办结',
                            fontSize: 24 * ScaleWidth, textColor: Color.fromRGBO(118, 118, 118, 1), margin: EdgeInsets.only(top: 10 * ScaleWidth))
                      ],
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75 * ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlueCartView(title: '本月累计培训人数', width: 430 * ScaleWidth,total: total1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
