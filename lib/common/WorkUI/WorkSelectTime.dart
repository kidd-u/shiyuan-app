import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkSelectTime extends StatefulWidget {
  WorkSelectTime({
    Key key,
    this.title,
    this.margin,
    this.color = Colors.white,
    this.value,
    this.placeholder = '请选择时间',
    this.must = false,
    this.enable = true,
    this.onChange,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  String value;
  final String placeholder;
  final bool must;
  final bool enable;
  final Function onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkSelectTimeState();
  }
}

class WorkSelectTimeState extends State<WorkSelectTime> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }
  selectTime()async{
    var time = await DialogUtil.showTimePicker(context,normalTime: widget.value);
    print(time is DateTime);
    setState(() {
      widget.value=Filter.dateToTime(time);
      widget.onChange(widget.value);
    });
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
                    MainTitleLabel(
                      widget.must ? '*' : '',
                      textColor: WarningColor,
                      margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    ),
                    MainTitleLabel(
                      widget.title,
                      width: 295 * ScaleWidth,
                    ),
                  ],
                ),
              ),
              widget.value == null
                  ? MainTextLabel(
                widget.placeholder,
                width: 350 * ScaleWidth,
                margin: EdgeInsets.only(right: 18 * ScaleWidth),
                textAlign: TextAlign.right,
                textColor: Color(0xFFACABAE),
                onClick: () async {
                  selectTime();
                },
              )
                  : MainTextLabel(
                widget.value,
                width: 350 * ScaleWidth,
                margin: EdgeInsets.only(right: 18 * ScaleWidth),
                textAlign: TextAlign.right,
                onClick: () async {
                  selectTime();
                },
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
