import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

enum SpecialType {
  normal, //已完成
  loading, //进行中
  error, //超期未考
}

class SpecialPeoplePage extends StatefulWidget {
  const SpecialPeoplePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new SpecialPeoplePageState();
  }
}

class SpecialPeoplePageState extends State<SpecialPeoplePage> {
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
            if (index == 0) return itemCell(SpecialType.normal, time: 340);
            if (index == 1) return itemCell(SpecialType.loading, time: 90);
            if (index == 2) return itemCell(SpecialType.error);
            return null;
          }),
    );
  }

  Widget itemCell(SpecialType type, {int time = 90}) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 30 * ScaleWidth),
        height: 300 * ScaleWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5 * ScaleWidth)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                width: 14 * ScaleWidth,
                child: Container(
                  color: type == SpecialType.normal ? SuccessColor : type == SpecialType.loading ? LoadingColor : ErrorColor,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 14 * ScaleWidth,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WorkEmpty(
                        showTopLine: false,
                        showBottomLine: false,
                        leftActions: [MainTitleLabel('电工作业证')],
                        rightActions: [
                          type == SpecialType.normal
                              ? SubTextLabel(
                                  '距离证书过期还有' + time.toString() + '天',
                                  textColor: SuccessColor,
                                )
                              : type == SpecialType.loading
                                  ? SubTextLabel(
                                      '距离证书过期还有' + time.toString() + '天',
                                      textColor: LoadingColor,
                                    )
                                  : SubTextLabel(
                                      '已过期',
                                      textColor: ErrorColor,
                                    ),
                        ],
                      ),
                      LineView(margin: EdgeInsets.only(left: 6 * ScaleWidth, right: 18 * ScaleWidth)),
                      MainTextLabel('持有者：王晓鹏', textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                      MainTextLabel('所属部门/单位：上海卫机电设备有限公司', textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                      MainTextLabel('证书有效期：2017/06/01 — 2020/06/01', textColor: Color(0xFF7D7D7D),margin: EdgeInsets.only(top: 22 * ScaleWidth, left: 22 * ScaleWidth, right: 22 * ScaleWidth)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        PageUtil.push('specialPeopleDetail');
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
