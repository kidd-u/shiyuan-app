import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class XianXiaDetailPage extends StatefulWidget {
  XianXiaDetailPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;
  @override
  State<StatefulWidget> createState() {
    return new XianXiaDetailState();
  }
}

class XianXiaDetailState extends State<XianXiaDetailPage> {
  String _procId;
  List _dataArray = [];
  void initState() {
    super.initState();
    _procId=widget.arguments['procId'];
    loadDetail();
  }
  loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/' + _procId);
    setState(() {
      _dataArray = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '线下培训详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ..._dataArray.map((e) => WorkSelect(title: e['name'],value: e['label'],)).toList(),
          WorkEmpty(
              leftActions: [MainTitleLabel('计划状态', fontWeight: FontWeight.w400)],
              rightActions: [MainTitleLabel('已完成', fontWeight: FontWeight.w400, textColor: SuccessColor)]),
          WorkEmpty(
              leftActions: [MainTitleLabel('我的参与情况:', fontWeight: FontWeight.w400)],
              rightActions: [MainTitleLabel('未打卡', fontWeight: FontWeight.w400, textColor: ErrorColor)]),
          WorkEmpty(leftActions: [
            MainTitleLabel('已签到记录（', fontWeight: FontWeight.w400),
            MainTitleLabel(
              '121',
              fontWeight: FontWeight.w400,
              textColor: MainDarkBlueColor,
            ),
            MainTitleLabel('）', fontWeight: FontWeight.w400),
          ], rightActions: [
            MainTitleLabel(
              '查看浏览详情',
              fontWeight: FontWeight.w400,
              textColor: MainDarkBlueColor,
              onClick: (){
                PageUtil.push('signList');
              },
            )
          ]),
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
