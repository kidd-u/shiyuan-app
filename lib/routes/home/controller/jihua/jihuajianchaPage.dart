import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class JiHuaPage extends StatefulWidget {
  JiHuaPage({Key key, @required this.type, @required this.status}) : super(key: key);
  String type;
  String status;

  @override
  State<StatefulWidget> createState() {
    return new JiHuaPageState();
  }
}

class JiHuaPageState extends State<JiHuaPage> {
  List _header = [];
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController controller = new RefreshViewController();

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return layout(context);
  }

  void onRefresh() async {
    _pageIndex = 0;
    _header = [];
    _content = [];
    loadDataByPage(_pageIndex);
  }

  void onLoad() async {
    loadDataByPage(_pageIndex + 1);
  }

  void loadDataByPage(int page) async {
    try {
      var res = await HttpUtil.get(
        '/process/common/task/summary',
        params: {'type': widget.type, 'status': widget.status, 'page': page, 'size': 15},
      );
      List header = res['header'];
      List content = res['page']['content'];
      setState(() {
        _header = header;
        _content = [..._content, ...content];
        if (content.length > 0) {
          _pageIndex = page;
        }
      });
      controller.finish(success: true, noMore: _content.length < 15);
    } catch (err) {
      controller.finish(success: false, noMore: page != 0);
      print(err);
    }
  }

  didSelectCellForIndex(int index) async {
    String title = _content[index]['name'];
    String status = _content[index]['status'];
    String taskId = '${_content[index]['id']}';
    String procId = '${_content[index]['procId']}';
    switch (status) {
      case '待执行':
        {
          await DialogUtil.dialogConfim('是否确定开始本次检查?', title: '检查执行提示');
          bool res = await PageUtil.push('jianchaForm',
              arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showForm': true});
          if (res == true) {
            controller.callRefresh();
          }
        }
        break;

      case '未开始':
        {
          await PageUtil.push('jianchaDetail',
              arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': false});
        }
        break;
      case '已办结':
        {
          await PageUtil.push('jianchaDetail',
              arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': true});
        }
        break;
      case '已超期':
        {
          await DialogUtil.dialogConfim('是否确定开始本次检查?', title: '检查执行提示');
          bool res = await PageUtil.push('jianchaForm',
              arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showForm': true});
          if (res == true) {
            controller.callRefresh();
          }
        }
        break;

      default:
        {
          await PageUtil.push('jianchaDetail',
              arguments: {'title': title, 'status': status, 'procId': procId, 'taskId': taskId, 'showHistory': false});
        }
        break;
    }
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      height: ScreenHeight - DefaultUtil.navHeight - 80 * ScaleWidth,
      child: RefreshView(
        scrollView: listView(),
        onRefresh: () => onRefresh(),
        onLoad: () => onLoad(),
        count: _content.length,
        controller: controller,
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        itemCount: _content.length,
//        itemExtent: 323 * ScaleWidth,
        itemBuilder: (BuildContext context, int index) {
          //==========刷新数据==========
          String title = _content[index]['name'];
          String status = _content[index]['status'];
          Color topColor = Filter.checkColor(status);
          List<Widget> items = [];
          _header.forEach((element) {
            String text = element['text'];
            String key = element['key'];
            String value = _content[index][key];
            if (key != 'name') {
              items.add(MainTextLabel('${text}: ${value}', margin: EdgeInsets.only(bottom: 16 * ScaleWidth)));
            }
          });

          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 32 * ScaleWidth),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      width: 690 * ScaleWidth,
//                      height: 291 * ScaleWidth,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: topColor,
                            height: 92 * ScaleWidth,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: MainTitleLabel(
                                    title,
                                    textColor: Colors.white,
                                    margin: EdgeInsets.only(left: 36 * ScaleWidth, right: 15 * ScaleWidth),
                                  ),
                                ),
                                SubTextLabel(
                                  status,
                                  textColor: Colors.white,
                                  margin: EdgeInsets.only(right: 32 * ScaleWidth),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 690 * ScaleWidth,
                            padding: EdgeInsets.only(top: 26 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth, bottom: 10 * ScaleWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ...items,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              didSelectCellForIndex(index);
            },
          );
          return null;
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }
}
