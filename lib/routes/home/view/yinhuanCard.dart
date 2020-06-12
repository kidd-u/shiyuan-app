import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class YinHuanCardView extends StatefulWidget {
  const YinHuanCardView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new YinHuanCardViewState();
  }
}

class YinHuanCardViewState extends State<YinHuanCardView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 20*ScaleWidth),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
          child: Container(
            width: 688 * ScaleWidth,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
              border: new Border.all(width: 1, color: LineColor),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  color: ErrorColor,
                  height: 75 * ScaleWidth,
                  padding: EdgeInsets.only(left: 45 * ScaleWidth, right: 45 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel(
                          '整改人：赵小刚',
                          textColor: Colors.white,
                        ),
                      ),
                      MainTitleLabel(
                        '通过',
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
                MainTextLabel(
                  '立即停止施工，组织人员进行设备维护，设备状态已良好',
                  maxLines: 9999,
                  width: 587 * ScaleWidth,
                  margin: EdgeInsets.only(top: 20 * ScaleWidth, bottom: 50 * ScaleWidth),
                ),
                MainTitleLabel('附件（1/50）', width: 587 * ScaleWidth, margin: EdgeInsets.only(bottom: 35 * ScaleWidth)),
                WorkImageWithMessage(message: '文本标签', enabled: false, showBorder: false),
                LineView(),
                Container(
                  height: 70 * ScaleWidth,
                  child: Center(
                    child: SubTextLabel('2020-3-9   17：00', textColor: WaitingColor),
                  ),
                )
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
