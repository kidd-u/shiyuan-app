import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import '../../view/jihuaCell.dart';
import '../../view/JainChaBiaoZhunCell.dart';

class JianChaFormPage extends StatefulWidget {
  JianChaFormPage({
    Key key,
    this.type, //表单类型
    this.title, //任务标题
    this.procId, //任务id
    this.taskId, //表单id
    this.showForm, //是否是回显
  }) : super();
  String type;
  String title;
  String procId;
  String taskId;
  bool showForm;

  @override
  State<StatefulWidget> createState() {
    return new JianChaFormState();
  }
}

class JianChaFormState extends State<JianChaFormPage> {
  List _dataArray = []; //
  Map _formData = {}; //
  String _format = '';
  String _FORMAT = '';
  List _style = []; //检查标准card
  List _yinhuanArray = []; //缓存发起隐患表单

  void initState() {
    super.initState();
    loadDetail();
    if (widget.showForm) {
      loadForm();
    }
  }

  void loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/' + widget.procId);
    setState(() {
      _dataArray = res;
    });
  }

  void loadForm() async {
    var res = await HttpUtil.get('/process/safecheck/todo/' + widget.taskId);

    setState(() {
      _formData = res;
      if (_formData.containsKey('format')) {
        String format = _formData['format'];
        _FORMAT = format;
        _format = format.toLowerCase() ?? '';
        _style = _formData[_format];
      }
    });
  }

  void submit() async {
    print(widget.type);
    var content = _style ?? [];
    for (int i = 0; i < content.length; i++) {
      Map params = _style[i];
      if (params['value'] == null || params['value'].length == 0) {
        String title = params['label'];
        DialogUtil.dialogAlert('【$title】为必填项');
        return;
      }
    }
    await DialogUtil.dialogConfim('确定提交吗?');
    await HttpUtil.post('/process/common/init/batch?name=DANGER_ELIMI', params: {'batch': _yinhuanArray});
    var params = {'format': _FORMAT, 'content': content};
    LogUtil.d(Filter.toJson(params));
    await HttpUtil.post('/process/safecheck/todo/' + widget.taskId, params: params);
    await DialogUtil.toastSuccess('提交成功!');
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
    List<Widget> views = [];
    _dataArray.forEach((element) {
      String title = element['name'];
      String value = element['label'];
      views.add(WorkSelect(title: title, value: value));
    });
    List<Widget> cards = [];
    if (_format == 'style1') cards = getCard1(); //执行标准样式
    if (_format == 'style2') cards = getCard3(); //下拉选择样式，后台2和3写反了
    if (_format == 'style3') cards = getCard2(); //发起隐患样式
    List<Widget> yinhuanCells = [];
    for (int i = 0; i < _yinhuanArray.length; i++) {
      Map item = _yinhuanArray[i];
      yinhuanCells.add(WorkYinHuanCell(
          forms: item['forms'],
          onDelete: () async {
            await DialogUtil.dialogConfim('是否确认删除该隐患?');
            _yinhuanArray.removeAt(i);
          }));
    }

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '检查计划执行', actions: [btn]),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
          ...cards,
          ...yinhuanCells,
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
    Widget fuheBtn = TextButton(
      '一键符合',
      width: 130 * ScaleWidth,
      height: 52 * ScaleWidth,
      textColor: Colors.white,
      fontSize: 24 * ScaleWidth,
      //边框设置
      decoration: new BoxDecoration(
        color: MainDarkBlueColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    if (_FORMAT != 'STYLE2') {
      actions.add(fuheBtn);
    }
    if (_FORMAT == 'STYLE2') {
      //2对应card3
      Widget yinhuanBtn = TextButton(
        '发起隐患',
        width: 130 * ScaleWidth,
        height: 52 * ScaleWidth,
        textColor: Colors.white,
        fontSize: 24 * ScaleWidth,
        margin: EdgeInsets.only(left: 17 * ScaleWidth),
        //边框设置
        decoration: new BoxDecoration(
          color: ErrorColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      );

      actions.add(yinhuanBtn);
    }

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
            type: JiHuaType.normal,
            title: desc,
          ),
        );
      }
    }
    views.add(
      WorkYinhuanTitle(
        margin: EdgeInsets.only(top: 25 * ScaleWidth),
        onClick: () async {
          var res = await PageUtil.push('YinhuanAdd',
              arguments: {'title': widget.title, 'procId': widget.procId, 'taskId': widget.taskId, 'showForm': true});
          if (res != null) {
            print(res);
            setState(() {
              _yinhuanArray.add(res);
            });
          }
        },
      ),
    );
    return views;
  }

  ///发起隐患样式
  List<Widget> getCard2() {
    List<Widget> views = [
      TextButton(
        '发起隐患', //边框设置
        margin: EdgeInsets.all(25 * ScaleWidth),
        height: 80 * ScaleWidth,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: new Border.all(width: 1, color: LineColor),
        ),
        onPressed: () async {
          var res = await PageUtil.push('YinhuanAdd',
              arguments: {'title': widget.title, 'procId': widget.procId, 'taskId': widget.taskId, 'showForm': true});
          if (res != null) {
            print(res);
            setState(() {
              _yinhuanArray.add(res);
            });
          }
        },
      ),
    ];
    return views;
  }

  ///下拉选择样式
  List<Widget> getCard3() {
    List<Widget> views = [getTitle()];
    for (int i = 0; i < _style.length; i++) {
      Map params = _style[i];
      views.add(WorkUtil.getWorkFormWidget(params, context: context, must: true, onChange: (value) {
        print('选择了' + value);
        _style[i]['value'] = value;
      }));
    }
    views.add(
      WorkYinhuanTitle(
        onClick: () async {
          var res = await PageUtil.push('YinhuanAdd',
              arguments: {'title': widget.title, 'procId': widget.procId, 'taskId': widget.taskId, 'showForm': true});
          if (res != null) {
            print(res);
            setState(() {
              _yinhuanArray.add(res);
            });
          }
        },
      ),
    );
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
