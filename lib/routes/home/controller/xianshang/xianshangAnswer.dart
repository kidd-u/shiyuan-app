import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkEmpty.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class xianshangAnswer extends StatefulWidget {
  xianshangAnswer({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new WenDangJiaoYuState();
  }
}

class WenDangJiaoYuState extends State<xianshangAnswer> {
  bool _showAll = true; //是否显示错误试题
  bool _showBtn = true; //是否显示重新培训
  List _dataAry = [];
  String _title='';

  void initState() {
    super.initState();
    getAnswer();
  }

  getAnswer() async {
    print(widget.arguments);
    bool isAdmin = widget.arguments.safe(['isAdmin']) ?? false;
    var SINGLE, MULTI, TOF,summary;
    if (isAdmin) {
      setState(() {
        _showBtn = !isAdmin;
      });
      summary = await HttpUtil.get('/process/online/done/summary',
          params: {'procId': widget.arguments['procId'], 'accountId': widget.arguments['accountId']});
      SINGLE = await HttpUtil.get(
        '/process/online/done/test/detail',
        params: {'procId': widget.arguments['procId'], 'accountId': widget.arguments['accountId'], 'type': 'SINGLE', 'page': 0, 'size': 9999},
      );
      MULTI = await HttpUtil.get(
        '/process/online/done/test/detail',
        params: {'procId': widget.arguments['procId'], 'accountId': widget.arguments['accountId'], 'type': 'MULTI', 'page': 0, 'size': 9999},
      );
      TOF = await HttpUtil.get(
        '/process/online/done/test/detail',
        params: {'procId': widget.arguments['procId'], 'accountId': widget.arguments['accountId'], 'type': 'TOF', 'page': 0, 'size': 9999},
      );
    } else {
      summary = await HttpUtil.get('/process/online/done/summary/${widget.arguments['id']}');
      SINGLE = await HttpUtil.get('/process/online/done/test/${widget.arguments['id']}', params: {'type': 'SINGLE', 'page': 0, 'size': 9999});
      MULTI = await HttpUtil.get('/process/online/done/test/${widget.arguments['id']}', params: {'type': 'MULTI', 'page': 0, 'size': 9999});
      TOF = await HttpUtil.get('/process/online/done/test/${widget.arguments['id']}', params: {'type': 'TOF', 'page': 0, 'size': 9999});
    }

    List single_all = SINGLE['content'];
    List multi_all = MULTI['content'];
    List tof_all = TOF['content'];
    List dataAry = [];
    int index = 0;
    if (single_all.length > 0) {
      index += 1;
      dataAry.add({'modelType': 'title', 'label': '${index}、单选题:${single_all.length}道'});
      for (int i = 0; i < single_all.length; i++) {
        Map item = single_all[i];
        dataAry.add({'modelType': 'test', 'model': item, 'index': i});
      }
    }
    if (multi_all.length > 0) {
      index += 1;
      dataAry.add({'modelType': 'title', 'label': '${index}、多选题:${multi_all.length}道'});
      for (int i = 0; i < multi_all.length; i++) {
        Map item = multi_all[i];
        dataAry.add({'modelType': 'test', 'model': item, 'index': i});
      }
    }
    if (tof_all.length > 0) {
      index += 1;
      dataAry.add({'modelType': 'title', 'label': '${index}、判断题:${tof_all.length}道'});
      for (int i = 0; i < tof_all.length; i++) {
        Map item = tof_all[i];
        dataAry.add({'modelType': 'test', 'model': item, 'index': i});
      }
    }
    setState(() {
      _dataAry = dataAry;
      _title=summary['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '重新培训',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, _title, actions: [btn]),
      body: Container(
        child: new ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
          itemBuilder: (context, index) {
            if (index == 0) {
              return topView();
            }
            Map model = _dataAry[index - 1];
            if (model['modelType'] == 'title') {
              return WorkTitle(title: model['label']);
            } else {
              Map answer = model['model'];
              int i = model['index'];
              if (_showAll) {
                return WorkTestRadioAnswer(model: answer, index: i);
              } else {
                if (answer['isCorrect'] != true) {
                  return WorkTestRadioAnswer(model: answer, index: i);
                } else {
                  return SizedBox();
                }
              }
            }
          },
          itemCount: _dataAry.length + 1,
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      color: BackgroundColor,
      width: ScreenWidth,
      child: Column(
        children: <Widget>[
          WorkEmpty(
            margin: EdgeInsets.only(top: 20 * ScaleWidth),
            leftActions: [
              MainTitleLabel('考试详情'),
            ],
            rightActions: [
              TextButton(
                '全部试题',
                width: 130 * ScaleWidth,
                height: 52 * ScaleWidth,
                decoration: new BoxDecoration(
                  color: _showAll ? MainDarkBlueColor : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                  border: new Border.all(width: 1, color: _showAll ? MainDarkBlueColor : MainTextColor),
                ),
                textColor: _showAll ? Colors.white : MainTextColor,
                fontSize: 24 * ScaleWidth,
                margin: EdgeInsets.only(right: 16 * ScaleWidth),
                onPressed: () {
                  setState(() {
                    _showAll = true;
                  });
                },
              ),
              TextButton(
                '错误试题',
                width: 130 * ScaleWidth,
                height: 52 * ScaleWidth,
                decoration: new BoxDecoration(
                  color: _showAll ? Colors.white : MainDarkBlueColor,
                  borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                  border: new Border.all(width: 1, color: _showAll ? MainTextColor : MainDarkBlueColor),
                ),
                textColor: _showAll ? MainTextColor : Colors.white,
                fontSize: 24 * ScaleWidth,
                margin: EdgeInsets.only(right: 16 * ScaleWidth),
                onPressed: () {
                  setState(() {
                    _showAll = false;
                  });
                },
              ),
            ],
          ),
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
