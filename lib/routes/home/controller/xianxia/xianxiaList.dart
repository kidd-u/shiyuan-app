import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './xianxiaPage.dart';

class XianXiaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new XianXiaListState();
  }
}

class XianXiaListState extends State<XianXiaList> {
  //定义Tab标签
  var tabTexts = ["所有数据", "待执行","待审核", "已办结"];

  List<XianXiaController> controllers = [
    XianXiaController(),
    XianXiaController(),
    XianXiaController(),
    XianXiaController(),
  ];
  List<XianXiaPage> pages;

  String _keyword = '';
  int _index = 0;

  void initState() {
    super.initState();
    pages = [
      XianXiaPage(type: 'OFFLINE_CLASS', status: '', controller: controllers[0]),
      XianXiaPage(type: 'OFFLINE_CLASS', status: '待执行', controller: controllers[1]),
      XianXiaPage(type: 'OFFLINE_CLASS', status: '待审核', controller: controllers[2]),
      XianXiaPage(type: 'OFFLINE_CLASS', status: '已办结', controller: controllers[3]),
    ];
  }
  void scan()async{
    var res = await PageUtil.push('qrcode');
    print(res);
    Map params = Filter.jsonDeCode(res);
    String procId = params['procId'].toString();
    bool refresh = await PageUtil.push('signOne', arguments: procId);
    if (refresh == true) {
      controllers[_index].search(_keyword);
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget rightBtn = Button(
      child: ImageView(
        src: 'imgs/home/xianxia/scan.png',
        width: 42 * ScaleWidth,
        height: 42 * ScaleWidth,
      ),
      onPressed: () async {
        scan();
      },
    );
    return Scaffold(
        appBar: buildAppBar(context, '线下培训', actions: [rightBtn]),
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
                  TextBtn(
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
                      controllers[_index].search(_keyword);
                    },
                  )
                ],
              ),
            ),
            LineView(),
            Expanded(
              child: TabBarPageView(
                  tabTexts: tabTexts,
                  pages: pages,
                  onTabChanged: (index) {
                    _index = index;
                  }),
            )
          ],
        ));
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
