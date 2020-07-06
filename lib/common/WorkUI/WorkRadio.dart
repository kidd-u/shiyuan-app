import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkRadio extends StatefulWidget {
  WorkRadio({
    Key key,
    @required this.title = '',
    @required this.value,
    @required this.model,
    this.onChange,
    this.margin,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);
  final String title;
  dynamic value;
  dynamic model;
  final Function onChange;
  final EdgeInsets margin;
  final double width;
  final double height;
  final Color color;

  @override
  State<StatefulWidget> createState() {
    return new WorkRadioState();
  }
}

class WorkRadioState extends State<WorkRadio> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return GestureDetector(
      child: new Container(
        margin: widget.margin,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        child: Row(
          children: <Widget>[
            ImageView(
              src: widget.value == widget.model ? 'imgs/login/select.png' : 'imgs/login/select_de.png',
              width: 24 * ScaleWidth,
              height: 24 * ScaleWidth,
              margin: EdgeInsets.only(right: 16 * ScaleWidth),
            ),
            MainTextLabel(widget.title),
          ],
        ),
      ),
      onTap: () {
//        setState(() {
//          widget.model = widget.value;
//        });
        if (widget.onChange != null) {
          widget.onChange(widget.value,widget.title);
        }
      },
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
