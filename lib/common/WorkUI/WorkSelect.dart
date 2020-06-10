import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkSelect extends StatefulWidget {
  const WorkSelect({
    Key key,
    this.title,
    this.margin,
    this.color = Colors.white,
    this.value = '无',
    this.onChange,
    this.showBottomLine = true,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final CallbackAction onChange;
  final bool showBottomLine;

  @override
  State<StatefulWidget> createState() {
    return new WorkSelectState();
  }
}

class WorkSelectState extends State<WorkSelect> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> views = [];
    if (widget.showBottomLine) {
      views.add(LineView());
    }
    return Column(
      children: <Widget>[
        new Container(
          margin: widget.margin,
          color: widget.color,
          height: 88 * ScaleWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                child: MainTitleLabel(
                  widget.title,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                ),
              ),
              MainTextLabel(
                widget.value,
                width: 380 * ScaleWidth,
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                textAlign: TextAlign.right,
              )
            ],
          ),
        ),
        ...views,
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
