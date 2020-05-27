import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class OnLineView extends StatefulWidget {
  const OnLineView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new OnLineViewState();
  }
}

class OnLineViewState extends State<OnLineView> {
  String getTitle(){
    return widget.title;
  }
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Colors.white,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
//              Label(widget.title),
              Text(widget.title)
            ],
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
