import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class JiHuaCell extends StatefulWidget {
  const JiHuaCell({Key key, this.title, this.type}) : super(key: key);
  final String title;
  final int type;

  @override
  State<StatefulWidget> createState() {
    return new JiHuaCellState();
  }
}

class JiHuaCellState extends State<JiHuaCell> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 46 * ScaleWidth, right: 47 * ScaleWidth),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 56 * ScaleWidth,
            bottom: 0,
            width: 8 * ScaleWidth,
            child: Container(
              color: widget.type == 1 ? SuccessColor : widget.type == 2 ? WarningColor : LoadingColor,
            ),
          ),
          MainTextLabel(
            widget.title,
            maxLines: 9999,
            margin: EdgeInsets.only(left: 78 * ScaleWidth),
          ),
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
