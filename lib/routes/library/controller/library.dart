import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../view/online.dart';
import '../view/offline.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LibraryState();
  }
}
GlobalKey<OnLineViewState> onlineKey = GlobalKey(debugLabel: 'online');
class LibraryState extends State<LibraryPage> {
  var _scrollController = new ScrollController(initialScrollOffset: 0);

  Widget _online = new OnLineView(key: onlineKey,title: '线上',);
  Widget _offline = new OffLineView(title: '线下',);

  void initState() {
    super.initState();
//    onlineKey.currentState.getTitle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Color.fromRGBO(116, 143, 254, 1),
        body: new StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(25 * ScaleWidth),
          crossAxisCount: 4,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            if(index == 0){
              return _online;
            }
            return new Container(
                color: Colors.green,
                child: new Center(
                  child: new CircleAvatar(
                    backgroundColor: Colors.white,
                    child: new Text('$index'),
                  ),
                ));
          },

          staggeredTileBuilder: (int index) {
            if (index == 0) {
              return new StaggeredTile.extent(4, 150);
            }
            return new StaggeredTile.count(2, index.isEven ? 2 : 1);
          },
          mainAxisSpacing: 29 * ScaleWidth,
          crossAxisSpacing: 29 * ScaleWidth,
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        '数据统计',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      flexibleSpace: Container(
        color: Color.fromRGBO(116, 143, 254, 1),
      ),
    );
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }
}
