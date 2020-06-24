import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class YinhuanAddPage extends StatefulWidget {
  YinhuanAddPage({
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
    return new YinhuanAddState();
  }
}

class YinhuanAddState extends State<YinhuanAddPage> {
  List _dataArray = [];

  void initState() {
    super.initState();
    getFormData();
  }

  getFormData() async {
    var res = await HttpUtil.get('/process/common/init', params: {'name': 'DANGER_ELIMI'});
    setState(() {
      _dataArray = res;
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
    for (int i = 0; i < _dataArray.length; i++) {
      var params = _dataArray[i];
      views.add(WorkUtil.getWorkFormWidget(params));
    }
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '隐患发起', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
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
