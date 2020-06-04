import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import '../view/yinhuanfaqiView.dart';
import '../model/yinhuanfaqiModel.dart';

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

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
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
      body:new ListView.builder(
        padding: EdgeInsets.only(bottom: 40),
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        itemBuilder: (context, index){
          if(index == 0){
            return Column(
              children: <Widget>[
                view1(context),
                LineView(),
                view2(context),
                LineView(),
                view3(context),
                LineView(),
                view4(context),
                LineView(),
                view5(context),
                LineView(),
              ],
            );
          }
          return YinhuanfaqiView(model: modelArray[index - 1],index: index,);
        },
        itemCount:modelArray.length + 1,
      ),

      floatingActionButton: ImageView(
        src: 'imgs/home/yinhuanfaqi/xinzengyinhuan.png',
        width: 130 * ScaleWidth,
        height: 130 * ScaleWidth,
        onClick: (){
          setState(() {
            modelArray.add(YinhuanfaqiModel(name:'安全隐患1',imgs: []));
            print(modelArray);
          });
        },
      ),
    );
  }

  Widget view1(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 88 * ScaleWidth,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MainTitleLabel(
              '检查地点或项目：',
              margin: EdgeInsets.only(left: 30 * ScaleWidth),
            ),
          ),
          InputView(
            placeholder: '请输入',
            width: 380 * ScaleWidth,
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }

  Widget view2(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 88 * ScaleWidth,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MainTitleLabel(
              '计划：',
              margin: EdgeInsets.only(left: 30 * ScaleWidth),
            ),
          ),
          MainTextLabel(
            '无',
            width: 380 * ScaleWidth,
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }

  Widget view3(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 88 * ScaleWidth,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MainTitleLabel(
              '日期：',
              margin: EdgeInsets.only(left: 30 * ScaleWidth),
            ),
          ),
          MainTextLabel(
            '2020-06-04',
            width: 380 * ScaleWidth,
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }

  Widget view4(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 88 * ScaleWidth,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MainTitleLabel(
              '检查人：',
              margin: EdgeInsets.only(left: 30 * ScaleWidth),
            ),
          ),
          MainTextLabel(
            '高帅',
            width: 380 * ScaleWidth,
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }

  Widget view5(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 88 * ScaleWidth,
      child: Row(
        children: <Widget>[
          Expanded(
            child: MainTitleLabel(
              '检查部门：',
              margin: EdgeInsets.only(left: 30 * ScaleWidth),
            ),
          ),
          MainTextLabel(
            '后勤保障部',
            width: 380 * ScaleWidth,
            margin: EdgeInsets.only(right: 30 * ScaleWidth),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
