import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkEmpty extends StatefulWidget {
  const WorkEmpty({
    Key key,
    this.margin,
    this.color = Colors.white,
    @required this.leftActions,
    @required this.rightActions,
    this.showTopLine = true,
    this.showBottomLine = true,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final List<Widget> leftActions;
  final List<Widget> rightActions;
  final bool showTopLine;
  final bool showBottomLine;

  @override
  State<StatefulWidget> createState() {
    return new WorkEmptyState();
  }
}

class WorkEmptyState extends State<WorkEmpty> {
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
    return Container(
      margin: widget.margin,
      color: widget.color,
      child: Column(
        children: <Widget>[
          ...topViews,
          new Container(
            height: 88 * ScaleWidth,
            padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[...widget.leftActions],
                  ),
                ),
                ...widget.rightActions,
              ],
            ),
          ),
          ...bottomViews,
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
