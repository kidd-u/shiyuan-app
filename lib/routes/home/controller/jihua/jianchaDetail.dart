import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class JianChaDetailPage extends StatefulWidget {
  JianChaDetailPage({
    Key key,
    this.type, //表单类型
    this.title, //任务标题
    this.procId, //任务id
    this.taskId, //表单id
  }) : super();
  String type;
  String title;
  String procId;
  String taskId;

  @override
  State<StatefulWidget> createState() {
    return new JianChaDetailState();
  }
}

class JianChaDetailState extends State<JianChaDetailPage> {
  List _dataArray = [];
  List _formArray = [];

  void initState() {
    super.initState();
    loadDetail();
    loadJainCha();
  }

  loadDetail() async {
    var res = await HttpUtil.get('/process/common/detail/' + widget.procId);
    setState(() {
      _dataArray = res;
    });
  }

  loadJainCha() async {
    var res = await HttpUtil.get('/process/safecheck/done/summary/' + widget.procId);
    setState(() {
      _formArray = res;
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
    if (_formArray.length > 0) {
      views.add(titleNum());
      for (int i = 0; i < _formArray.length; i++) {
        Map item = _formArray[i];
        views.add(JianChaDetailCell(item));
      }
    }
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '计划检查详情'),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
        ],
      ),
    );
  }

  Widget titleNum() {
    return new Container(
      height: 100 * ScaleWidth,
      margin: EdgeInsets.only(top: 12 * ScaleWidth),
      child: Row(
        children: <Widget>[
          ImageView(
            src: 'imgs/home/jihua/jianchabiaozhun.png',
            width: 34 * ScaleWidth,
            height: 36 * ScaleWidth,
            margin: EdgeInsets.only(left: 45 * ScaleWidth),
          ),
          MainTitleLabel(
            '检查记录（' + _formArray.length.toString() + '）',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
          )
        ],
      ),
    );
  }

  Widget JianChaDetailCell(Map item) {
    String account = item['account']['name'];
    String depart = item['depart']['name'];
    String time = Filter.timeHours(item['recordAt']);
    return new Container(
      margin: EdgeInsets.only(bottom: 27 * ScaleWidth),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Container(
            width: 690 * ScaleWidth,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  height: 98 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(account, margin: EdgeInsets.only(left: 48 * ScaleWidth)),
                      ),
                      MainTitleLabel(depart, margin: EdgeInsets.only(right: 34 * ScaleWidth)),
                    ],
                  ),
                ),
                LineView(margin: EdgeInsets.only(left: 20 * ScaleWidth, right: 20 * ScaleWidth)),
                Container(
                  height: 98 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SubTextLabel(time, margin: EdgeInsets.only(left: 48 * ScaleWidth)),
                      ),
                      MainTitleLabel(
                        '点击查看详情',
                        textColor: MainBlueColor,
                        margin: EdgeInsets.only(right: 34 * ScaleWidth),
                        onClick: () {
                          PageUtil.push('jianchaFormDetail',
                              arguments: {'title': widget.title, 'type': widget.type, 'procId': widget.procId, 'recordId': item['id'].toString()});
                        },
                      ),
                    ],
                  ),
                ),
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
