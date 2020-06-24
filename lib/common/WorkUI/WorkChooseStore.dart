import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkChooseStorePage extends StatefulWidget {
  WorkChooseStorePage({
    Key key,
    this.value,
  }) : super();
  String value;
  @override
  State<StatefulWidget> createState() {
    return new WorkChooseStoreState();
  }
}

class WorkChooseStoreState extends State<WorkChooseStorePage> {
  void initState() {
    super.initState();
    getData();
  }
  getData()async{
    var res = await HttpUtil.get('/depart/');
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
          new Text('WorkChooseStore'),
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
