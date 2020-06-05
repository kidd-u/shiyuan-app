import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTitle extends StatefulWidget {
  const WorkTitle({Key key, this.title, this.margin, this.color = Colors.white, this.value = '无', this.onChange}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final Function onChange;

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
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                ),
              ),
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
