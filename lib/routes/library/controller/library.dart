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
    String lastTotal1='${_dangerelimi.safe(['previous','total'])??0}';
    int than1=int.parse(total1) - int.parse(lastTotal1);
    bool isAdd1 = than1>=0;
    String thanStr1=than1.abs().toString();

    String total2='${_dangerelimi.safe(['current','finished'])??'0'}';
    String lastTotal2='${_dangerelimi.safe(['previous','finished'])??'0'}';
    int than2=int.parse(total2) - int.parse(lastTotal2);
    bool isAdd2 = than2>=0;
    String thanStr2=than2.abs().toString();

    String total3='${_dangerelimi.safe(['current','pending'])??'0'}';
    String lastTotal3='${_dangerelimi.safe(['previous','pending'])??'0'}';
    int than3=int.parse(total3) - int.parse(lastTotal3);
    bool isAdd3 = than3>=0;
    String thanStr3=than3.abs().toString();

    String total4='${_dangerelimi.safe(['current','delayed'])??'0'}';
    String lastTotal4='${_dangerelimi.safe(['previous','delayed'])??'0'}';
    int than4=int.parse(total4) - int.parse(lastTotal4);
    bool isAdd4 = than4>=0;
    String thanStr4=than4.abs().toString();

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
          if (index == 2) return new CartView(tag: 0,total: total1,isAdd: isAdd1,add: thanStr1);
          if (index == 3) return new CartView(tag: 1,total: total2,isAdd: isAdd2,add: thanStr2);
          if (index == 4) return new CartView(tag: 2,total: total3,isAdd: isAdd3,add: thanStr3);
          if (index == 5) return new CartView(tag: 3,total: total4,isAdd: isAdd4,add: thanStr4);
          if (index == 6) return new RankingListView(data: _peoples);

          return null;
        },
        staggeredTileBuilder: (int index) {
          if (index == 0 || index == 1 || index == 6) return new StaggeredTile.extent(4, 775 * ScaleWidth);
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
