import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../../view/homeWorkCardOne.dart';
import '../../view/homeWorkCardTwo.dart';
import '../../view/homeWorkCardThree.dart';
import '../../view/homeWorkCardRadio.dart';
import '../../view/homeWorkCardAuditRadio.dart';
import '../../view/homeWorkCardAudit.dart';

class HomeWorkCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWorkCheckState();
  }
}

class HomeWorkCheckState extends State<HomeWorkCheckPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '文档教育'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '作业部门/单位:', value: '上海卫机电设备有限公司'),
          WorkSelect(title: '班组或岗位：', value: '一班组'),
          WorkSelect(title: '作业证号：', value: 'LSYD20200411001'),
          WorkEmpty(color: Colors.transparent, showTopLine: false, showBottomLine: false, leftActions: [MainTitleLabel('作业人信息：')], rightActions: []),
          WorkTitle(title: '作业人信息1'),
          WorkChoose(title: '作业人：', value: '李宣礼'),
          WorkSelect(title: '特殊作业证件号:', value: '134456132642'),
          WorkSelect(title: '证书上传:', placeholder: ''),
          WorkImageWithMessage(enabled: false, paddingTop: 20 * ScaleWidth),
          WorkSelect(title: '现场监护人：', value: '张小刚', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkSelect(title: '作业时间：', value: '2020.03.09-2020.03.12'),
          WorkSelect(title: '作业部位/施工项目:', placeholder: ''),
          WorkInputArea(enabled: false, value: 'A栋406', height: 188 * ScaleWidth),
          WorkSelect(title: '作业内容:', placeholder: ''),
          WorkInputArea(enabled: false, value: '申请原因', height: 188 * ScaleWidth),
          WorkSelect(title: '申请部门防范措施:', placeholder: ''),
          WorkInputArea(enabled: false, value: '已配备必要的灭火器和设备', height: 188 * ScaleWidth),
          WorkImageTitle(leftActions: [MainTitleLabel('现场照片：2/10')]),
          WorkImageWithMessage(paddingTop: 20 * ScaleWidth, message: '现场照片1', enabled: false),
          WorkImageWithMessage(message: '现场照片2', enabled: false),
          theTitle(),
          HomeWorkCardOne(),
          HomeWorkCardTwo(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          HomeWorkCardThree(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          HomeWorkCardRadio(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          HomeWorkCardAuditRadio(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          HomeWorkCardAudit(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
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
