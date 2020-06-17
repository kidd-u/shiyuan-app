import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkSelect.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:shiyuan/states/default.dart';

class SafeMeetDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SafeMeetDetailState();
  }
}

class SafeMeetDetailState extends State<SafeMeetDetailPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text =
        '哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦';
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '安全会晤详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          WorkSelect(title: '会议标题:', value: '安全信息化建设中期会议'),
          WorkSelect(title: '会议主题:', placeholder: ''),
          Container(
            color: Colors.white,
            width: ScreenWidth,
            height: 303 * ScaleWidth,
            padding: EdgeInsets.all(20 * ScaleWidth),
            child: Scrollbar(
              child: InputView(
                controller: controller,
                enabled: false,
                contentPadding: EdgeInsets.zero,
                height: 163 * ScaleWidth,
                padding: EdgeInsets.only(top: 15 * ScaleWidth, left: 15 * ScaleWidth, bottom: 15 * ScaleWidth),
                maxLines: 9999,
                decoration: new BoxDecoration(
                  border: new Border.all(width: 1, color: Color(0xFFB7B7B7)),
                ),
              ),
            ),
          ),
          WorkSelect(title: '教育对象：', value: '全体员工', margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          WorkSelect(title: '会议地点：', value: 'A306'),
          WorkSelect(title: '组织部门:', value: '后勤管理处'),
          WorkSelect(title: '会议开始日期:', value: '2020-03-08 15：00'),
          WorkSelect(title: '会议预计时长:', value: '2小时'),
          WorkSelect(title: '签到方式:', value: '现场扫码'),
          WorkEmpty(
            showTopLine: false,
            leftActions: [
              MainTitleLabel('计划状态:'),
            ],
            rightActions: [
              MainTitleLabel(
                '已完成',
                textColor: SuccessColor,
              ),
            ],
          ),
          WorkEmpty(
            showTopLine: false,
            leftActions: [
              MainTitleLabel('我的参与情况:'),
            ],
            rightActions: [
              MainTitleLabel(
                '未打卡',
                textColor: ErrorColor,
              ),
            ],
          ),
          WorkEmpty(
            showTopLine: false,
            leftActions: [
              MainTitleLabel('已签到记录（17）'),
            ],
            rightActions: [
              MainTitleLabel(
                '查看浏览详情',
                textColor: MainBlueColor,
                onClick: () {
                  PageUtil.push('safeMeetSignList');
                },
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30 * ScaleWidth, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WorkButtonCancel(margin: EdgeInsets.only(right: 56 * ScaleWidth)),
                WorkButtonDone(),
              ],
            ),
          )
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
