import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTestNextBtn extends StatefulWidget {
  const WorkTestNextBtn({Key key, this.margin,this.onClick}) : super(key: key);
  final EdgeInsets margin;
  final Function onClick;

  @override
  State<StatefulWidget> createState() {
    return new WorkTestNextBtnState();
  }
}

class WorkTestNextBtnState extends State<WorkTestNextBtn> {
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
            List: [Color(0xFF3E4AD5), Color(0xFF2532BF)],
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
            '下一题',
            textColor: Colors.white,
          ),
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
