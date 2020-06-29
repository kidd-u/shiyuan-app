import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/yinhuanCard.dart';
import '../../view/yinhuanCardInput.dart';

class YinHuanDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new YinHuanDetailState();
  }
}

class YinHuanDetailState extends State<YinHuanDetailPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '确定',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '待复检', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '编号:', value: '20200308'),
          WorkSelect(title: '地点或项目：', value: 'A306'),
          WorkSelect(title: '计划：', value: '2020年3月安全综合检查'),
          WorkSelect(title: '检查人:', value: '高帅'),
          WorkSelect(title: '日期:', value: '2020-03-08'),
          WorkSelect(title: '检查部门:', value: '后勤保障部'),
          WorkTitle(title: '安全隐患:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkInputArea(value: '设备缺乏保养', enable: false),
          WorkTitle(title: '隐患照片:'),
          Container(color: Colors.white, height: 20 * ScaleWidth),
          WorkImageWithMessage(message: '极道少女附件水单费健康十多年', enabled: false, showBorder: false),
          WorkTitle(title: '整改要求:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkInputArea(value: '立即停止施工，做好设备维护', height: 188 * ScaleWidth, enable: false),
          WorkSelect(title: '责任部门或单位:', value: '相关方公司1'),
          WorkSelect(title: '整改人:', value: '赵小刚'),
          WorkEmpty(
            leftActions: <Widget>[MainTitleLabel('限期整改时间:')],
            rightActions: <Widget>[
              MainTextLabel(
                '2020-03-09（已超期）',
                textColor: ErrorColor,
              )
            ],
          ),
          theTitle(),
          YinHuanCardView(),
          YinHuanCardInputView(),
        ],
      ),
    );
  }

  Widget theTitle() {
    return WorkEmpty(
      margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 17 * ScaleWidth),
      leftActions: <Widget>[
        ImageView(
          src: 'imgs/home/yinhuan/liuchengjinzhan.png',
          width: 57 * ScaleWidth,
          height: 38 * ScaleWidth,
        ),
        MainTitleLabel(
          '流程进展:',
          margin: EdgeInsets.only(left: 40 * ScaleWidth),
        ),
      ],
      rightActions: <Widget>[],
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
