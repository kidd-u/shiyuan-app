import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class JiHuaPage extends StatefulWidget {
  const JiHuaPage({Key key, this.type}) : super(key: key);
  final String type;

  @override
  State<StatefulWidget> createState() {
    return new JiHuaPageState();
  }
}

class JiHuaPageState extends State<JiHuaPage> {
  List dataArray = [];
  RefreshViewController controller = new RefreshViewController();

  @override
  void initState() {
    print('initState');
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((callback){
      controller.callRefresh();
      print("addPostFrameCallback be invoke");
    });

  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return layout(context);
  }

  void onRefresh() async {
    try{
      var res = await HttpUtil.get('/process/common/task/summary',params: {'type':'TEMP_CHECK'});
      controller.finishRefresh(success: true,noMore: false);
    }catch(err){
      controller.finishRefresh(success: false,noMore: true);
    }
  }

  void onLoad() async {}

  Widget layout(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      child: RefreshView(
        scrollView: listView(),
        onRefresh: () => onRefresh(),
        onLoad: () => onLoad(),
        count: dataArray.length,
        controller: controller,
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        itemCount: dataArray.length,
        itemExtent: 323 * ScaleWidth,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 32 * ScaleWidth),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Container(
                      width: 690 * ScaleWidth,
                      height: 291 * ScaleWidth,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: NormalColor,
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
              PageUtil.push('jianchaDetail');
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
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }
}
