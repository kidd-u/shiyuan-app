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

class LibraryState extends State<LibraryPage> {
  var _scrollController = new ScrollController(initialScrollOffset: 0);
  Map _onlineData={};
  Map _offlineData={};
  Map _dangerelimi={};
  List _peoples=[];

  void initState() {
    super.initState();
    print('initState');
    getOnLine();
    getOffLine();
    getDangerelimi();
    getPeople();
  }
  getOnLine()async{
    var yue=DateTime.now().month;
    var res = await HttpUtil.get('/statistics/online/month',params: {'month':yue});
    setState(() {
      _onlineData=res;
    });
  }
  getOffLine()async{
    var yue=DateTime.now().month;
    var res = await HttpUtil.get('/statistics/offline/month',params: {'month':yue});
    setState(() {
      _offlineData=res;
    });
  }
  getDangerelimi()async{
    var yue=DateTime.now().month;
    var res = await HttpUtil.get('/statistics/dangerelimi/month',params: {'month':yue});
    setState(() {
      _dangerelimi=res;
    });
  }
  getPeople()async{
    var res = await HttpUtil.get('/statistics/dangerelimi/rank');
    setState(() {
      _peoples=res['content'];
    });
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
    String total1='${_dangerelimi.safe(['current','total'])??0}';

    String total2='${_dangerelimi.safe(['current','finished'])??'0'}';

    String total3='${_dangerelimi.safe(['current','pending'])??'0'}';

    String total4='${_dangerelimi.safe(['current','delayed'])??'0'}';

    return new Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color.fromRGBO(116, 143, 254, 1),
      body: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(25 * ScaleWidth),
        crossAxisCount: 4,
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) return new OnLineView(data: _onlineData);
          if (index == 1) return new OffLineView(data: _offlineData,);
          if (index == 2) return new CartView(tag: 0,total: total1);
          if (index == 3) return new CartView(tag: 1,total: total2);
          if (index == 4) return new CartView(tag: 2,total: total3);
          if (index == 5) return new CartView(tag: 3,total: total4);
          if (index == 6) return new RankingListView(data: _peoples);

          return null;
        },
        staggeredTileBuilder: (int index) {
          if (index == 0 || index == 1) return new StaggeredTile.extent(4, 735 * ScaleWidth);
          if (index == 6) return new StaggeredTile.extent(4, 775 * ScaleWidth);
          return new StaggeredTile.extent(2, 368 * ScaleWidth);
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
      brightness: Brightness.light,
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
