import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTitle extends StatefulWidget {
  const WorkTitle({
    Key key,
    @required this.title,
    this.margin,
    this.color = Colors.white,
    this.value = '无',
    this.onChange,
    this.showTopLine = true,
    this.showBottomLine = true,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final Function onChange;
  final bool showTopLine;
  final bool showBottomLine;
  final FontWeight fontWeight;

  @override
  State<StatefulWidget> createState() {
    return new WorkTitleState();
  }
}

class WorkTitleState extends State<WorkTitle> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> topViews = [];
    List<Widget> bottomViews = [];
    if (widget.showTopLine) {
      topViews.add(LineView());
    }
    if (widget.showBottomLine) {
      bottomViews.add(LineView());
    }

    return Column(
      children: <Widget>[
        ...topViews,
        new Container(
          margin: widget.margin,
          color: widget.color,
          height: 88 * ScaleWidth,
          child: Row(
            children: <Widget>[
              Expanded(
                child: MainTitleLabel(
                  widget.title,
                  fontWeight: widget.fontWeight,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                ),
              ),
            ],
          ),
        ),
        ...bottomViews,
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
