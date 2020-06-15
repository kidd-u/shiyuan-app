import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/jihuaCell.dart';
import '../../view/JainChaBiaoZhunCell.dart';

class JianChaFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new JianChaFormState();
  }
}

class JianChaFormState extends State<JianChaFormPage> {
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
      appBar: buildAppBar(context, '检查计划执行', actions: [btn]),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '检查地点或项目：', value: '二号楼一层电梯'),
          WorkSelect(title: '计划：', value: '2020年3月隐患综合排查'),
          WorkSelect(title: '日期：', value: '2020-03-08'),
          WorkSelect(title: '检查人：', value: '高帅'),
          WorkSelect(title: '检查部门：', value: '后勤保障部'),
          getTitle(1),
          WorkEmpty(
            leftActions: <Widget>[MainTitleLabel('火灾自动报警系统联动控制柜', fontWeight: FontWeight.bold)],
            rightActions: <Widget>[],
            showTopLine: false,
            showBottomLine: false,
          ),
          JiHuaCell(
            type: JiHuaType.normal,
            title: '认真执行《电力安全工作规程》等电业法规；做好系统模拟图、二次线路图、电缆走向图。认真执行工作票、操作票、临时用电证。定期检修、定期试验、定期清理。',
          ),
          JiHuaCell(
            type: JiHuaType.waring,
            title: '认真执行《电力安全工作规程》等电业法规；做好系统模拟图、二次线路图、电缆走向图。认真执行工作票、操作票、临时用电证。定期检修、定期试验、定期清理。',
          ),
          JiHuaCell(
            type: JiHuaType.danger,
            title: '认真执行《电力安全工作规程》等电业法规；做好系统模拟图、二次线路图、电缆走向图。认真执行工作票、操作票、临时用电证。定期检修、定期试验、定期清理。',
          ),
          WorkEmpty(
            leftActions: <Widget>[
              MainTitleLabel('非检查标准内隐患', fontWeight: FontWeight.bold),
            ],
            rightActions: <Widget>[
              ImageView(
                src: 'imgs/home/yinhuanfaqi/add.png',
                width: 30 * ScaleWidth,
                height: 29 * ScaleWidth,
                margin: EdgeInsets.only(right: 20 * ScaleWidth),
                onClick: () {},
              ),
              MainTextLabel(
                '添加隐患',
                textColor: Color(0xFF959595),
                onClick: () {},
              ),
            ],
          ),
          WorkInputArea(title: '安全隐患:', placehoder: '填写隐患说明......', showTopLine: false),
          WorkImageTitle(leftActions: <Widget>[]),
          WorkImageWithMessage(),
          getTitle(0),
          WorkInputArea(title: '安全隐患:', placehoder: '填写隐患说明......', height: 238 * ScaleWidth, showBottomLine: false),
          WorkImageWithMessage(),
          WorkInputArea(title: '整改要求:', placehoder: '填写隐患说明......', height: 238 * ScaleWidth),
          WorkChoose(title: '整改人:', placeholder: '选择整改人'),
          WorkChoose(title: '限期整改时间:', placeholder: '请选择日期'),
          getTitle(2),
          WorkDrop(context, title: '空压机状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '冷干机状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '配电箱状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '排水系统 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '环境卫生 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkInput(title: '储气罐压力(Mpa):', must: true),
          WorkInputArea(title: '其他情况 :', placehoder: '请输入......', must: true),
          getTitle(1),
          JianChaBiaoZhunCell(),
          JianChaBiaoZhunCell(),
        ],
      ),
    );
  }

  Widget getTitle(int type) {
    List<Widget> actions = [];
    if (type == 0) {
      Widget label = MainTextLabel('已符合', textColor: SuccessColor);
      actions.add(label);
    } else {
      Widget fuheBtn = TextButton(
        '一键符合',
        width: 130 * ScaleWidth,
        height: 52 * ScaleWidth,
        textColor: Colors.white,
        fontSize: 24 * ScaleWidth,
        //边框设置
        decoration: new BoxDecoration(
          color: MainDarkBlueColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      );
      if (type == 1) {
        actions.add(fuheBtn);
      }
      if (type == 2) {
        Widget yinhuanBtn = TextButton(
          '发起隐患',
          width: 130 * ScaleWidth,
          height: 52 * ScaleWidth,
          textColor: Colors.white,
          fontSize: 24 * ScaleWidth,
          margin: EdgeInsets.only(left: 17 * ScaleWidth),
          //边框设置
          decoration: new BoxDecoration(
            color: ErrorColor,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        );
        actions.add(fuheBtn);
        actions.add(yinhuanBtn);
      }
    }

    return WorkEmpty(
      margin: EdgeInsets.only(top: 20 * ScaleWidth),
      leftActions: <Widget>[
        ImageView(src: 'imgs/home/jihua/jianchabiaozhun.png', width: 52 * ScaleWidth, height: 56 * ScaleWidth),
        MainTitleLabel(
          '检查标准 1',
          fontWeight: FontWeight.bold,
          margin: EdgeInsets.only(left: 14 * ScaleWidth),
        )
      ],
      rightActions: <Widget>[...actions],
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
