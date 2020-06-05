import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkFenshu extends StatefulWidget {
  const WorkFenshu({Key key, this.title, this.margin, this.color = Colors.white, this.value = '无', this.onChange}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final CallbackAction onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkFenshuState();
  }
}

class WorkFenshuState extends State<WorkFenshu> {
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
                child: MainTitleLabel(
                  widget.title,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                ),
              ),
              MainTextLabel(
                widget.value,
                width: 350 * ScaleWidth,
                textAlign: TextAlign.right,
              ),
              MainTextLabel(
                '(已及格)',
                textColor: SuccessColor,
                fontWeight: FontWeight.w400,
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                textAlign: TextAlign.right,
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
