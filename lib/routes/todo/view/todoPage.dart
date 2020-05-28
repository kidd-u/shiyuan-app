import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new TodoViewState();
  }
}

class TodoViewState extends State<TodoView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[],
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
