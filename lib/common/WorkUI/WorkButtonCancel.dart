import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkButtonCancel extends StatefulWidget {
  const WorkButtonCancel({
    Key key,
    this.margin,
    this.onClick,
    this.title = '驳回',
    this.showBorder = true,
  }) : super(key: key);
  final EdgeInsets margin;
  final Function onClick;
  final String title;
  final bool showBorder;

  @override
  State<StatefulWidget> createState() {
    return new WorkButtonCancelState();
  }
}

class WorkButtonCancelState extends State<WorkButtonCancel> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new GestureDetector(
      child: Container(
        width: 272 * ScaleWidth,
        height: 80 * ScaleWidth,
        margin: widget.margin,
        decoration: widget.showBorder
            ? BoxDecoration(
                gradient: LinearGradient(
                  List: [Color(0xFFF75E52), Color(0xFFE03E31)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
                //设置四周边框
                border: new Border.all(width: 1, color: Color(0xFFD4D4D4)),
              )
            : BoxDecoration(
                gradient: LinearGradient(
                  List: [Color(0xFFF75E52), Color(0xFFE03E31)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
        child: Center(
          child: MainTitleLabel(
            widget.title,
            textColor: Colors.white,
          ),
        ),
      ),
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick();
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
