import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTestLastBtn extends StatefulWidget {
  const WorkTestLastBtn({Key key, this.margin, this.onClick}) : super(key: key);
  final EdgeInsets margin;
  final Function onClick;

  @override
  State<StatefulWidget> createState() {
    return new WorkTestLastBtnState();
  }
}

class WorkTestLastBtnState extends State<WorkTestLastBtn> {
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
            List: [Color(0xFFFFFFFF), Color(0xFFF3F3F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
          //设置四周边框
          border: new Border.all(width: 1, color: Color(0xFFD4D4D4)),
        ),
        child: Center(
          child: MainTitleLabel('上一题'),
        ),
      ),
      onTap: (){
        if(widget.onClick != null){
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
