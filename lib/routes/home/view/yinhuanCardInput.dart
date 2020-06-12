import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class YinHuanCardInputView extends StatefulWidget {
  const YinHuanCardInputView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new YinHuanCardInputViewState();
  }
}

class YinHuanCardInputViewState extends State<YinHuanCardInputView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 20 * ScaleWidth),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
          child: Container(
            width: 688 * ScaleWidth,
            padding: EdgeInsets.only(bottom: 5),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
              border: new Border.all(width: 1, color: LineColor),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: 75 * ScaleWidth,
                  padding: EdgeInsets.only(left: 45 * ScaleWidth, right: 45 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('整改人：赵小刚'),
                      ),
                      MainTitleLabel(
                        '通过',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
                LineView(),
                WorkInputArea(placehoder: '请输入回复内容......',showBottomLine: false,showTopLine: false),
                MainTitleLabel('整改照片：', width: 587 * ScaleWidth, margin: EdgeInsets.only(bottom: 35 * ScaleWidth)),
                WorkImageWithMessage(message: '文本标签'),
              ],
            ),
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
