import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkButtonDone extends StatefulWidget {
  const WorkButtonDone({
    Key key,
    this.margin,
    this.onClick,
    this.title = '通过',
  }) : super(key: key);
  final EdgeInsets margin;
  final Function onClick;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new WorkButtonDoneState();
  }
}

class WorkButtonDoneState extends State<WorkButtonDone> {
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
        decoration: new BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3E4AD5), Color(0xFF2532BF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
          //设置四周边框
          border: new Border.all(width: 1, color: Color(0xFFD4D4D4)),
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
