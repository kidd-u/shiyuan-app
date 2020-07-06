import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class HomeWorkApplyPage extends StatefulWidget {
  HomeWorkApplyPage({
    Key key,
    this.arguments,
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkApplyState();
  }
}

class HomeWorkApplyState extends State<HomeWorkApplyPage> {
  List _dataArray = [];
  String _type = '';

  void initState() {
    super.initState();
    _type = widget.arguments['type'];
    getFormData();
  }

  void getFormData() async {
    var res = await HttpUtil.get('/process/common/init', params: {'name': _type});
    setState(() {
      _dataArray = res;
    });
  }

  void submit() async {
    if (!checkRequired()) {
      return;
    }
    await DialogUtil.dialogConfim('是否确定提交?');
    DialogUtil.showLoading();
    var res = await HttpUtil.post('/process/common/init?name=' + _type, params: {'forms': _dataArray});
    await DialogUtil.toastSuccess('提交成功');
    PageUtil.pop();
  }

  bool checkRequired() {
    for (int i = 0; i < _dataArray.length; i++) {
      Map params = _dataArray[i];
      String name = params['name'];
      bool required = params['config']['required'];
      List value = params['value'] ?? [];
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
        '发起',
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
      views.add(
        WorkUtil.getWorkFormWidget(
          params,
          onChange: (value) {
            print('选择的回调');
            print(value);
            if (value is List) {
              if (params['type'] == 'CDate' && params['config']['type'] == 'DATERANGE') {
                _dataArray[i]['value'] = value;
                _dataArray[i]['label'] = value[0] + ' 至 ' + value[1];
              } else {
                List valueStrAry = value.map((e) => Filter.toJson(e)).toList();
                _dataArray[i]['value'] = [...valueStrAry];
                _dataArray[i]['label'] = Filter.toJson([...value]);
              }
            } else if (value is Map) {
              _dataArray[i]['value'] = [value['value']];
              _dataArray[i]['label'] = value['label'];
            } else {
              _dataArray[i]['value'] = [value];
              _dataArray[i]['label'] = value;
            }
            print('准备提交的form');
            LogUtil.d(Filter.toJson(_dataArray));
          },
        ),
      );
    }
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '作业申请', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
        ],
      ),
    );
  }

  Widget addTitle() {
    return WorkEmpty(
      color: Colors.transparent,
      showBottomLine: false,
      showTopLine: false,
      leftActions: [
        MainTitleLabel('作业人信息：'),
      ],
      rightActions: [
        TextButton(
          '新增',
          fontSize: 24 * ScaleWidth,
          textColor: Colors.white,
          width: 130 * ScaleWidth,
          height: 52 * ScaleWidth,
          decoration: new BoxDecoration(
            color: NormalColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ],
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
