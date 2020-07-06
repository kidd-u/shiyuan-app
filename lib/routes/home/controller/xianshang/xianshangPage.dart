import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';

class XianShangController {
  XianShangPageState _state;

  void bindState(XianShangPageState state) {
    _state = state;
  }

  void search(String kerword) {
    _state.search(kerword);
  }
}

class XianShangPage extends StatefulWidget {
  const XianShangPage({
    Key key,
    this.type,
    this.status,
    this.controller,
  }) : super(key: key);
  final String type;
  final String status;
  final XianShangController controller;

  @override
  State<StatefulWidget> createState() {
    XianShangPageState state = new XianShangPageState();
    if (controller != null) {
      controller.bindState(state);
    }
    return state;
  }
}

class XianShangPageState extends State<XianShangPage> {
  String _keyword = '';
  List _header = [];
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController refreshViewController = new RefreshViewController();

  void initState() {
    super.initState();
  }

  void search(String kerword) {
    _keyword = kerword;
    refreshViewController.callRefresh();
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
        params: {'type': widget.type, 'status': widget.status, 'keyword': _keyword, 'page': page, 'size': 15, 'sort': 'id'},
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
      refreshViewController.finish(success: true, noMore: _content.length < 15);
    } catch (err) {
      refreshViewController.finish(success: false, noMore: page != 0);
      print(err);
    }
  }

  void didSelectCellForIndex(int index)async {
    String status = _content[index]['status'];
    switch (status) {
      case '未开始':
        {
          PageUtil.push('xianshangDetail', arguments: {'procId': _content[index]['procId'], 'status': _content[index]['status']});
        }
        break;

      case '待执行':
        {
          DialogUtil.showLoading();
          var res=await HttpUtil.get('/process/online/train/'+_content[index]['id']);
          if (res['type'] == 'OC_CLASS') {
            String type=res['material']['type'];
            Map material=res['material'];
            material={...material,'content':_content[index],'page':PageUtil.currentPage(context)};
            print('数据*****');
            LogUtil.d(Filter.toJson(material));
            if (type == 'IMAGE') {
              PageUtil.push('imagejiaoyu',arguments: material);
            }
          }
        }
        break;
      case '已完成':
        {
          PageUtil.push('xianshangpeixun',arguments: _content[index]);
        }
        break;
      case '已超期':
        {
          PageUtil.push('xianshangpeixun',arguments: _content[index]);
        }
        break;

      default:
        {}
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      child: RefreshView(
        scrollView: listView(),
        onRefresh: () => onRefresh(),
        onLoad: () => onLoad(),
        count: _content.length,
        controller: refreshViewController,
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
          Color topColor = Filter.checkShangJiColor(status);
          List<Widget> items = [];
          _header.forEach((element) {
            String text = element['text'];
            String key = element['key'];
            String value = _content[index][key];
            if (key != 'name') {
              items.add(MainTextLabel(text + ': ' + value, margin: EdgeInsets.only(bottom: 16 * ScaleWidth)));
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
