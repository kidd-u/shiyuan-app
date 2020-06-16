import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class SpecialPeopleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SpecialPeopleDetailState();
  }
}

class SpecialPeopleDetailState extends State<SpecialPeopleDetailPage> {
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
          Container(width: ScreenWidth, height: 363 * ScaleWidth),
          WorkSelect(title: '证书名称:', value: '高处作业操作证'),
          WorkSelect(title: '持证人：', value: '王晓鹏'),
          WorkSelect(title: '证书有效期：', value: '2017/06/01 — 2020/06/01'),
          WorkSelect(title: '所属部门/单位:', value: '上海卫机电设备有限公司'),
          WorkSelect(title: '岗位:', value: '架子工'),
          WorkSelect(title: '上传人:', value: 'ADMIN'),
          WorkEmpty(
            leftActions: [MainTitleLabel('当前状态:')],
            rightActions: [
              MainTitleLabel(
                '距离证书过期还有90天',
                textColor: ErrorColor,
              )
            ],
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
