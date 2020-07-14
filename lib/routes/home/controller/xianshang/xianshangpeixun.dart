import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

///已完成
class XianXiaPeiXunPage extends StatefulWidget {
  XianXiaPeiXunPage({
    Key key,
    this.arguments,
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<XianXiaPeiXunPage> {
  String _procId, _taskId, _status;
  List _dataAry = [];
  List _forms = [];
  bool _isAccepted=false;

  void initState() {
    super.initState();
    _procId = widget.arguments['procId'];
    _taskId = widget.arguments['id'];
    _status = widget.arguments['status'];
    getDetail();
    if (_status == '待审核') {
      loadForms();
    }
  }

  getDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${_procId}');
    setState(() {
      _dataAry = res;
    });
  }
  loadForms() async {
    var res = await HttpUtil.get('/process/offline/todo/${_taskId}');
    setState(() {
      _forms = res['forms'];
      for (int i = 0; i < _forms.length; i++) {
        Map item=_forms[i];
        if (item['name'] == '是否通过') {
          _forms[i]['value'] = ['${false}'];
          _forms[i]['label'] = '${false}';
          break;
        }
      }
    });
  }
  submit() async {
    LogUtil.d(Filter.toJson(_forms));
    await DialogUtil.dialogConfim('是否确定提交?');
    var res = await HttpUtil.post('/process/offline/todo/${_taskId}', params: {'forms': _forms});
    PageUtil.pop(true);
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
    return new Scaffold(
      appBar: buildAppBar(context, '线上培训考试结果',actions: _status == '待审核' ? [btn] : []),
      backgroundColor: BackgroundColor,
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ..._dataAry.map((e) {
            String name = e['name'];
            String label = e['label'];
            if (name == '是否需要考试' && label == '是') {
              return WorkEmpty(
                leftActions: [MainTitleLabel(name)],
                rightActions: [
                  MainTextLabel(label),
                  MainTextLabel(
                    '(查看考试详情)',
                    textColor: MainDarkBlueColor,
                    onClick: () {
                      PageUtil.push('xianshangAnswer',arguments: widget.arguments);
                    },
                  ),
                ],
              );
            }
            return WorkSelect(title: name, value: label);
          }).toList(),
          WorkEmpty(
            leftActions: [MainTitleLabel('状态')],
            rightActions: [MainTextLabel(_status, textColor: Filter.checkColor(_status))],
            showTopLine: false,
          ),
          ..._status == '待审核' ? shenhe() : [],
        ],
      ),
    );
  }
  List<Widget> shenhe() {

    List<Widget> views = [];
    for (int i = 0; i < _forms.length; i++) {
      Map params = _forms[i];
      if (params['name'] != '是否通过') {
        views.add(
          WorkUtil.getWorkFormWidget(
            params,
            onChange: (value) {
              print('选择的回调');
              print(value);
              if (value is List) {
                List valueStrAry = value.map((e) => Filter.toJson(e)).toList();
                _forms[i]['value'] = [...valueStrAry];
                _forms[i]['label'] = Filter.toJson([...value]);
              } else if (value is Map) {
                _forms[i]['value'] = [value['value']];
                _forms[i]['label'] = value['label'];
              } else {
                _forms[i]['value'] = [value];
                _forms[i]['label'] = value;
              }
              print('准备提交的form');
              LogUtil.d(Filter.toJson(_forms));
            },
          ),
        );
      }
    }
    for (int i = 0; i < _forms.length; i++) {
      Map params = _forms[i];
      if (params['name'] == '是否通过') {
        views.add(Container(
          margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 40),
          padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
          height: 80 * ScaleWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  '不通过',
                  textColor: _isAccepted ? WarningColor : Colors.white, //边框设置
                  fontSize: 28 * ScaleWidth,
                  decoration: new BoxDecoration(
                    color: _isAccepted ? Colors.white : WarningColor,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: new Border.all(width: 1, color: WarningColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _isAccepted = false;
                      _forms[i]['value'] = ['${false}'];
                      _forms[i]['label'] = '${false}';
                    });
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  '通过',
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  textColor: _isAccepted ? Colors.white : MainDarkBlueColor,
                  //边框设置
                  fontSize: 28 * ScaleWidth,
                  decoration: new BoxDecoration(
                    color: _isAccepted ? MainDarkBlueColor : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: new Border.all(width: 1, color: MainDarkBlueColor),
                  ),
                  onPressed: () {
                    setState(() {
                      _isAccepted = true;
                      _forms[i]['value'] = ['${true}'];
                      _forms[i]['label'] = '${true}';
                    });
                  },
                ),
              )
            ],
          ),
        ));
        break;
      }
    }
    return views;
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
