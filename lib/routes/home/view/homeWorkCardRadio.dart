import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

/**
 * 带radio选项，顶部蓝色，通过，带信息，带照片
 * */
class HomeWorkCardRadio extends StatefulWidget {
  const HomeWorkCardRadio({
    Key key,
    this.margin,
  }) : super(key: key);
  final EdgeInsets margin;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkCardRadioState();
  }
}

class HomeWorkCardRadioState extends State<HomeWorkCardRadio> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    String value = '1';
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
                      colors: [Color(0xFF3E4AD5), Color(0xFF2532BF)],
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
                WorkSelect(title: '动火等级：', placeholder: '', must: true, showBottomLine: false),
                Container(
                  height: 88 * ScaleWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WorkRadio(value: '1', model: value, title: '三级', margin: EdgeInsets.only(right: 70 * ScaleWidth), onChange: (value) {}),
                      WorkRadio(value: '2', model: value, title: '二级', margin: EdgeInsets.only(right: 70 * ScaleWidth), onChange: (value) {}),
                      WorkRadio(value: '3', model: value, title: '一级', onChange: (value) {}),
                    ],
                  ),
                ),
                WorkSelect(title: '上级审批：', value: '余建伟', showBottomLine: false),
                WorkSelect(title: '上级审批：', value: '余建伟', showBottomLine: false),
                LineView(margin: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth)),
                WorkInputArea(enabled: false, value: '现场已检查，不错', showTopLine: false, showBottomLine: false, height: 188 * ScaleWidth),
                WorkTitle(title: '上传照片（3/10）', fontWeight: FontWeight.w400, showTopLine: false, showBottomLine: false),
                WorkImageWithMessage(enabled: false, showBorder: false, message: '现场检查照片1'),
                WorkImageWithMessage(enabled: false, showBorder: false, message: '现场检查照片2'),
                WorkImageWithMessage(enabled: false, showBorder: false, message: '现场检查照片3'),
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
