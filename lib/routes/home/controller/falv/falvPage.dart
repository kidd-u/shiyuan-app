import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class FaLvController {
  FaLvPageState _state;

  void bindState(FaLvPageState state) {
    _state = state;
  }

  void search(String kerword) {
    _state.search(kerword);
  }
}

class FaLvPage extends StatefulWidget {
  const FaLvPage({
    Key key,
    this.title,
    this.controller,
  }) : super(key: key);
  final String title;
  final FaLvController controller;

  @override
  State<StatefulWidget> createState() {
    FaLvPageState state = new FaLvPageState();
    if (controller != null) {
      controller.bindState(state);
    }
    return state;
  }
}

class FaLvPageState extends State<FaLvPage> {
  String _keyword = '';
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

  void search(String kerword) {
    _keyword = kerword;
    refreshViewController.callRefresh();
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
      var res = await HttpUtil.get(
        '/law/summary',
        params: {'status': widget.title, 'keyword': _keyword, 'page': page, 'size': 15, 'sort': 'id'},
      );
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

  didSelectCellForIndex(Map item) async {
    String url = item['attachment']['src'];
    if (Platform.isIOS) {
      PageUtil.push('WebView', arguments: url);
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
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
        padding: EdgeInsets.all(30 * ScaleWidth),
        itemCount: _content.length,
        itemBuilder: (BuildContext context, int index) {
          return itemCell(_content[index]);
        });
  }

  Widget itemCell(Map item) {
    String name = item['name'];
    String time = item['startDate'];
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 32 * ScaleWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainTitleLabel(name,
                  maxLines: 2, margin: EdgeInsets.only(top: 30 * ScaleWidth, bottom: 15 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth)),
              LineView(margin: EdgeInsets.only(left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
              MainTextLabel('上传时间：' + time,
                  textColor: Color(0xFF7D7D7D),
                  margin: EdgeInsets.only(top: 18 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth, bottom: 30 * ScaleWidth)),
            ],
          ),
        ),
      ),
      onTap: () {
        didSelectCellForIndex(item);
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
