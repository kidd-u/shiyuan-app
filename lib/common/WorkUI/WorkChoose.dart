import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkChoose extends StatefulWidget {
  const WorkChoose({Key key, this.title, this.margin, this.color = Colors.white, this.value, this.placeholder = '请选择', this.onChange}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final String placeholder;
  final CallbackAction onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkChooseState();
  }
}

class WorkChooseState extends State<WorkChoose> {
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
              widget.value == null
                  ? MainTextLabel(
                      widget.placeholder,
                      width: 380 * ScaleWidth,
                      margin: EdgeInsets.only(right: 18 * ScaleWidth),
                      textAlign: TextAlign.right,
                      textColor: Color(0xFFACABAE),
                    )
                  : MainTextLabel(
                      widget.value,
                      width: 380 * ScaleWidth,
                      margin: EdgeInsets.only(right: 18 * ScaleWidth),
                      textAlign: TextAlign.right,
                    ),
              rightChoose(),
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
