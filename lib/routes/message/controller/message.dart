import 'package:flutter/material.dart';
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
  Widget listView(){
    return ListView.builder(
      itemCount: _content.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: cellItem(_content[index]),
          onTap: (){},
        );
      },
    );
  }
  Widget cellItem(Map item){
    String title=item['title'];
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
                          child: Label('安全培训', fontSize: 34 * ScaleWidth),
                        ),
                        SubTextLabel('12:21', margin: EdgeInsets.only(right: 25 * ScaleWidth))
                      ],
                    ),
                  ),
                  MainTextLabel(
                    '2020年全体员工消防教育',
                    margin: EdgeInsets.only(top: 18 * ScaleWidth, right: 25 * ScaleWidth),
                  ),
                  MainTextLabel(
                    '2020年全体员工消防教育',
                    margin: EdgeInsets.only(top: 15 * ScaleWidth, right: 25 * ScaleWidth),
                  ),
                  MainTextLabel(
                    '开始时间：2020/3/9 9:00',
                    margin: EdgeInsets.only(top: 15 * ScaleWidth, right: 25 * ScaleWidth),
                  ),
                  LineView(margin: EdgeInsets.only(top: 25*ScaleWidth))
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
