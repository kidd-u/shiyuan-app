import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkImageTitle extends StatefulWidget {
  const WorkImageTitle({Key key, this.title, this.margin, this.color = Colors.white, this.onAdd}) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final Function onAdd;

  @override
  State<StatefulWidget> createState() {
    return new WorkImageTitleState();
  }
}

class WorkImageTitleState extends State<WorkImageTitle> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 73 * ScaleWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ImageView(
            src: 'imgs/home/yinhuanfaqi/add.png',
            width: 30 * ScaleWidth,
            height: 29 * ScaleWidth,
            margin: EdgeInsets.only(right: 20 * ScaleWidth),
            onClick: () {
              widget.onAdd();
            },
          ),
          MainTextLabel(
            '添加照片',
            textColor: Color(0xFF959595),
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            onClick: () {
              widget.onAdd();
            },
          ),
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
