import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class JianChaDetailPage extends StatefulWidget {
  JianChaDetailPage({
    Key key,
    this.procId,
    this.taskId,
    this.showHistory,
  }) : super();
  String procId;
  String taskId;
  bool showHistory;

  @override
  State<StatefulWidget> createState() {
    return new JianChaDetailState();
  }
}

class JianChaDetailState extends State<JianChaDetailPage> {
  List _dataArray=[];
  void initState() {
    super.initState();
    loadDetail();
  }
  loadDetail()async{
    var res=await HttpUtil.get('/process/common/detail/'+widget.procId);
    setState(() {
      _dataArray=res;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views=[];
    _dataArray.forEach((element) {
      String title=element['name'];
      String value=element['label'];
      views.add(WorkSelect(title: title,value: value));
    });
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '计划检查详情'),
      body: new ListView(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          ...views,
          titleNum(),
          JianChaDetailCell(),
          JianChaDetailCell(),
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
            '检查记录（2）',
            margin: EdgeInsets.only(left: 15 * ScaleWidth),
          )
        ],
      ),
    );
  }

  Widget JianChaDetailCell() {
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
                        child: MainTitleLabel('高帅', margin: EdgeInsets.only(left: 48 * ScaleWidth)),
                      ),
                      MainTitleLabel('后勤保障处', margin: EdgeInsets.only(right: 34 * ScaleWidth)),
                    ],
                  ),
                ),
                LineView(margin: EdgeInsets.only(left: 20 * ScaleWidth, right: 20 * ScaleWidth)),
                Container(
                  height: 98 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SubTextLabel('2020-03-08 16：00', margin: EdgeInsets.only(left: 48 * ScaleWidth)),
                      ),
                      MainTitleLabel(
                        '点击查看详情',
                        textColor: MainBlueColor,
                        margin: EdgeInsets.only(right: 34 * ScaleWidth),
                        onClick: () {
                          PageUtil.push('jianchaForm');
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
