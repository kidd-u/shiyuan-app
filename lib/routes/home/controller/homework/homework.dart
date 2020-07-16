import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeWorkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWorkState();
  }
}

class HomeWorkState extends State<HomeWorkPage> {
  List items = [
    {'src': 'imgs/home/homework/donghuozuoye.png', 'title': '动火作业', 'path': 'homeworkList','type':'FIRE_WORK'},
    {'src': 'imgs/home/homework/linshiyongdian.png', 'title': '临时用电', 'path': 'homeworkList','type':'ELECTRIC_WORK'},
    {'src': 'imgs/home/homework/lingxinggongcheng.png', 'title': '零星工程', 'path': 'homeworkList','type':'FRAG_WORK'},
    {'src': 'imgs/home/homework/denggaozuoye.png', 'title': '登高作业', 'path': 'homeworkList','type':'CLIMB_WORK'},
    {'src': 'imgs/home/homework/youxiankongjian.png', 'title': '有限空间', 'path': 'homeworkList','type':'LIMIT_WORK'},
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context, '作业管理'),
      backgroundColor: BackgroundColor,
      body: new StaggeredGridView.countBuilder(
        padding: EdgeInsets.fromLTRB(43 * ScaleWidth, 50 * ScaleWidth, 43 * ScaleWidth, 50 * ScaleWidth),
        crossAxisCount: 3,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return itemCell(items[index]);
        },
        staggeredTileBuilder: (int index) {
          return new StaggeredTile.extent(1, 250 * ScaleWidth);
        },
        mainAxisSpacing: 48 * ScaleWidth,
        crossAxisSpacing: 32 * ScaleWidth,
      ),
    );
  }

  Widget itemCell(Map item) {
    return GestureDetector(
      onTap: (){
        PageUtil.push(item['path'],arguments: item);
      },
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 15.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            ImageView(src: item['src'], width: 108 * ScaleWidth, height: 108 * ScaleWidth, margin: EdgeInsets.only(top: 35 * ScaleWidth)),
            Container(
              width: 158 * ScaleWidth,
              height: 38 * ScaleWidth,
              margin: EdgeInsets.only(top: 40 * ScaleWidth),
              decoration: new BoxDecoration(
                color: Color(0xFF49586B),
                borderRadius: BorderRadius.all(Radius.circular(19 * ScaleWidth)),
              ),
              child: Center(
                child: Label(item['title'], textColor: Colors.white, fontSize: 24 * ScaleWidth),
              ),
            )
          ],
        ),
      ),
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
