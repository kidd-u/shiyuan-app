import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class HomeWorkPage extends StatefulWidget {
  const HomeWorkPage({
    Key key,
    this.type,
    this.status,
  }) : super(key: key);
  final String type;
  final String status;

  @override
  State<StatefulWidget> createState() {
    return new HomeWorkPageState();
  }
}

class HomeWorkPageState extends State<HomeWorkPage> {
  List _header = [];
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController refreshViewController = new RefreshViewController();

  void initState() {
    super.initState();
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
        params: {'type': widget.type, 'status': widget.status, 'page': page, 'size': 15, 'sort': 'id'},
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

  void didSelectCellForIndex(int index) {
//    PageUtil.push('xianxiaDetail',arguments: {'procId':_content[index]['procId'],'status':_content[index]['status']});
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
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: itemCell(_content[index]),
            onTap: () async {
              bool res = await PageUtil.push('homeworkCheck', arguments: {'procId': _content[index]['procId'], 'taskId': _content[index]['id'],'status':_content[index]['status']});
              if (res == true) {
                refreshViewController.callRefresh();
              }
            },
          );
          return null;
        });
  }

  Widget itemCell(Map item) {
    String title = item['target'];
    String status = item['status'];
    Color topColor = Filter.checkShangJiColor(status);
    List<Widget> items = [];
    _header.forEach((element) {
      String text = element['text'];
      String key = element['key'];
      String value = item[key];
      if (key != 'target') {
        items.add(MainTextLabel(text + ': ' + value, margin: EdgeInsets.only(bottom: 16 * ScaleWidth)));
      }
    });
    return Container(
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
    );
  }

//  Container(
//  height: 77 * ScaleWidth,
//  padding: EdgeInsets.only(right: 17 * ScaleWidth),
//  child: Row(
//  mainAxisAlignment: MainAxisAlignment.end,
//  children: <Widget>[
//  textBtn('待审核'),
//  textBtn('监管中', color: LoadingColor),
//  textBtn('作业结束'),
//  ],
//  ),
//  ),
  Widget textBtn(String text, {Color color = Colors.white, String path, double width}) {
    return TextButton(
      text,
      margin: EdgeInsets.only(left: 10 * ScaleWidth),
      width: width == null ? 132 * ScaleWidth : width,
      height: 50 * ScaleWidth,
      textColor: color == Colors.white ? Color(0xFFC2C2C2) : Colors.white,
      decoration: color == Colors.white
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
              border: new Border.all(width: 1, color: Color(0xFFC2C2C2)),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
            ),
      onPressed: () {
        PageUtil.push('homeworkCheck');
      },
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
