import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/jihuaCell.dart';
import '../../view/JainChaBiaoZhunCell.dart';

class JianChaFormPage extends StatefulWidget {
  JianChaFormPage({
    Key key,
    this.procId,
    this.taskId,
    this.showForm,
  }) : super();
  String procId;
  String taskId;
  bool showForm;
  @override
  State<StatefulWidget> createState() {
    return new JianChaFormState();
  }
}

class JianChaFormState extends State<JianChaFormPage> {
  List _dataArray=[];
  Map _formData={};
  void initState() {
    super.initState();
    loadDetail();
    if(widget.showForm){
      loadForm();
    }
  }
  loadDetail()async{
    var res=await HttpUtil.get('/process/common/detail/'+widget.procId);
    setState(() {
      _dataArray=res;
    });
  }
  loadForm()async{
    var res=await HttpUtil.get('/process/safecheck/todo/'+widget.taskId);

    setState(() {
      _formData=res;
    });
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
    List<Widget> views=[];
    _dataArray.forEach((element) {
      String title=element['name'];
      String value=element['label'];
      views.add(WorkSelect(title: title,value: value));
    });
    String format=_formData['format'];
    List style=_formData[format.toLowerCase()];
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '检查计划执行', actions: [btn]),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
          getTitle(format),
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
          getTitle(format),
          WorkInputArea(title: '安全隐患:', placehoder: '填写隐患说明......', height: 238 * ScaleWidth, showBottomLine: false),
          WorkImageWithMessage(),
          WorkInputArea(title: '整改要求:', placehoder: '填写隐患说明......', height: 238 * ScaleWidth),
          WorkChoose(title: '整改人:', placeholder: '选择整改人'),
          WorkChoose(title: '限期整改时间:', placeholder: '请选择日期'),
          getTitle(format),
          WorkDrop(context, title: '空压机状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '冷干机状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '配电箱状态 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '排水系统 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkDrop(context, title: '环境卫生 :', must: true, actions: ['选项1', '选项2', '选项3']),
          WorkInput(title: '储气罐压力(Mpa):', must: true),
          WorkInputArea(title: '其他情况 :', placehoder: '请输入......', must: true),
          getTitle(format),
          JianChaBiaoZhunCell(),
          JianChaBiaoZhunCell(),
        ],
      ),
    );
  }

  Widget getTitle(String style) {
    List<Widget> actions = [];
    if (style == 'STYLE1') {
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
      if (style == 'STYLE3') {//3对应card2
        actions.add(fuheBtn);
      }
      if (style == 'STYLE2') {//2对应card3
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
          Filter.checkStyle(style),
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
