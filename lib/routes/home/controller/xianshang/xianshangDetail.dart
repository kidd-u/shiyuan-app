import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class XianShangDetailPage extends StatefulWidget {
  XianShangDetailPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new XianShangDetailState();
  }
}

class XianShangDetailState extends State<XianShangDetailPage> {
  String _procId, _title;
  List _dataArray = [];

  void initState() {
    super.initState();
    _procId = widget.arguments['procId'];
    _title = widget.arguments['name'];
//    loadSummary();
    loadDetail();
  }

  loadSummary() async {
    var summary = await HttpUtil.get('/process/online/done/summary/${widget.arguments['id']}');
  }

  loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${_procId}');
    setState(() {
      _dataArray = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, _title),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ..._dataArray
              .map((e) => WorkSelect(
                    title: e['name'],
                    value: e['label'],
                  ))
              .toList(),
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
