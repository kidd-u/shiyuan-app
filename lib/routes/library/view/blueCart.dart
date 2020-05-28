import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class BlueCartView extends StatefulWidget {
  const BlueCartView({Key key, this.title, this.margin,this.width}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final double width;

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
        Label('490', textColor: Colors.white, fontSize: 48 * ScaleWidth, fontWeight: FontWeight.bold, margin: EdgeInsets.only(top: 37 * ScaleWidth)),
        Container(
          margin: EdgeInsets.only(top: 32 * ScaleWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Label('同比上月', textColor: Colors.white, fontSize: 22 * ScaleWidth),
              ImageView(src: 'imgs/library/UP.png', width: 13 * ScaleWidth, height: 17 * ScaleWidth),
              Label('26%', textColor: Colors.white, fontSize: 22 * ScaleWidth)
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
