import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class RankingListView extends StatefulWidget {
  const RankingListView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new RankingListViewState();
  }
}

class RankingListViewState extends State<RankingListView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MainTextLabel(
                '隐患发起排名',
                fontWeight: FontWeight.bold,
                margin: EdgeInsets.only(left: 43 * ScaleWidth, top: 29 * ScaleWidth),
              )
            ],
          ),
          Container(
            height: 11 * ScaleWidth,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 9,
                itemExtent: 73 * ScaleWidth,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
//                    color: index.isEven ? Colors.yellow : Colors.cyanAccent,
                    child: Row(
                      children: <Widget>[
                        MainTextLabel('$index', fontWeight: FontWeight.bold, width: 20 * ScaleWidth, margin: EdgeInsets.only(left: 52 * ScaleWidth)),
                        MainTextLabel('赵依依', width: 226 * ScaleWidth, margin: EdgeInsets.only(left: 33 * ScaleWidth)),
                        MainTextLabel('保卫科', width: 228 * ScaleWidth),
                        MainTextLabel('40条'),
                      ],
                    ),
                  );
                }),
          )
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
