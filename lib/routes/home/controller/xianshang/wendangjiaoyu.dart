import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:async';

class WenDangJiaoYuPage extends StatefulWidget {
  WenDangJiaoYuPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new WenDangJiaoYuState();
  }
}

class WenDangJiaoYuState extends State<WenDangJiaoYuPage> {
  int _seconds = 60;
  Timer _timer;
  String _vftext = '';
  bool _clickable = false;
  void initState() {
    super.initState();
    _startTimer();
  }
  _startTimer() {
    _seconds = 60;
    _clickable = false;
    _vftext = '$_seconds秒后可完成培训';
    if(mounted) setState(() {});
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if(_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds --;
      _vftext = '$_seconds秒后可完成培训';
      if(mounted) setState(() {});
      if(_seconds == 0) {
        _vftext = '点击完成培训';
        _clickable = true;
      }
    });
  }

  _cancelTimer() {
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '完成',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (){
        PageUtil.push('imagejiaoyu');
      },
    );
    String text =
        '为了有效地制止各类季节性事故的发生，在中暑、食物中毒、触电、淹亡等事故发生后，能够及时地进行事故应急救援，进一步做好安全防事故工作，特制定本预案。一、指导思想一切从人民最根本的利益出发，以本市各项安全管理规定为依据，以贯彻从严治警为主线，以落实新颁发的《建设工程安全生产管理条例》为落脚点，牢记“十六字”、“安全第一，预防为主，综合治理”的方针，强化对员工的思想教育，在“重点问题”上求深化，预防事故案件，加强施工现场的安全管理，圆满地完成以施工生产为中心的各项任务。二、组织领导为切实做好事故应急救援工作，项目部成立了事故应急救援领导小组。组长由项目经理吴骏担任，副组长由总工蒋海里担任，成员由张财、刘树平、钱鸿华、张一鸣、刘惠琼、顾志军、葛冯昊组成。办公室电话：      ，奉贤区中心医院 （上海市奉贤区南奉公路6600号） ：021-57421005。领导小组将结合本单位实际情况，本着管理人员亲自抓，指定专人分工负责的原则，层层落实责任制，切实把事故应急救援工作落实到实处。三、应急救援措施（一）建立科学的安全生产管理机制。进一步落实有关安全生产的法律法规，形成生产经营自主管理、自我约束、责任自负的管理机制。按照国家的有关规定，强化责任落实和完善制度建设，配备专兼职安全管理人员，开展好事故应急救援工作，为职工建立安全健康管理体系，保障每名职工的生命安全。（二）当事故或紧急情况发生后，现场人员及时向项目部经理汇报，项目部领导小组迅速到现场组织、处理、抢救，采取措施防止事态进一步的扩大，同时向公司领导或主管部门汇报。（三）抓好职工的安全生产教育培训。项目部的主要负责人、安全生产管理人员、特种设备管理和特种作业人员严格按照国家法律、法规规定，接受安全生产教育培训，经考核合格后，持证上岗。项目部对新进场的职工进行必要的安全生产教育培训，对所有职工进行日常性的安全生产教育培训，提高职工的安全生产技能，从根源上预防安全事故的发生。（四）配备日常救援设施。为了防止职工在施工生产发生意外得不到有效地处置，项目部购置了一批常用药品（纱布、红药水、云南白药、消炎药、消暑物品等），保证第一时间使职工的伤情得到较好控制，并配备了二台车用于应急救援工作。';
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '文档教育', actions: [btn]),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView(
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                Container(
                  height: 100 * ScaleWidth,
                  child: Center(
                    child: MainTitleLabel('季节性事故应急专项教育', fontWeight: FontWeight.bold),
                  ),
                ),
                MainTextLabel(
                  text,
                  maxLines: 99999,
                  padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth, bottom: 30 * ScaleWidth),
                ),
              ],
            ),
          ),
          Container(
            height: 99 * ScaleWidth,
            color: Color(0xFF112DB8),
            child: Center(
              child: MainTitleLabel(
                _vftext,
                textColor: Colors.white,
              ),
            ),
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
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
