import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTitleTest extends StatefulWidget {
  const WorkTitleTest({Key key, this.title, this.margin, this.color = Colors.white, this.value = '无', this.onAll, this.onError}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String value;
  final Function onAll;
  final Function onError;

  @override
  State<StatefulWidget> createState() {
    return new WorkTitleTestState();
  }
}

class WorkTitleTestState extends State<WorkTitleTest> {
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
                  fontWeight: FontWeight.w500,
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 130 * ScaleWidth,
                  height: 52 * ScaleWidth,
                  margin: EdgeInsets.only(right: 16 * ScaleWidth),
                  decoration: new BoxDecoration(
                    color: Color(0xFF112DB8),
                    borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                  ),
                  child: Center(
                    child: SubTextLabel(
                      '全部试题',
                      textColor: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.onAll != null) {
                    widget.onAll();
                  }
                },
              ),
              GestureDetector(
                child: Container(
                  width: 130 * ScaleWidth,
                  height: 52 * ScaleWidth,
                  margin: EdgeInsets.only(right: 37 * ScaleWidth),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
                    border: new Border.all(width: 1, color: Color(0xFFA9A9A9)),
                  ),
                  child: Center(
                    child: SubTextLabel(
                      '全部试题',
                      textColor: Color(0xFF6B6B6B),
                    ),
                  ),
                ),
                onTap: () {
                  if (widget.onError != null) {
                    widget.onError();
                  }
                },
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
