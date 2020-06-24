import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkInput extends StatefulWidget {
  const WorkInput({
    Key key,
    this.title,
    this.must = false,
    this.enable = true,
    this.margin,
    this.color = Colors.white,
    this.value,
    this.placehoder = '请输入',
    this.onChange,
  }) : super(key: key);
  final String title;
  final bool must;
  final bool enable;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final String placehoder;
  final Function onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkInputState();
  }
}

class WorkInputState extends State<WorkInput> {
  TextEditingController controller = TextEditingController();

  void initState() {
    super.initState();
    controller.text = widget.value;
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
                    MainTitleLabel(
                      widget.must ? '*' : '',
                      textColor: WarningColor,
                      margin: EdgeInsets.only(left: 30 * ScaleWidth),
                    ),
                    MainTitleLabel(
                      widget.title,
                      width: 295*ScaleWidth,
                    ),
                  ],
                ),
              ),
              InputView(
                enabled: widget.enable,
                controller: controller,
                placeholder: widget.placehoder,
                width: 380 * ScaleWidth,
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                textAlign: TextAlign.right,
                onChanged: (text) {
                  widget.onChange(text);
                },
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
