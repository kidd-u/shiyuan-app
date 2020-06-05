import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkInputArea extends StatefulWidget {
  const WorkInputArea({Key key, this.title, this.margin, this.color = Colors.white, this.value, this.placehoder = '请输入', this.onChange, this.height}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final String placehoder;
  final Function onChange;
  final double height;

  @override
  State<StatefulWidget> createState() {
    return new WorkInputAreaState();
  }
}

class WorkInputAreaState extends State<WorkInputArea> {
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
        InputView(
          height: widget.height != null ? widget.height : 163 * ScaleWidth,
          padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth, top: 10 * ScaleWidth, bottom: 10 * ScaleWidth),
          placeholder: widget.placehoder,
          maxLines: 999,
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
