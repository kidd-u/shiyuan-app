import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class JianChaBiaoZhunCell extends StatefulWidget {
  const JianChaBiaoZhunCell({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new JianChaBiaoZhunCellState();
  }
}

class JianChaBiaoZhunCellState extends State<JianChaBiaoZhunCell> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> views = [];
    for (int i = 0; i < 3; i++) {
      Widget itemCell = Container(
        width: ScreenWidth,
        height: 66 * ScaleWidth,
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            MainTextLabel('16 西   |  肠道微生态中心', margin: EdgeInsets.only(left: 164 * ScaleWidth)),
            i == 0
                ? Container()
                : Positioned(
                    top: 0,
                    left: 126 * ScaleWidth,
                    height: 33 * ScaleWidth,
                    width: 1,
                    child: Container(
                      color: LineColor,
                    ),
                  ),
            i == 2
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 126 * ScaleWidth,
                    height: 33 * ScaleWidth,
                    width: 1,
                    child: Container(
                      color: LineColor,
                    ),
                  ),
            Container(
              width: 20 * ScaleWidth,
              height: 20 * ScaleWidth,
              margin: EdgeInsets.only(left: 117 * ScaleWidth),
              decoration: new BoxDecoration(
                color: SuccessColor,
                borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
              ),
            ),
          ],
        ),
      );
      views.add(itemCell);
    }
    return new Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 40 * ScaleWidth, top: 38 * ScaleWidth),
            child: Row(
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/jihua/building.png',
                  width: 54 * ScaleWidth,
                  height: 44 * ScaleWidth,
                ),
                MainTitleLabel('一号楼', margin: EdgeInsets.only(left: 22 * ScaleWidth)),
              ],
            ),
          ),
          ...views,
          LineView(margin: EdgeInsets.only(top: 7 * ScaleWidth, left: 40 * ScaleWidth, right: 40 * ScaleWidth)),
        ],
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
