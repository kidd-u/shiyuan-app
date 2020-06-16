import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';
import 'dart:ui';


class SafeMeetSignOnePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SafeMeetSignOneState();
  }
}

class SafeMeetSignOneState extends State<SafeMeetSignOnePage> {
  void initState() {
    super.initState();
  }
  scan()async{
//    String str = await PageUtil.push('qrcode');
//    await DialogUtil.toastSuccess(str);
//    print(str);
    PageUtil.push('safeMeetSignTwo');
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
                WorkSelect(title: '会议标题:', value: '安全信息化建设中期会议', showBottomLine: false),
                WorkSelect(title: '教育对象：', value: '全体员工', showBottomLine: false),
                WorkSelect(title: '会议地点：', value: 'A306', showBottomLine: false),
                WorkSelect(title: '组织部门:', value: '后勤管理处', showBottomLine: false),
                WorkSelect(title: '会议开始日期:', value: '2020-03-08', showBottomLine: false),
                WorkSelect(title: '会议预计时长:', value: '2小时', showBottomLine: false),
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
