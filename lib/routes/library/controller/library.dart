import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../view/online.dart';
import '../view/offline.dart';
import '../view/cart.dart';
import '../view/rankingList.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LibraryState();
  }
}

GlobalKey<OnLineViewState> onlineKey = GlobalKey(debugLabel: 'online');

class LibraryState extends State<LibraryPage> {
  var _scrollController = new ScrollController(initialScrollOffset: 0);

  Widget _online = new OnLineView(
    key: onlineKey,
    title: '线上',
  );
  Widget _offline = new OffLineView(
    title: '线下',
  );
  Widget _cartZongshu = new CartView(
    tag: 0,
  ); //本月隐患总数
  Widget _cartYiZhenggai = new CartView(
    tag: 1,
  ); //已整改
  Widget _cartDaiZhenggai = new CartView(
    tag: 2,
  ); //待整改
  Widget _cartWeiZXhenggai = new CartView(
    tag: 3,
  ); //超期未整改
  Widget _cartZhenggaiLv = new CartView(
    tag: 4,
  ); //隐患整改率
  Widget _list = new RankingListView(); //排名

  void initState() {
    super.initState();
    print('initState');
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
          if (index == 0) return _online;
          if (index == 1) return _offline;
          if (index == 2) return _cartZongshu;
          if (index == 3) return _cartYiZhenggai;
          if (index == 4) return _cartDaiZhenggai;
          if (index == 5) return _cartWeiZXhenggai;
          if (index == 6) return _cartZhenggaiLv;
          if (index == 7) return _list;

          return null;
        },
        staggeredTileBuilder: (int index) {
          if (index == 0 || index == 1 || index == 7) return new StaggeredTile.extent(4, 775 * ScaleWidth);
          return new StaggeredTile.extent(2, 408 * ScaleWidth);
        },
        mainAxisSpacing: 29 * ScaleWidth,
        crossAxisSpacing: 29 * ScaleWidth,
      ),
    );
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
