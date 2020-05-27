import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class OffLineView extends StatefulWidget {
  const OffLineView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new OffLineViewState();
  }
}

class OffLineViewState extends State<OffLineView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Expanded(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Label('222'),
                ],
              ),
            ],
          ),
        ));
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
