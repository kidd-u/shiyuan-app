import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../view/yinhuanfaqiView.dart';
import '../model/yinhuanfaqiModel.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class YinhuanFaqiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new YinhuanFaqiState();
  }
}

class YinhuanFaqiState extends State<YinhuanFaqiPage> {
  List<YinhuanfaqiModel> modelArray = [];

  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    Widget rightBtn = Button(
      child: MainTextLabel(
        '确定',
        textColor: Colors.white,
      ),
      onPressed: () async {
        await DialogUtil.dialogConfim('确认提交？');
        print('提交成功');
      },
    );
    return new Scaffold(
      appBar: buildAppBar(context, '隐患发起', actions: [rightBtn]),
      backgroundColor: BackgroundColor,
      body: new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                WorkInput(title: '检查地点或项目:'),
                WorkSelect(title: '计划:'),
                WorkSelectTime(title: '日期:', value: '2020-06-05'),
                WorkSelect(title: '检查人:', value: '高帅'),
                WorkSelect(title: '检查部门:',value: '后勤保障部')
              ],
            );
          }
          return YinhuanfaqiView(
            model: modelArray[index - 1],
            index: index,
          );
        },
        itemCount: modelArray.length + 1,
      ),
      floatingActionButton: ImageView(
        src: 'imgs/home/yinhuanfaqi/xinzengyinhuan.png',
        width: 130 * ScaleWidth,
        height: 130 * ScaleWidth,
        onClick: () {
          setState(() {
            modelArray.add(YinhuanfaqiModel(name: '安全隐患1', imgs: []));
            print(modelArray);
          });
        },
      ),
    );
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
