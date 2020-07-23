import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';

class YinHuanDetailPage extends StatefulWidget {
  YinHuanDetailPage({
    Key key,
    @required this.arguments,
  }) : super(key: key);
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new YinHuanDetailState();
  }
}

class YinHuanDetailState extends State<YinHuanDetailPage> {
  String _title, _status, _procId, _taskId;
  bool _showForm, _showBtns, _showSubmit;

  List _dataArray = []; //
  List _historyArray = []; //
  //要提交的模型
  Map _formDic = {
    "reply": "",
    "images": [
      {"type": "IMAGE", "src": "", "description": ""}
    ],
  };
  bool _isAccepted = false;

  void initState() {
    super.initState();
    _title = widget.arguments['title'];
    _status = widget.arguments['status'];
    _procId = widget.arguments['procId'];
    _taskId = widget.arguments['taskId'];
    _showForm = _status == '待整改' || _status == '待验收' ? true : false;
    _showBtns = _status == '待验收' ? true : false;
    _showSubmit = _status == '已办结' ? false : true;
    loadDetail();
    loadHistory();
  }

  void loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${_procId}');
    setState(() {
      _dataArray = res;
    });
  }

  ///历史回复
  void loadHistory() async {
    var res = await HttpUtil.get('/process/dangerelimi/reply/all/${_procId}', params: {'page': 0, 'size': 9999});
    setState(() {
      _historyArray = res['content'];
    });
  }

  void submit() async {
    LogUtil.d(Filter.toJson(_formDic));
    if (_status == '待整改') {
      if (_formDic['reply'] == null || _formDic['reply'] == '') {
        DialogUtil.dialogAlert('回复内容为必填!');
        return;
      }
      if (_formDic['images'] == null || _formDic['images'].length == 0) {
        DialogUtil.dialogAlert('请上传附件!');
        return;
      }
      if (_formDic['images'][0]['src'] == null || _formDic['images'][0]['src'] == '') {
        DialogUtil.dialogAlert('请上传附件!');
        return;
      }
    }
    await DialogUtil.dialogConfim('是否确定提交?');
    if (_status == '待验收') {
      _formDic['isAccepted'] = _isAccepted;
    }
    var res = await HttpUtil.post('/process/dangerelimi/todo/${_taskId}', params: _formDic);
    await DialogUtil.toastSuccess('提交成功!');
    PageUtil.pop(true);
  }

  List<Widget> getWorkFormWidget() {
    List<Widget> views = [];
    for (int i = 0; i < _dataArray.length; i++) {
      Map param = _dataArray[i];
      String type = param['type'];
      String label = param['label'];
      String name = param['name'];
      if (type == 'CUpload' || type == 'CUploadImage') {
        List imagesList = Filter.jsonDeCode(label);
        views.add(WorkTitle(title: name));
        for (int i = 0; i < imagesList.length; i++) {
          Map item = imagesList[i];
          views.add(WorkImageWithMessage(
            src: Filter.src(item),
            message: Filter.message(item),
            enabled: false,
            showBorder: false,
            paddingTop: i == 0 ? 20 * ScaleWidth : 0,
          ));
        }
      } else if (type == 'CWork') {
        views.add(WorkWorkPeoples(value: Filter.jsonDeCode(label), onChange: null, enable: false));
      } else {
        if (name == '安全隐患' || name == '整改要求') {
          views.add(WorkTitle(title: name, margin: EdgeInsets.only(top: 20 * ScaleWidth)));
          views.add(WorkInputArea(value: label, enable: false));
        } else if (name == '隐患内容') {
          views.add(WorkInputArea(
            title: name,
            value: label,
            enable: false,
          ));
        } else {
          views.add(WorkSelect(title: name, value: label));
        }
      }
    }
    return views;
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
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, _title, actions: _showSubmit == true ? [btn] : []),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...getWorkFormWidget(),
          theTitle(),
          ..._historyArray.map((e) => yinHuanCardView(e)).toList(),
          ..._showForm ? [yinHuanCardInputView(context)] : [],
          ..._showBtns ? [formBtns()] : [],
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

  Widget yinHuanCardInputView(BuildContext context) {
    String type = _status == '待整改' ? '整改人' : '验收人';
    return new Container(
      margin: EdgeInsets.only(bottom: 20 * ScaleWidth),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
          child: Container(
            width: 688 * ScaleWidth,
            padding: EdgeInsets.only(bottom: 5),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
              border: new Border.all(width: 1, color: LineColor),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 75 * ScaleWidth,
                  padding: EdgeInsets.only(left: 45 * ScaleWidth, right: 45 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('${type}：${UserInfo.userInfo.name}'),
                      ),
                    ],
                  ),
                ),
                LineView(),
                WorkInputArea(
                  title: '回复：',
                  must: true,
                  placehoder: '请输入回复内容......',
                  showBottomLine: false,
                  showTopLine: false,
                  onChange: (value) {
                    _formDic['reply'] = value;
                  },
                ),
                WorkImageTitle(
                  leftActions: [
                    MainTitleLabel(
                      '*',
                      textColor: WarningColor,
                      margin: EdgeInsets.only(left: 20 * ScaleWidth),
                    ),
                    MainTitleLabel(
                      '上传附件',
                    )
                  ],
                  onAdd: () {
                    setState(() {
                      _formDic['images'].add({"type": "IMAGE", "src": "", "description": ""});
                    });
                  },
                ),
                ...(_formDic['images'] as List)
                    .map((e) => WorkImageWithMessage(
                          src: e['src'],
                          message: e['description'],
                          onDelete: () {
                            setState(() {
                              (_formDic['images'] as List).remove(e);
                            });
                          },
                          onChange: (src, message) {
                            e['src'] = src;
                            e['description'] = message;
                          },
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget yinHuanCardView(Map param) {
    String type = param['type'] == 'RECTIFY' ? '整改人' : '验收人';
    String name = param['account']['name'];
    String reply = param['reply'];
    List images = param['images'];
    String time = param['replyDate'];
    bool isAccepted = param['isAccepted'] ?? false;

    return new Container(
      margin: EdgeInsets.only(bottom: 20 * ScaleWidth),
      child: Center(
        child: Container(
          width: 688 * ScaleWidth,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
            border: new Border.all(width: 1, color: LineColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
            child: Column(
              children: <Widget>[
                Container(
                  color: type == '整改人' ? Colors.white : isAccepted ? MainDarkBlueColor : ErrorColor,
                  height: 75 * ScaleWidth,
                  padding: EdgeInsets.only(left: 45 * ScaleWidth, right: 45 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(
                          '$type：$name',
                          textColor: type == '整改人' ? MainTitleColor : Colors.white,
                        ),
                      ),
                      MainTitleLabel(
                        isAccepted ? '通过' : '不通过',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
                MainTextLabel(
                  reply,
                  maxLines: 9999,
                  width: 587 * ScaleWidth,
                  margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 50 * ScaleWidth),
                ),
                MainTitleLabel('附件（1/50）', width: 587 * ScaleWidth, margin: EdgeInsets.only(bottom: 35 * ScaleWidth)),
                ...images.map((e) => WorkImageWithMessage(src: e['src'], message: e['description'], enabled: false, showBorder: false)).toList(),
                LineView(),
                Container(
                  height: 70 * ScaleWidth,
                  child: Center(
                    child: SubTextLabel(time, textColor: WaitingColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formBtns() {
    return Container(
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
                });
              },
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
