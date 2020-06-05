import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTitleWithDelete extends StatefulWidget {
  const WorkTitleWithDelete({Key key, this.title, this.margin, this.color = Colors.white, this.value = '无', this.onDelete}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final Function onDelete;

  @override
  State<StatefulWidget> createState() {
    return new WorkTitleWithDeleteState();
  }
}

class WorkTitleWithDeleteState extends State<WorkTitleWithDelete> {
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
              ImageView(
                src: 'imgs/home/yinhuanfaqi/delete.png',
                width: 31 * ScaleWidth,
                height: 33 * ScaleWidth,
                margin: EdgeInsets.only(right: 20 * ScaleWidth),
                onClick: () => widget.onDelete,
              ),
              MainTextLabel(
                '删除',
                textColor: ErrorColor,
                margin: EdgeInsets.only(right: 30 * ScaleWidth),
                onClick: () => widget.onDelete,
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
