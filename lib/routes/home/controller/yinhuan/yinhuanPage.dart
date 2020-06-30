import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class YinHuanPage extends StatefulWidget {
  const YinHuanPage({
    Key key,
    @required this.type,
    @required this.status,
  }) : super(key: key);
  final String type;
  final String status;

  @override
  State<StatefulWidget> createState() {
    return new YinHuanPageState();
  }
}

class YinHuanPageState extends State<YinHuanPage> {
  List _header = [];
  List _content = [];
  int _pageIndex = 0;
  RefreshViewController controller = new RefreshViewController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        params: {'type': widget.type, 'status': widget.status, 'page': page, 'size': 15, 'sort': 'id'},
      );
      List header = res['header'];
      List content = res['page']['content'];
      setState(() {
        _header = header;
        _content = [..._content, ...content];
        _pageIndex = page;
      });
      controller.finish(success: true, noMore: _content.length < 15);
    } catch (err) {
      controller.finish(success: false, noMore: page != 0);
      print(err);
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
        controller: controller,
      ),
    );
  }
  Widget listView(){
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        itemCount: 9,
        itemExtent: 323 * ScaleWidth,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 32 * ScaleWidth),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                    child: Container(
                      width: 690 * ScaleWidth,
                      height: 291 * ScaleWidth,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: SuccessColor,
                            height: 92 * ScaleWidth,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: MainTitleLabel(
                                    '2020年冬季防火专项培训',
                                    textColor: Colors.white,
                                    margin: EdgeInsets.only(left: 36 * ScaleWidth),
                                  ),
                                ),
                                SubTextLabel(
                                  '已完成',
                                  textColor: Colors.white,
                                  margin: EdgeInsets.only(right: 32 * ScaleWidth),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: 690 * ScaleWidth,
                              padding: EdgeInsets.only(top: 26 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MainTextLabel('结束时间：2020-03-12'),
                                  MainTextLabel(
                                    '培训类别：年度教育',
                                    margin: EdgeInsets.only(top: 16 * ScaleWidth),
                                  ),
                                  MainTextLabel(
                                    '培训对象：全体员工',
                                    margin: EdgeInsets.only(top: 16 * ScaleWidth),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              PageUtil.push('yinhuanDetail');
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
