import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

enum File {
  video,
  file,
}

class WorkFile extends StatefulWidget {
  const WorkFile({
    Key key,
    @required this.title = '无',
    this.margin,
    this.color = Colors.white,
    this.src,
    @required this.name,
    @required this.type = File.video,
    this.onChange,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final String src;
  final File type;
  final String name;
  final Function onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkFileState();
  }
}

class WorkFileState extends State<WorkFile> {
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
          height: 214 * ScaleWidth,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MainTitleLabel(
                        widget.title,
                        margin: EdgeInsets.only(left: 30 * ScaleWidth, top: 30 * ScaleWidth),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18 * ScaleWidth),
                child: Center(
                  child: Container(
                    width: 602 * ScaleWidth,
                    height: 104 * ScaleWidth,
                    decoration: new BoxDecoration(
                      color: Color(0xFFF9FCFC),
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      border: new Border.all(width: 1, color: Color(0xFFDEDEDE)),
                    ),
                    child: Row(
                      children: <Widget>[
                        ImageView(
                          src: widget.type == File.video ? 'imgs/home/xianshangpeixun/video.png' : 'imgs/home/xianshangpeixun/file.png',
                          width: 54 * ScaleWidth,
                          height: 64 * ScaleWidth,
                          margin: EdgeInsets.only(left: 27 * ScaleWidth),
                        ),
                        Expanded(
                          child: MainTextLabel(
                            widget.name,
                            margin: EdgeInsets.only(left: 29 * ScaleWidth, right: 20 * ScaleWidth),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
