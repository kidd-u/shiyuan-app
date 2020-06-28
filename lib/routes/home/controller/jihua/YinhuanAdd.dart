import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class YinhuanAddPage extends StatefulWidget {
  YinhuanAddPage({
    Key key,
    this.arguments,
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new YinhuanAddState();
  }
}

class YinhuanAddState extends State<YinhuanAddPage> {
  List _dataArray = [];
  List _formArray = [];
  String _title; //计划名称
  String _procId; //任务id

  void initState() {
    super.initState();
    setState(() {
      _title = widget.arguments['title'];
      _procId = widget.arguments['procId'];
    });
    getFormData();
  }

  getFormData() async {
    var res = await HttpUtil.get('/process/common/init', params: {'name': 'DANGER_ELIMI'});
    setState(() {
      _dataArray = res;
    });
    _formArray = _dataArray.map((e) {
      Map res = {
        'index': e['index'],
        'name': e['name'],
        'type': e['type'],
        'label': e['label'],
        'value': [],
      };
      if (e['name'] == '计划') {
        res['value'] = [_procId];
      }
      return res;
    }).toList();
    print(_formArray);
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
    List<Widget> views = [];
    for (int i = 0; i < _dataArray.length; i++) {
      var params = _dataArray[i];
      if (params['name'] == '计划') {
        views.add(WorkSelect(title: params['name'], value: _title));
      } else {
        views.add(WorkUtil.getWorkFormWidget(params, onChange: (value) {
          print('选择的回调');
          print(value);
          if (value is List) {
            _formArray[i]['value'] = [...value];
          } else if (value is Map) {
            _formArray[i]['value'] = [value['id']];
          } else {
            _formArray[i]['value'] = [value];
          }
          print('准备提交的form');
          print(_formArray);
        }));
      }
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
