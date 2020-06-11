import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class SignNotPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignNotState();
  }
}

class SignNotState extends State<SignNotPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '未签到人员列表'),
      body: new ListView.builder(
              padding: EdgeInsets.only(bottom: 40),
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              itemBuilder: (context, index) {
                return signCell();
              },
              itemCount: 10,
            ),
    );
  }

  Widget signCell() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 142 * ScaleWidth,
            padding: EdgeInsets.only(left: 90 * ScaleWidth, right: 47 * ScaleWidth),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTitleLabel(
                    '余秋雨',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                MainTitleLabel(
                  '缺勤',
                  fontWeight: FontWeight.w400,
                  textColor: ErrorColor,
                )
              ],
            ),
          ),
          LineView()
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
