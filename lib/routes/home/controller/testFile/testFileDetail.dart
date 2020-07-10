import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkFile.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class TestFileDetailPage extends StatefulWidget {
  TestFileDetailPage({
    Key key,
    this.arguments,
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new TestFileDetailState();
  }
}

class TestFileDetailState extends State<TestFileDetailPage> {
  String _procId;
  List _details = [];
  List _archives = [];
  List _peoples = [];

  void initState() {
    super.initState();
    _procId = '${widget.arguments['procId']}';
    getDetail();
    getArchive();
    getHistory();
  }

  getDetail() async {
    var res = await HttpUtil.get('/process/common/detail/${_procId}');
    setState(() {
      _details = res;
    });
  }

  getArchive() async {
    var res = await HttpUtil.get('/process/test/archive/${_procId}');
    setState(() {
      _archives = res[0]['detail'];
    });
  }

  getHistory() async {
    var res = await HttpUtil.get('/process/test/summary/${_procId}');
    setState(() {
      _peoples=res['content'];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> headerViews = [..._details.map((e) => WorkSelect(title: e['name'], value: e['label'])).toList()];

    List<Widget> top = [
      WorkTitle(title: '考试详情:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
      ..._archives.map((e) {
        if (e['name'] == '平均分') {
          return WorkEmpty(leftActions: [MainTextLabel(e['name'])], rightActions: [MainTextLabel(e['label'], textColor: LoadingColor)]);
        } else {
          return WorkSelect(title: e['name'], value: e['label']);
        }
      }).toList(),
      WorkTitle(title: '分数一览:', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
    ];
    headerViews.addAll(top);

    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '档案详情'),
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                ...headerViews,
              ],
            );
          }
          return itemCell(_peoples[index - 1]);
        },
        itemCount: _peoples.length + 1,
      ),
    );
  }

  Widget itemCell(Map item) {
    return GestureDetector(
      onTap: (){
        item['isAdmin']=true;
        PageUtil.push('xianshangAnswer',arguments: item);
      },
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 135 * ScaleWidth,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTitleLabel(item['accountName'], margin: EdgeInsets.only(left: 56 * ScaleWidth)),
                ),
                MainTitleLabel('${item['score']}分', width: 100 * ScaleWidth, margin: EdgeInsets.only(right: 140 * ScaleWidth)),
                MainTitleLabel('点击查看试卷', textColor: NormalColor, margin: EdgeInsets.only(right: 39 * ScaleWidth)),
              ],
            ),
          ),
          LineView(),
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
