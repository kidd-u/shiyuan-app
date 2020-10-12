import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../../view/homeWorkCardOne.dart';
import '../../view/homeWorkCardTwo.dart';
import '../../view/homeWorkCardThree.dart';
import '../../view/homeWorkCardRadio.dart';
import '../../view/homeWorkCardAuditRadio.dart';
import '../../view/homeWorkCardAudit.dart';

class HomeWorkCheckPage extends StatefulWidget {
  HomeWorkCheckPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkCheckState();
  }
}

class HomeWorkCheckState extends State<HomeWorkCheckPage> {
  String _procId;
  String _taskId;
  String _status;
  String _title='';
  List _dataArray = [];
  List _historyArray = [];

  List _forms = [];
  String _peopleType = '';
  bool _isAccepted = false;

  void initState() {
    super.initState();
    _procId = '${widget.arguments['procId']}';
    _taskId = '${widget.arguments['taskId']}';
    _status = widget.arguments['status'];
    _title = widget.arguments['title'];
    loadDetail();
    loadHistory();
    if (_status != '已办结' && _status != '审核未通过') {
      loadForm();
    }
  }

  loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${_procId}');
    setState(() {
      _dataArray = res;
    });
  }

  ///历史回复
  void loadHistory() async {
    var res = await HttpUtil.get('/process/work/history/${_procId}', params: {'page': 0, 'size': 9999});
    setState(() {
      _historyArray = res;
    });
  }

  loadForm() async {
    var res = await HttpUtil.get('/process/work/todo/${_taskId}');
    List forms = res['forms'];
    for (int i = 0; i < forms.length; i++) {
      Map item = forms[i];
      if (item['type'] == 'CRadio') {
        var options = await HttpUtil.get('/process/common/select', params: {'source': item['config']['source']});
        item['options'] = options;
        item['value'] = [options[0]['value']];
        item['label'] = options[0]['label'];
      } else {
        item['value'] = [''];
      }
    }
    setState(() {
      _forms = res['forms'];
      if (res['type'] == 'WK_AUDIT') {
        _peopleType = '审核人';
      } else if (res['type'] == 'WK_LEADER_AUDIT') {
        _peopleType = '上级审核人';
      } else if (res['type'] == 'WK_SUPERVISE') {
        _peopleType = '监管人';
      }
    });
  }

  void submit() async {
    if (!checkRequired()) {
      return;
    }
    await DialogUtil.dialogConfim('是否确定提交?');
    DialogUtil.showLoading();
    var res = await HttpUtil.post('/process/work/todo/${_taskId}', params: {'forms': _forms});
    await DialogUtil.toastSuccess('提交成功!');
    PageUtil.pop(true);
  }

  bool checkRequired() {
    for (int i = 0; i < _forms.length; i++) {
      Map params = _forms[i];
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
    _dataArray.forEach((e) {
      if (e['type'] == 'CWork') {
        views.add(WorkWorkPeoples(value: Filter.jsonDeCode(e['label']), onChange: null, enable: false));
      } else {
        views.add(WorkSelect(title: e['name'], value: e['label']));
      }
    });
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, _title, actions: _status != '已办结'?[btn]:[]),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 30),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
          theTitle(),
          ..._historyArray.map((e) => getHistoryCard(e)).toList(),
          ..._forms.length > 0 ? [getCardInputView()] : [],
//          HomeWorkCardOne(),
//          HomeWorkCardTwo(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
//          HomeWorkCardThree(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
//          HomeWorkCardRadio(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
//          HomeWorkCardAuditRadio(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
//          HomeWorkCardAudit(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
        ],
      ),
    );
  }

  Widget theTitle() {
    return WorkEmpty(
      margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 17 * ScaleWidth),
      leftActions: <Widget>[
        ImageView(
          src: 'imgs/home/yinhuan/liuchengjinzhan.png',
          width: 57 * ScaleWidth,
          height: 38 * ScaleWidth,
        ),
        MainTitleLabel(
          '流程进展:',
          margin: EdgeInsets.only(left: 40 * ScaleWidth),
        ),
      ],
      rightActions: <Widget>[],
    );
  }

  Widget getCardInputView() {
    List<Widget> views = [];
    for (int i = 0; i < _forms.length; i++) {
      Map item = _forms[i];
      String type = item['type'];
      bool required = item['config']['required'];
      if (type == 'CRadio') {
        views.add(WorkSelect(title: '动火等级：', placeholder: '', must: required, showBottomLine: false));
        List<Widget> radios = [];
        List options = item['options'];
        for (int i = 0; i < options.length; i++) {
          Map radioItem = options[i];
          radios.add(
            WorkRadio(
              value: radioItem['value'],
              model: item['value'][0],
              title: radioItem['label'],
              margin: EdgeInsets.only(left: i == 0 ? 0 : 70 * ScaleWidth),
              onChange: (value, label) {
                setState(() {
                  item['label'] = label;
                  item['value'] = [value];
                });
              },
            ),
          );
        }
        views.add(
          Container(
            height: 88 * ScaleWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...radios,
              ],
            ),
          ),
        );
      } else if (type == 'CSwitch') {
        //放到最后，确保按钮在最后面
      } else {
        views.add(
          WorkUtil.getWorkFormWidget(
            item,
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
      Map item = _forms[i];
      String type = item['type'];
      if (type == 'CSwitch') {
        _forms[i]['label'] = _isAccepted;
        _forms[i]['value'] = [_isAccepted];
        views.add(formBtns(onchange: (value) {
          _forms[i]['label'] = _isAccepted;
          _forms[i]['value'] = [_isAccepted];
        }));
      }
    }

    return new Container(
      margin: EdgeInsets.only(top: 20 * ScaleWidth),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 3.0, //阴影模糊程度
              spreadRadius: 1 //阴影扩散程度
              )
        ],
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10 * ScaleWidth),
          child: Container(
            color: Colors.white,
            width: 680 * ScaleWidth,
            child: Column(
              children: <Widget>[
                WorkTitle(title: '${_peopleType}：${UserInfo.userInfo.name}', fontWeight: FontWeight.w400, showBottomLine: false),
                LineView(),
                ...views,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formBtns({Function onchange}) {
    return Container(
      margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 25 * ScaleWidth),
      padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
      height: 80 * ScaleWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextBtn(
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
                  onchange(_isAccepted);
                });
              },
            ),
          ),
          Expanded(
            child: TextBtn(
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
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHistoryCard(Map item) {
    List<Widget> views = [];
    List detail = item['detail'];
    bool isAccepted = false;
    String node = item['node'];
    if (node == 'WK_AUDIT') {
      node = '审核';
    }
    if (node == 'WK_LEADER_AUDIT') {
      node = '上级审批';
    }
    if (node == 'WK_SUPERVISE') {
      node = '监管';
    }
    for (int i = 0; i < detail.length; i++) {
      Map item = detail[i];
      String type = item['type'];
      if (type == 'CRadio') {
        views.add(WorkSelect(title: '动火等级：', value: item['label'], placeholder: '', enable: false));
      } else if (type == 'CSwitch') {
        isAccepted = item['label'] == 'true';
      } else if (type == 'CUpload') {
        views.add(WorkImageUpload(title: item['name'], value: Filter.jsonDeCode(item['label']), must: false, enable: false, onChange: (value) {}));
      } else {
        views.add(
//          WorkUtil.getWorkFormWidget(item, onChange: (value) {}, enable: false),
            WorkSelect(title: item['name'], value: item['label']));
      }
    }
    return new Container(
      margin: EdgeInsets.only(top: 20 * ScaleWidth),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0.0, 2.0), //阴影xy轴偏移量
              blurRadius: 3.0, //阴影模糊程度
              spreadRadius: 1 //阴影扩散程度
              )
        ],
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10 * ScaleWidth),
          child: Container(
            color: Colors.white,
            width: 680 * ScaleWidth,
            child: Column(
              children: <Widget>[
                Container(
                  height: 74 * ScaleWidth,
                  padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      colors: isAccepted ? [Color(0xFF3E4AD5), Color(0xFF2532BF)] : [Color(0xFFF75E51), Color(0xFFE03C30)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(node, textColor: Colors.white),
                      ),
                      MainTitleLabel(isAccepted ? '通过' : '不通过', textColor: Colors.white)
                    ],
                  ),
                ),
                ...views,
              ],
            ),
          ),
        ),
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
