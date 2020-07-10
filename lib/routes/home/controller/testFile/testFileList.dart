import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';

enum TestFileType {
  done, //已完成
  loading, //进行中
  wait, //超期未考
}

class TestFileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestFileListState();
  }
}

class TestFileListState extends State<TestFileList> {
  String _keyword = '';
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
    _content = [];
    loadDataByPage(_pageIndex);
  }

  void onLoad() async {
    loadDataByPage(_pageIndex + 1);
  }

  void loadDataByPage(int page) async {
    try {
      var res = await HttpUtil.get('/process/test/data', params: {'keyword': _keyword, 'page': page, 'size': 15});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, '考试档案'),
        body: Column(
          children: <Widget>[
            Container(
              height: 88 * ScaleWidth,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 528 * ScaleWidth,
                    height: 50 * ScaleWidth,
                    margin: EdgeInsets.only(left: 50 * ScaleWidth),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25 * ScaleWidth)),
                      border: new Border.all(width: 1, color: Color(0xFFD6D6D6)),
                    ),
                    child: Row(
                      children: <Widget>[
                        ImageView(
                          src: 'imgs/icon/search.png',
                          width: 30 * ScaleWidth,
                          height: 30 * ScaleWidth,
                          margin: EdgeInsets.only(left: 17 * ScaleWidth),
                        ),
                        InputView(
//                          height: 30 * ScaleWidth,
                          width: 450 * ScaleWidth,
                          margin: EdgeInsets.only(left: 14 * ScaleWidth),
                          placeholder: '请输入关键词搜索',
                          contentPadding: EdgeInsets.only(bottom: 10),
                          onChanged: (text) {
                            _keyword = text;
                          },
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    '搜索',
                    width: 86 * ScaleWidth,
                    height: 50 * ScaleWidth,
                    textColor: Colors.white,
                    fontSize: 24 * ScaleWidth,
                    margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    //边框设置
                    decoration: new BoxDecoration(
                      color: MainDarkBlueColor,
                      borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                    ),
                    onPressed: () {
                      refreshViewController.callRefresh();
                    },
                  )
                ],
              ),
            ),
            LineView(),
            Expanded(
              child: RefreshView(
                scrollView: listView(),
                onRefresh: () => onRefresh(),
                onLoad: () => onLoad(),
                count: _content.length,
                controller: refreshViewController,
              ),
            ),
          ],
        ));
  }

  Widget listView() {
    return ListView.builder(
      padding: EdgeInsets.all(30 * ScaleWidth),
      itemCount: _content.length,
      itemBuilder: (BuildContext context, int index) {
        return itemCell(_content[index]);
      },
    );
  }

  Widget itemCell(Map item) {
    String name = item['name'];
    List<Widget> views = [
      MainTextLabel('截止时间：${Filter.time(item['finishedAt'])}', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(bottom: 16 * ScaleWidth)),
      MainTextLabel('培训对象：${item['departName']}', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(bottom: 16 * ScaleWidth)),
      MainTextLabel('培训员工：${item['accountName']}', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(bottom: 16 * ScaleWidth)),
      MainTextLabel('考试分数：${item['score']}', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(bottom: 16 * ScaleWidth)),
    ];

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * ScaleWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
          child: Container(
            width: 690 * ScaleWidth,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  color: SuccessColor,
                  height: 92 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(name, textColor: Colors.white, margin: EdgeInsets.only(left: 36 * ScaleWidth)),
                      ),
                      SubTextLabel('已完成', textColor: Colors.white, margin: EdgeInsets.only(right: 32 * ScaleWidth)),
                    ],
                  ),
                ),
                Container(
                  width: 690 * ScaleWidth,
                  padding: EdgeInsets.only(top: 26 * ScaleWidth, bottom: 30 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...views,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        PageUtil.push('testFileDetail', arguments: item);
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
