import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/LogUtil.dart';
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

//  List _formArray = [];
  String _title; //计划名称
  String _procId; //任务id
  bool _submitForm;//是否直接提交

  void initState() {
    super.initState();
    setState(() {
      _title = widget.arguments['title'];
      _procId = widget.arguments['procId'];
      _submitForm = widget.arguments['submitForm'];
      print(widget.arguments['procId'] is String);
    });
    getFormData();
  }

  void getFormData() async {
    var res = await HttpUtil.get('/process/common/init', params: {'name': 'DANGER_ELIMI'});
    setState(() {
      _dataArray = res;
    });
  }

  void submit() async {
    if (!checkRequired()) {
      return;
    }
    if (_submitForm) {
      await DialogUtil.dialogConfim('是否确定提交?');
      DialogUtil.showLoading();
      var res = await HttpUtil.post('/process/common/init?name=DANGER_ELIMI', params: {'forms': _dataArray});
      await DialogUtil.toastSuccess('提交成功');
      PageUtil.pop();
    }  else{
      PageUtil.pop({'forms': _dataArray});
    }
  }

  bool checkRequired() {
    for (int i = 0; i < _dataArray.length; i++) {
      Map params = _dataArray[i];
      String name = params['name'];
      bool required = params['config']['required'];
      List value = params['value'];
      if (required) {
        if (value.length == 0) {
          DialogUtil.dialogAlert('【$name】为必填');
          return false;
        } else {
          var obj = value[0];
          if (obj is String) {
            if ((obj as String).length == 0) {
              DialogUtil.dialogAlert('【$name】为必填');
              return false;
            }
          } else if (obj is List) {
            if ((obj as List).length == 0) {
              DialogUtil.dialogAlert('【$name】为必填');
              return false;
            }
          }
        }
      }
    }
    return true;
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
      onPressed: () => submit(),
    );
    List<Widget> views = [];
    for (int i = 0; i < _dataArray.length; i++) {
      var params = _dataArray[i];
      if (params['name'] == '计划' && !_submitForm) {
        _dataArray[i]['value'] = [_procId];
        _dataArray[i]['label'] = _title;
        views.add(WorkSelect(title: params['name'], value: _title));
      } else if (params['label'] != null) {
//        _dataArray[i]['value'] = [params['label']];
      } else {
        views.add(WorkUtil.getWorkFormWidget(params, onChange: (value) {
          print('选择的回调');
          print(value);
          if (value is List) {
            List valueStrAry = value.map((e) => Filter.toJson(e)).toList();
            _dataArray[i]['value'] = [...valueStrAry];
            _dataArray[i]['label'] = Filter.toJson([...value]);
          } else if (value is Map) {
            _dataArray[i]['value'] = [value['value']];
            _dataArray[i]['label'] = value['label'];
          } else {
            _dataArray[i]['value'] = [value];
            _dataArray[i]['label'] = value;
          }
          print('准备提交的form');
          LogUtil.d(Filter.toJson(_dataArray));
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
