import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<MessagePage> {
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController refreshViewController = new RefreshViewController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  void onRefresh() async {
    _pageIndex = 0;
    _content = [];
    loadDataByPage(_pageIndex);
  }

  void onLoad() async {
    loadDataByPage(_pageIndex + 1);
  }

  void loadDataByPage(int page) async {
    try {
      var res = await HttpUtil.get('/message/', params: {'page': page, 'size': 15});
      List content = res['content'];
      setState(() {
        _content = [..._content, ...content];
        if (content.length > 0) {
          _pageIndex = page;
        }
      });
      refreshViewController.finish(success: true, noMore: _content.length < 15);
    } catch (err) {
      refreshViewController.finish(success: false, noMore: page != 0);
      print(err);
    }
  }

  didSelectRow(Map item) {
    String type = item['taskInfo']['type'];
    String procTmplName = item['taskInfo']['procTmplName'];
    print(type);
    if (procTmplName == 'TEMP_CHECK' || procTmplName == 'REGULAR_CHECK' || procTmplName == 'REGULAR_CHECK_RECORD') {
      //临时检查，定期检查，定期检查档案
      jiancha(item['taskInfo'], procTmplName == 'TEMP_CHECK' ? '临时检查' : '定期检查');
    } else if (procTmplName == 'DANGER_ELIMI') {
      //隐患整改
      yinhuan(item['taskInfo'], type == 'DE_RECTIFY' ? '隐患整改' : '隐患验收');
    } else if (procTmplName == 'LEADER_CHECK') {
      //上级检查
      yinhuan(item['taskInfo'], type == 'LC_RECTIFY' ? '隐患整改' : '隐患验收');
    } else if (procTmplName == 'FIRE_WORK' ||
        procTmplName == 'ELECTRIC_WORK' ||
        procTmplName == 'LIMIT_WORK' ||
        procTmplName == 'CLIMB_WORK' ||
        procTmplName == 'FRAG_WORK') {
      //动火作业，临时用电，有限空间，登高作业，零星工程
      homeWork(item['taskInfo']); //作业管理
    } else if (procTmplName == 'OFFLINE_CLASS') {
      //线下培训
      if (type == 'FC_SIGN') {
        scan();
      } else {
        xianxia(item);
      }
    } else if (procTmplName == 'SAFE_MEETING') {
      safeMetting(item);
    } else if (procTmplName == 'ONLINE_CLASS' || procTmplName == 'ONLINE_TEST') {
      oc_test(item['taskInfo']);
    } else {
      DialogUtil.dialogAlert('不支持的消息类型');
    }
    HttpUtil.post('/message/read/${item['id']}');
//    refreshViewController.callRefresh();
//    onRefresh();
  }

  oc_test(Map item) async {
    DialogUtil.showLoading();
    var res = await HttpUtil.get('/process/online/train/${item['id']}');
    if (res['type'] == 'OC_CLASS') {
      String type = res['material']['type'];
      Map material = res['material'];
      material = {...material, 'content': item, 'title': '在线培训', 'page': PageUtil.currentPage(context)};
      print('数据*****');
      LogUtil.d(Filter.toJson(material));
      print(type);
      if (type == 'IMAGE') {
        PageUtil.push('imagejiaoyu', arguments: material);
      } else if (type == 'TEXT') {
        PageUtil.push('wendangjiaoyu', arguments: material);
      } else {
        PageUtil.push('videojiaoyu', arguments: material);
      }
    } else {
      Map paper = res['paper'];
      DialogUtil.showLoading();
      var SINGLE = await HttpUtil.get('/process/online/test/${paper['id']}', params: {'type': 'SINGLE', 'page': 0, 'size': paper['totalQustions']});
      DialogUtil.showLoading();
      var MULTI = await HttpUtil.get('/process/online/test/${paper['id']}', params: {'type': 'MULTI', 'page': 0, 'size': paper['totalQustions']});
      DialogUtil.showLoading();
      var TOF = await HttpUtil.get('/process/online/test/${paper['id']}', params: {'type': 'TOF', 'page': 0, 'size': paper['totalQustions']});
      List contents = [];
      if (SINGLE['content'].length > 0) {
        List content = SINGLE['content'];
        contents.add({
          'type': 'SINGLE',
          'content': content,
          'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'SINGLE'}).toList()
        });
      }
      if (MULTI['content'].length > 0) {
        List content = MULTI['content'];
        contents.add({
          'type': 'MULTI',
          'content': content,
          'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'MULTI'}).toList()
        });
      }
      if (TOF['content'].length > 0) {
        List content = TOF['content'];
        contents.add({
          'type': 'TOF',
          'content': content,
          'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'TOF'}).toList()
        });
      }
      PageUtil.push('zaixiankaoshi',
          arguments: {'paper': paper, 'contents': contents, 'title': '在线考试', 'id': item['id'], 'page': PageUtil.currentPage(context)});
    }
  }

  void scan() async {
    var res = await PageUtil.push('qrcode');
    print(res);
    Map params = Filter.jsonDeCode(res);
    String procId = '${params['procId']}';
    PageUtil.push('signOne', arguments: procId);
  }

  jiancha(Map item, String title) async {
    String status = item['status'];
    String taskId = '${item['id']}';
    String procId = '${item['procId']}';
    switch (status) {
      case '待执行':
        {
          await DialogUtil.dialogConfim('是否确定开始本次检查?', title: '检查执行提示');
          PageUtil.push('jianchaForm', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showForm': true});
        }
        break;

      case '未开始':
        {
          PageUtil.push('jianchaDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': false});
        }
        break;
      case '已办结':
        {
          PageUtil.push('jianchaDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': true});
        }
        break;
      case '已超期':
        {
          await DialogUtil.dialogConfim('是否确定开始本次检查?', title: '检查执行提示');
          PageUtil.push('jianchaForm', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showForm': true});
        }
        break;

      default:
        {
          PageUtil.push('jianchaDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': false});
        }
        break;
    }
  }

  homeWork(Map item) {
    String title = Filter.homeWorkToString(item['procTmplName']);
    PageUtil.push('homeworkCheck', arguments: {
      'procId': '${item['procId']}',
      'taskId': '${item['id']}',
      'status': item['status'],
      'title': title,
    });
  }

  yinhuan(Map item, String title) async {
    String status = item['status'];
    String taskId = '${item['id']}';
    String procId = '${item['procId']}';
    switch (status) {
      case '已办结':
        {
          PageUtil.push('yinhuanDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'status': status});
        }
        break;
      case '待整改':
        {
          await DialogUtil.dialogConfim('是否确定开始本次整改?', title: '隐患整改提示');
          PageUtil.push('yinhuanDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'status': status});
        }
        break;

      case '待验收':
        {
          await DialogUtil.dialogConfim('是否确定开始本次验收?', title: '隐患验收提示');
          PageUtil.push('yinhuanDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'status': status});
        }
        break;

      case '已超期':
        {
          PageUtil.push('yinhuanDetail', arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'status': status});
        }
        break;

      default:
        {}
        break;
    }
  }

  safeMetting(Map item) {
    print(item);
    PageUtil.push('safeMeetDetail',
        arguments: {'procId': '${item['taskInfo']['procId']}', 'taskId': '${item['taskInfo']['id']}', 'status': item['taskInfo']['status']});
  }

  xianxia(Map item) {
    PageUtil.push('xianxiaDetail', arguments: item['taskInfo']);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        body: new Container(
          color: Colors.white,
          child: RefreshView(
            scrollView: listView(),
            onRefresh: () => onRefresh(),
            onLoad: () => onLoad(),
            count: _content.length,
            controller: refreshViewController,
          ),
        ));
  }

  Widget listView() {
    return ListView.builder(
      itemCount: _content.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: cellItem(_content[index]),
          onTap: () {
            didSelectRow(_content[index]);
          },
        );
      },
    );
  }

  Widget cellItem(Map item) {
    String title = item['title'];
    String receivedAt = item['receivedAt'];
    String type = item['taskInfo']['type'];
    String procTmplName = item['taskInfo']['procTmplName'];
    String status = item['taskInfo']['status'];
    bool hasRead = item['hasRead'];
    return Container(
      child: Row(
        children: <Widget>[
          ImageView(
              src: 'imgs/message/xiaoxi1.png',
              width: 100 * ScaleWidth,
              height: 100 * ScaleWidth,
              margin: EdgeInsets.only(left: 22 * ScaleWidth, right: 25 * ScaleWidth)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30 * ScaleWidth),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Label(Filter.typeToString(type, procTmplName: procTmplName), fontSize: 34 * ScaleWidth),
                    ),
                    MainTextLabel(status, textColor: Filter.checkColor(status), margin: EdgeInsets.only(right: 25 * ScaleWidth)),
                    Container(
                      width: 10 * ScaleWidth,
                      height: 10 * ScaleWidth,
                      margin: EdgeInsets.only(right: 30 * ScaleWidth),
                      decoration: new BoxDecoration(
                        color: hasRead ? Colors.white : WarningColor,
                        borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                      ),
                    )
                  ],
                ),
              ),
              MainTextLabel(
                title,
                margin: EdgeInsets.only(top: 18 * ScaleWidth, right: 25 * ScaleWidth),
                maxLines: 2,
              ),
              MainTextLabel(
                '开始时间：${Filter.timeHours(receivedAt)}',
                margin: EdgeInsets.only(top: 15 * ScaleWidth, right: 25 * ScaleWidth),
              ),
              LineView(margin: EdgeInsets.only(top: 25 * ScaleWidth))
            ],
          ))
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
        elevation: 1,
        title: const Text(
          '消息',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white);
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
