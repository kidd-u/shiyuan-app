import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
/**
 * 顶部蓝色，通过，无信息，无照片
 * */
class HomeWorkCardTwo extends StatefulWidget {
  const HomeWorkCardTwo({
    Key key,
    this.margin,
  }) : super(key: key);
  final EdgeInsets margin;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkCardTwoState();
  }
}

class HomeWorkCardTwoState extends State<HomeWorkCardTwo> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      margin: widget.margin,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 3.0, //阴影模糊程度
              spreadRadius: 1 //阴影扩散程度
              )
        ],
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10 * ScaleWidth),
          child: Container(
            color: Colors.white,
            width: 680 * ScaleWidth,
            child: Column(
              children: <Widget>[
                Container(
                  height: 74 * ScaleWidth,
                  padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      List: [Color(0xFF3E4AD5), Color(0xFF2532BF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('审批人：高帅', textColor: Colors.white),
                      ),
                      MainTitleLabel('通过', textColor: Colors.white)
                    ],
                  ),
                ),
                WorkInputArea(enable: false, value: '通告', showTopLine: false, showBottomLine: false),
                WorkTitle(
                    title: '上传照片（0/10）', fontWeight: FontWeight.w400, showTopLine: false, showBottomLine: false, margin: EdgeInsets.only(bottom: 30)),
              ],
            ),
          ),
        ),
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
