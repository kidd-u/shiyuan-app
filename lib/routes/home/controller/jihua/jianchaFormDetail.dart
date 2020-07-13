import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/jihuaCell.dart';
import '../../view/JainChaBiaoZhunCell.dart';

class JianChaFormDetailPage extends StatefulWidget {
  JianChaFormDetailPage({
    Key key,
    this.title, //任务标题
    this.procId, //任务id
    this.recordId, //回显表单id
    this.status, //任务状态
  }) : super();
  String title;
  String procId;
  String recordId;
  String status;

  @override
  State<StatefulWidget> createState() {
    return new JianChaFormDetailState();
  }
}

class JianChaFormDetailState extends State<JianChaFormDetailPage> {
  List _dataArray = []; //
  Map _formData = {}; //
  String _format = '';
  String _FORMAT = '';
  List _style = []; //检查标准card
  List _yinhuanArray = []; //缓存发起隐患表单
  bool _isShowAll = false; //展开收起

  void initState() {
    super.initState();
    loadDetail();
    loadDoneForm();
  }

  void loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/' + widget.procId);
    setState(() {
      _dataArray = res;
    });
  }

  void loadDoneForm() async {
    var res = await HttpUtil.get('/process/safecheck/done/detail/' + widget.recordId);
    setState(() {
      _formData = res;
      if (_formData.containsKey('format')) {
        String format = _formData['format'];
        _FORMAT = format;
        _format = format.toLowerCase() ?? '';
        var key = 'contentStyle1';
        if (_FORMAT == 'STYLE2') key = 'contentStyle2';
        if (_FORMAT == 'STYLE3') key = 'contentStyle3';
        _style = _formData[key];
        _yinhuanArray = _formData['dangers'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [];
    _dataArray.forEach((element) {
      String title = element['name'];
      String value = element['label'];
      views.add(WorkSelect(title: title, value: value));
    });
    views.add(
        WorkEmpty(leftActions: [MainTitleLabel('状态')], rightActions: [MainTextLabel(widget.status, textColor: Filter.checkColor(widget.status))]));
    List<Widget> cards = [];
    if (_format == 'style1') cards = getCard1(); //执行标准样式
    if (_format == 'style2') cards = getCard3(); //下拉选择样式，后台2和3写反了
//    if (_format == 'style3') cards = getCard2(); //发起隐患样式
    List<Widget> yinhuanCells = [];
    if (_yinhuanArray.length > 0) {
      yinhuanCells.add(WorkTitle(title: '非检查标准内隐患', showTopLine: false, showBottomLine: false));
      for (int i = 0; i < _yinhuanArray.length; i++) {
        Map item = _yinhuanArray[i];
        Map images = Filter.jsonDeCode(item['images']);
        yinhuanCells.add(WorkInputArea(
          title: '安全隐患',
          value: item['description'],
          showBottomLine: false,
          height: 240 * ScaleWidth,
          enable: false,
        ));
        yinhuanCells.add(WorkImageWithMessage(
          src: images['src'],
          message: images['message'],
          paddingTop: 30 * ScaleWidth,
          enabled: false,
        ));
      }
    }

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '检查计划执行'),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
          ...cards,
          _yinhuanArray.length > 0
              ? Container(
                  color: Colors.white,
                  height: _isShowAll ? (88 + 60 + (136 + 22 + 30 + 240) * _yinhuanArray.length) * ScaleWidth : 600 * ScaleWidth,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        child: ListView(
                          physics: new NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            ...yinhuanCells,
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 60 * ScaleWidth,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isShowAll = !_isShowAll;
                            });
                          },
                          child: Container(
                            //边框设置
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color.fromRGBO(255, 255, 255, 0.7), Colors.white],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Label(_isShowAll ? '↑' : '↓', textColor: MainBlueColor),
                                Label(_isShowAll ? '收起' : '展开', textColor: MainBlueColor),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget getTitle() {
    List<Widget> actions = [];
//    if (_FORMAT == 'STYLE1') {
//      Widget label = MainTextLabel('已符合', textColor: SuccessColor);
//      actions.add(label);
//    } else {}
    Widget fuheBtn = Label(
      '已符合',
      fontSize: 24 * ScaleWidth,
      textColor: SuccessColor,
    );
    actions.add(fuheBtn);

    return WorkEmpty(
      margin: EdgeInsets.only(top: 20 * ScaleWidth),
      leftActions: <Widget>[
        ImageView(src: 'imgs/home/jihua/jianchabiaozhun.png', width: 52 * ScaleWidth, height: 56 * ScaleWidth),
        MainTitleLabel(
          Filter.checkStyle(_format),
          fontWeight: FontWeight.bold,
          margin: EdgeInsets.only(left: 14 * ScaleWidth),
        )
      ],
      rightActions: <Widget>[...actions],
    );
  }

  void changeCard1() {
    for (int i = 0; i < _style.length; i++) {
      Map params = _style[i];
      List content = params['content'];
      for (int i = 0; i < content.length; i++) {
        setState(() {
          content[i]['value'] = 1;
        });
      }
    }
  }

  void changeCard3() {
    for (int i = 0; i < _style.length; i++) {
      Map params = _style[i];
      if (params['type'] == 'SELECT') {
        setState(() {
          _style[i]['value'] = params['options'][0];
        });
      }
    }
  }

  ///执行标准样式
  List<Widget> getCard1() {
    List<Widget> views = [getTitle()];
    for (int i = 0; i < _style.length; i++) {
      Map params = _style[i];
      String title = params['title'];
      List content = params['content'];
      views.add(
        WorkEmpty(
          leftActions: <Widget>[MainTitleLabel(title, fontWeight: FontWeight.bold)],
          rightActions: <Widget>[],
          showTopLine: false,
          showBottomLine: false,
        ),
      );
      for (int i = 0; i < content.length; i++) {
        String desc = content[i]['desc'];
        views.add(
          JiHuaCell(
            type: int.parse(content[i]['value']),
            title: desc,
          ),
        );
      }
    }
    return views;
  }

  ///发起隐患样式
  List<Widget> getCard2() {
    List<Widget> views = [];
    return views;
  }

  ///下拉选择样式
  List<Widget> getCard3() {
    List<Widget> views = [getTitle()];
    for (int i = 0; i < _style.length; i++) {
      Map params = _style[i];
      views.add(WorkSelect(
        title: params['desc'],
        value: params['value'],
      ));
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
