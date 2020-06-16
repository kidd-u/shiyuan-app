import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/TabBarPageView.dart';
import './testFilePage.dart';

class TestFileList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TestFileListState();
  }
}

class TestFileListState extends State<TestFileList> {
  //定义Tab标签
  var tabTexts = ["所有数据", "待执行", "已完成"];

  //定义ab标签对应的Page
  var pages = [
    TestFilePage(
      title: '1',
    ),
    TestFilePage(
      title: '2',
    ),
    TestFilePage(
      title: '3',
    ),
  ];

  void initState() {
    super.initState();
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
                            print(text);
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
                    print("onTabChanged-->index:$index");
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
