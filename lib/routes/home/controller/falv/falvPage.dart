import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class FaLvPage extends StatefulWidget {
  const FaLvPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new FaLvPageState();
  }
}

class FaLvPageState extends State<FaLvPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: BackgroundColor,
      child: ListView.builder(
          padding: EdgeInsets.all(30 * ScaleWidth),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return itemCell();
          }),
    );
  }

  Widget itemCell() {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 32 * ScaleWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MainTitleLabel('JGJ 184-2009 建筑施工作业劳动保护用品配备及使用.pdf',
                  maxLines: 2, margin: EdgeInsets.only(top: 30 * ScaleWidth, bottom: 15 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth)),
              LineView(margin: EdgeInsets.only(left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
              MainTextLabel('上传时间：2020-03-12',
                  textColor: Color(0xFF7D7D7D),
                  margin: EdgeInsets.only(top: 18 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth, bottom: 30 * ScaleWidth)),
            ],
          ),
        ),
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
