import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

enum ShangJiType {
  normal, //已完成
  loading, //进行中
  error, //超期未考
}

class ShangJiPage extends StatefulWidget {
  const ShangJiPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new ShangJiPageState();
  }
}

class ShangJiPageState extends State<ShangJiPage> {
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
          itemCount: 3,
//          itemExtent: 323 * ScaleWidth,
//          itemExtent: 365 * ScaleWidth,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return itemCell(ShangJiType.normal);
            if (index == 1) return itemCell(ShangJiType.loading);
            if (index == 2) return itemCell(ShangJiType.error);
            return null;
          }),
    );
  }

  Widget itemCell(ShangJiType type) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * ScaleWidth),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
          child: Container(
            width: 690 * ScaleWidth,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  color: type == ShangJiType.normal ? SuccessColor : type == ShangJiType.loading ? LoadingColor : ErrorColor,
                  height: 92 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('21903810381', textColor: Colors.white, margin: EdgeInsets.only(left: 36 * ScaleWidth)),
                      ),
                      SubTextLabel('待整改', textColor: Colors.white, margin: EdgeInsets.only(right: 32 * ScaleWidth)),
                    ],
                  ),
                ),
                Container(
                  width: 690 * ScaleWidth,
                  padding: EdgeInsets.only(top: 26 * ScaleWidth, bottom: 30 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MainTextLabel('检查部门/单位：市卫纪委', textColor: Color(0xFF7D7D7D)),
                      MainTextLabel('责任部门/单位：相关方1号', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      MainTextLabel('整改要求：立即停工，检查设备', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      MainTextLabel('整改人：赵小刚', textColor: Color(0xFF7D7D7D), margin: EdgeInsets.only(top: 10 * ScaleWidth)),
                      LineView(margin: EdgeInsets.only(top: 20 * ScaleWidth)),
                      Container(
                        margin: EdgeInsets.only(top: 20 * ScaleWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SubTextLabel('2020-05-13', textColor: Color(0xFF7D7D7D)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        switch (type) {
          case ShangJiType.normal:
            {
              PageUtil.push('ShangJiDetail');
            }
            break;
          case ShangJiType.loading:
            {
              PageUtil.push('zaixiankaoshi');
            }
            break;
          case ShangJiType.error:
            {
              PageUtil.push('ShangJiDetail');
            }
            break;

          default:
            {}
            break;
        }
      },
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
