import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkNormal extends StatefulWidget {
  const WorkNormal({Key key, this.title, this.margin, this.color = Colors.white,@required this.children}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final List<Widget> children;

  @override
  State<StatefulWidget> createState() {
    return new WorkNormalState();
  }
}

class WorkNormalState extends State<WorkNormal> {
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
        LineView(),
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
              ...widget.children,
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
