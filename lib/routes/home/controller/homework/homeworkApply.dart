import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class HomeWorkApplyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeWorkApplyState();
  }
}

class HomeWorkApplyState extends State<HomeWorkApplyPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '完成',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '文档教育', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          new Text('HomeWorkApply'),
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
