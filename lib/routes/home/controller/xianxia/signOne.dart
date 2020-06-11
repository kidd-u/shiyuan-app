import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';


class SignOnePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignOneState();
  }
}

class SignOneState extends State<SignOnePage> {
  void initState() {
    super.initState();
  }
  scan()async{
//    String str = await PageUtil.push('qrcode');
//    await DialogUtil.toastSuccess(str);
//    print(str);
    PageUtil.push('signTwo');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new ListView(
              padding: EdgeInsets.only(bottom: 40),
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/xianxia/signtop.png',
                  width: ScreenWidth,
                  height: 500 * ScaleWidth,
                ),
                WorkSelectMust(title: '计划名称:', value: '2020年全员消防教育', showBottomLine: false),
                WorkSelect(title: '教育对象：', value: '全体员工', showBottomLine: false),
                WorkSelect(title: '培训地点：', value: 'A306', showBottomLine: false),
                WorkSelect(title: '培训老师:', value: '高帅', showBottomLine: false),
                WorkSelect(title: '计划开始日期:', value: '2020-03-08', showBottomLine: false),
                WorkSelect(title: '培训时长:', value: '2小时', showBottomLine: false),
                Container(
                  margin: EdgeInsets.only(top: 120 * ScaleWidth),
                  child: Center(
                    child: TextButton(
                      '点击签到',
                      width: 462 * ScaleWidth,
                      height: 98 * ScaleWidth,
                      fontSize: 28*ScaleWidth,
                      textColor: Colors.white,
                      decoration: new BoxDecoration(
                          color: MainDarkBlueColor,
                          borderRadius: BorderRadius.all(Radius.circular(49*ScaleWidth)),
                      ),
                      onPressed: (){
                        scan();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          navBar(window,'签到'),
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
