import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class NoticePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NoticeState();
  }
}

class NoticeState extends State<NoticePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '通告详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          MainTitleLabel(
            '上海第十人民医院后勤安全工作管理暂行办法已颁布',
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            margin: EdgeInsets.only(top: 22 * ScaleWidth),
          ),
          SubTextLabel('后勤保障部 2020-3-12', textAlign: TextAlign.center, margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          MainTextLabel('安全员岗位职责', fontWeight: FontWeight.bold, margin: EdgeInsets.only(left: 28 * ScaleWidth, top: 40 * ScaleWidth)),
          MainTextLabel(
            '1，贯彻安全生产的各项规定，并模范遵守。\n2，负责施工现场的职业安全卫生和环境管理。\n3·参与施工组织设计中安全技术措施的制订及审查，制订安全应急预案。\n4，负责对职工进行安全生产教育、安全交底和日常安全宣传工作，会同有关部门搞好特种作业人员的技术培训和考核工作并做好日常安全资料。\n5·深入施工现场检查、监督、指导各项安全规定的落实，消除事故隐患，分析安全动态，定期向项目经理汇报安全生产具体情况。\n6，正确行使安全否决权，做到奖罚分明，处事公正。做好各级职能部门对本工程安全检查的配合工作。\n7，负责对现场安全设施的检查与验收工作。\n8·督促有关部门按规定及时发放职工劳动防护用品，并指导合理',
            maxLines: 9999,
            margin: EdgeInsets.only(top: 30 * ScaleWidth, left: 28 * ScaleWidth, right: 28 * ScaleWidth),
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
