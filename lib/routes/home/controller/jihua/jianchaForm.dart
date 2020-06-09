import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/jihuaCell.dart';

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
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '检查地点或项目：', value: '二号楼一层电梯'),
          WorkSelect(title: '计划：', value: '2020年3月隐患综合排查'),
          WorkSelect(title: '日期：', value: '2020-03-08'),
          WorkSelect(title: '检查人：', value: '高帅'),
          WorkSelect(title: '检查部门：', value: '后勤保障部'),
          WorkEmpty(
            margin: EdgeInsets.only(top: 20 * ScaleWidth),
            leftActions: <Widget>[
              ImageView(src: 'imgs/home/jihua/jianchabiaozhun.png', width: 52 * ScaleWidth, height: 56 * ScaleWidth),
              MainTitleLabel(
                '检查标准 1',
                fontWeight: FontWeight.bold,
                margin: EdgeInsets.only(left: 14 * ScaleWidth),
              )
            ],
            rightActions: <Widget>[
              TextButton(
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
              ),
            ],
          ),
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
                '添加照片',
                textColor: Color(0xFF959595),
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                onClick: () {},
              ),
              WorkInputArea(title: '安全隐患:',placehoder: '填写隐患说明......',)
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
