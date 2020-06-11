import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkInputArea extends StatefulWidget {
  const WorkInputArea({
    Key key,
    this.title = '',
    this.margin,
    this.color = Colors.white,
    this.value = '',
    this.placehoder = '请输入',
    this.onChange,
    this.height,
    this.showTopLine = true,
    this.showBottomLine = true,
    this.must = false,
    this.enabled = true,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final String placehoder;
  final Function onChange;
  final double height;
  final bool showTopLine;
  final bool showBottomLine;
  final bool must;
  final bool enabled; //禁用，false为禁用

  @override
  State<StatefulWidget> createState() {
    return new WorkInputAreaState();
  }
}

class WorkInputAreaState extends State<WorkInputArea> {
  TextEditingController controller = TextEditingController();
  void initState() {
    super.initState();
    setState(() {
      controller.text = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> topViews = [];
    if (widget.showBottomLine) {
      topViews.add(LineView());
    }
    List<Widget> bottomViews = [];
    if (widget.showBottomLine) {
      bottomViews.add(LineView());
    }
    return Column(
      children: <Widget>[
        ...topViews,
        Container(
          color: Colors.white,
          width: ScreenWidth,
          height: widget.height != null ? widget.height : 163 * ScaleWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainTitleLabel(
                widget.must ? '*' : '',
                textColor: WarningColor,
                margin: EdgeInsets.only(left: 30 * ScaleWidth, top: 30 * ScaleWidth),
              ),
              MainTitleLabel(
                widget.title,
                margin: EdgeInsets.only(top: 30 * ScaleWidth),
              ),
              Expanded(
                child: InputView(
                  controller: controller,
                  enabled: widget.enabled,
                  contentPadding: EdgeInsets.zero,
                  margin: widget.margin,
                  color: widget.color,
                  height: widget.height != null ? widget.height : 163 * ScaleWidth,
                  padding: EdgeInsets.only(left: 10 * ScaleWidth, right: 30 * ScaleWidth, top: 30 * ScaleWidth, bottom: 10 * ScaleWidth),
                  placeholder: widget.placehoder,
                  maxLines: 999,
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
