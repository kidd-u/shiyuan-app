import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class BlueCartView extends StatefulWidget {
  const BlueCartView({
    Key key,
    this.title,
    this.margin,
    this.width,
    this.total = '0',
    this.isAdd = false,
    this.add = '0',
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final double width;
  final String total;
  final bool isAdd;
  final String add;

  @override
  State<StatefulWidget> createState() {
    return new BlueCartViewState();
  }
}

class BlueCartViewState extends State<BlueCartView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      margin: widget.margin,
      width: widget.width,
      height: 210 * ScaleWidth,
      decoration: new BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF3280E9), Color(0xFF254DC2)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth))),
      child: Column(children: <Widget>[
        Label(widget.title,
            textColor: Colors.white, fontSize: 22 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 25 * ScaleWidth)),
        Label(widget.total, textColor: Colors.white, fontSize: 48 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 25 * ScaleWidth)),
        Container(
          margin: EdgeInsets.only(top: 30 * ScaleWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Label('同比上月', textColor: Colors.white, fontSize: 22 * ScaleWidth),
              ImageView(src: widget.isAdd?'imgs/library/UP.png':'imgs/library/down.png', width: 13 * ScaleWidth, height: 17 * ScaleWidth),
              Label(widget.add, textColor: Colors.white, fontSize: 22 * ScaleWidth)
            ],
          ),
        )
      ]),
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
