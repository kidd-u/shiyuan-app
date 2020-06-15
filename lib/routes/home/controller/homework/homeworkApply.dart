import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class HomeWorkApplyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWorkApplyState();
  }
}

class HomeWorkApplyState extends State<HomeWorkApplyPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '发起',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '作业申请', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkChoose(title: '作业部门/单位:', placeholder: '请选择动火部门/单位'),
          WorkInput(title: '作业证号：', value: 'LSYD20200411001'),
          WorkInput(title: '施工项目名称：', placehoder: '请输入施工项目名称'),
          WorkChoose(title: '现场负责人:', placeholder: '请选择现场负责人'),
          WorkInput(title: '联系方式:', placehoder: '请输入联系方式'),
          addTitle(),
          WorkTitleWithDelete(title: '作业人信息1'),
          WorkChoose(title: '作业人：', placeholder: '请选择作业人'),
          WorkInput(title: '特殊作业证件号:', placehoder: '请输入证件号'),
          WorkSelect(title: '证书上传:', value: ''),
          Container(color: Colors.white, height: 20 * ScaleWidth),
          WorkImageWithMessage(),
          WorkChoose(title: '现场监护人：', placeholder: '请选择现场监护人', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkChoose(title: '作业时间：', placeholder: '请选择动火时间'),
          WorkSelect(title: '作业内容:', placeholder: ''),
          WorkInputArea(placehoder: '请填写作业内容'),
          WorkSelect(title: '申请部门防范措施:', placeholder: ''),
          WorkInputArea(placehoder: '请填写申请部门防范措施'),
          WorkImageTitle(leftActions: [MainTitleLabel('现场照片：0/10')]),
          Container(color: Colors.white, height: 20 * ScaleWidth),
          WorkImageWithMessage(),
        ],
      ),
    );
  }

  Widget addTitle() {
    return WorkEmpty(
      color: Colors.transparent,
      showBottomLine: false,
      showTopLine: false,
      leftActions: [
        MainTitleLabel('作业人信息：'),
      ],
      rightActions: [
        TextButton(
          '新增',
          fontSize: 24 * ScaleWidth,
          textColor: Colors.white,
          width: 130 * ScaleWidth,
          height: 52 * ScaleWidth,
          decoration: new BoxDecoration(
            color: NormalColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ],
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
