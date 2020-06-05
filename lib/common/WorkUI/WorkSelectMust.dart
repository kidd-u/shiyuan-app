import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkSelectMust extends StatefulWidget {
  const WorkSelectMust({Key key, this.title, this.margin, this.color = Colors.white, this.value = '无', this.onChange}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final CallbackAction onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkSelectMustState();
  }
}

class WorkSelectMustState extends State<WorkSelectMust> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          margin: widget.margin,
          color: widget.color,
          height: 88 * ScaleWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Row(
                children: <Widget>[
                  Label(
                    '*',
                    textColor: ErrorColor,
                    fontSize: 30 * ScaleWidth,
                    margin: EdgeInsets.only(left: 15 * ScaleWidth),
                  ),
                  MainTitleLabel(
                    widget.title,
                  ),
                ],
              )),
              MainTextLabel(
                widget.value,
                width: 380 * ScaleWidth,
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                textAlign: TextAlign.right,
              )
            ],
          ),
        ),
        LineView(),
      ],
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
