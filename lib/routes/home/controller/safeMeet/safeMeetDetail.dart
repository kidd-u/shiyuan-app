import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkSelect.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class SafeMeetDetailPage extends StatefulWidget {
  SafeMeetDetailPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;
  
  @override
  State<StatefulWidget> createState() {
    return new SafeMeetDetailState();
  }
}

class SafeMeetDetailState extends State<SafeMeetDetailPage> {
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
      appBar: buildAppBar(context, '安全会晤详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ..._dataArray.map((e) => WorkSelect(title: e['name'],value: e['label'],)).toList(),
          Container(
            margin: EdgeInsets.only(top: 30 * ScaleWidth, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WorkButtonCancel(margin: EdgeInsets.only(right: 56 * ScaleWidth)),
                WorkButtonDone(),
              ],
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
    super.dispose();
  }
}
