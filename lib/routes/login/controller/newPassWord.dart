import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LibraryState();
  }
}

class LibraryState extends State<LibraryPage> {
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(
            parent: new BouncingScrollPhysics()),
        children: <Widget>[
          new Text('Library'),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: Color.fromRGBO(163, 171, 242, 1)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        '忘记密码',
        style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(37, 49, 191, 1), Color.fromRGBO(18, 113, 224, 1)],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',
    );
  }
}
