import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

enum SafeMeetType {
  normal, //已完成
  loading, //进行中
  error, //超期未考
}

class SafeMeetPage extends StatefulWidget {
  const SafeMeetPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new SafeMeetPageState();
  }
}

class SafeMeetPageState extends State<SafeMeetPage> {
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
            if (index == 0) return itemCell(SafeMeetType.normal);
            if (index == 1) return itemCell(SafeMeetType.loading);
            if (index == 2) return itemCell(SafeMeetType.error);
            return null;
          }),
    );
  }

  Widget itemCell(SafeMeetType type) {
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
                  color: type == SafeMeetType.normal ? SuccessColor : type == SafeMeetType.loading ? LoadingColor : ErrorColor,
                  height: 92 * ScaleWidth,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: MainTitleLabel('2020年冬季防火专项培训', textColor: Colors.white, margin: EdgeInsets.only(left: 36 * ScaleWidth)),
                      ),
                      SubTextLabel('已完成', textColor: Colors.white, margin: EdgeInsets.only(right: 32 * ScaleWidth)),
                    ],
                  ),
                ),
                Container(
                  width: 690 * ScaleWidth,
                  padding: EdgeInsets.only(top: 26 * ScaleWidth, bottom: 30 * ScaleWidth, left: 36 * ScaleWidth, right: 36 * ScaleWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MainTextLabel('开始时间：2020-01-15',textColor: Color(0xFF7D7D7D)),
                      MainTextLabel('培训地点：A306',textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 10*ScaleWidth)),
                      MainTextLabel('组织部门：后勤管理处',textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 10*ScaleWidth)),
                      MainTextLabel('打卡方式：电子签字',textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 10*ScaleWidth)),
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
          case SafeMeetType.normal:
            {
              PageUtil.push('xianshangpeixun');
            }
            break;
          case SafeMeetType.loading:
            {
              PageUtil.push('zaixiankaoshi');
            }
            break;
          case SafeMeetType.error:
            {
              PageUtil.push('testError');
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
