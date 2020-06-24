import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkYinhuanTitle extends StatefulWidget {
  const WorkYinhuanTitle({
    Key key,
    this.margin,
    this.color = Colors.white,
    this.showTopLine = true,
    this.showBottomLine = true,
    this.onClick,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final bool showTopLine;
  final bool showBottomLine;
  final Function onClick;

  @override
  State<StatefulWidget> createState() {
    return new WorkYinhuanTitleState();
  }
}

class WorkYinhuanTitleState extends State<WorkYinhuanTitle> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> topViews = [];
    List<Widget> bottomViews = [];
    if (widget.showTopLine) {
      topViews.add(LineView());
    }
    if (widget.showBottomLine) {
      bottomViews.add(LineView());
    }
    return Container(
      margin: widget.margin,
      color: widget.color,
      child: Column(
        children: <Widget>[
          ...topViews,
          new Container(
            height: 88 * ScaleWidth,
            padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      MainTitleLabel(
                        '非检查标准内隐患',
                      ),
                    ],
                  ),
                ),
                ImageView(
                  src: 'imgs/home/yinhuanfaqi/add_blue.png',
                  width: 30 * ScaleWidth,
                  height: 30 * ScaleWidth,
                  margin: EdgeInsets.only(right: 15 * ScaleWidth),
                  onClick: () {
                    widget.onClick();
                  },
                ),
                MainTitleLabel(
                  '发起隐患',
                  textColor: MainDarkBlueColor,
                  onClick: () {
                    widget.onClick();
                  },
                ),
              ],
            ),
          ),
          ...bottomViews,
        ],
      ),
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
