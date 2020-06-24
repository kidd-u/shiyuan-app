import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkChoose extends StatefulWidget {
  WorkChoose({
    Key key,
    this.title = '',
    this.margin,
    this.color = Colors.white,
    this.value,
    this.placeholder = '请选择',
    this.showBottomLine = true,
    this.must = false,
    this.enable = true,
    this.onChange,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  String value;
  final String placeholder;
  final bool showBottomLine;
  final bool must;
  final bool enable;
  final Function onChange;

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
                        var res = await PageUtil.push('WorkChooseStore');
                        setState(() {
                          widget.value = res;
                        });
                        widget.onChange(res);
                      },
                    )
                  : MainTextLabel(
                      widget.value,
                      width: 350 * ScaleWidth,
                      margin: EdgeInsets.only(right: 18 * ScaleWidth),
                      textAlign: TextAlign.right,
                      onClick: () async {
                        var res = await PageUtil.push('WorkChooseStore',arguments: widget.value);
                        setState(() {
                          widget.value = res;
                        });
                        widget.onChange(res);
                      },
                    ),
              rightChoose(),
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
