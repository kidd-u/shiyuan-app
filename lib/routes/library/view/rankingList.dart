import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class RankingListView extends StatefulWidget {
  const RankingListView({
    Key key,
    this.data,
  }) : super(key: key);
  final List data;

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
                itemCount: widget.data.length,
                itemExtent: 73 * ScaleWidth,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
//                    color: index.isEven ? Colors.yellow : Colors.cyanAccent,
                    child: Row(
                      children: <Widget>[
                        MainTextLabel('${index + 1}', fontWeight: FontWeight.bold, width: 40 * ScaleWidth, margin: EdgeInsets.only(left: 52 * ScaleWidth)),
                        MainTextLabel('${widget.data[index]['name']}', width: 226 * ScaleWidth, margin: EdgeInsets.only(left: 33 * ScaleWidth)),
                        MainTextLabel('${widget.data[index]['depart']}', width: 228 * ScaleWidth),
                        MainTextLabel('${widget.data[index]['amount']}条'),
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
