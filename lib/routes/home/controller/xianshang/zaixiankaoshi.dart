import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/WorkUI/work.dart';
import '../../model/AnswerModel.dart';

class ZaiXianKaoShiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ZaiXianKaoShiState();
  }
}

class ZaiXianKaoShiState extends State<ZaiXianKaoShiPage> {
  void initState() {
    super.initState();
  }

  void _submit() async {
    await DialogUtil.dialogConfim('确认提交？');
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '交卷',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: () {
        _submit();
      },
    );
    AnswerModel model = AnswerModel(
      index: '第一题',
      title: '单位应当将容易发生火灾、一旦发生火灾可能严重危机人身和财产以及对消防安全有重大影细响的部位，确定为（C ）',
      answer: 'C',
      userSelect: 'C',
      isRight: true,
      answerList: ['A、重点部位', 'B、要害部位', 'C、消防安全重点部位', 'D、重点防范部位'],
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '2020年全体员工消防教育考试', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          topView(context),
          WorkTitle(title: '一、单选题：1/25 每题分值：2分'),
          WorkTestRadio(model: model),
          Container(
            margin: EdgeInsets.only(top: 300 * ScaleWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WorkTestLastBtn(),
                WorkTestNextBtn(
                  margin: EdgeInsets.only(left: 56 * ScaleWidth),
                  onClick: (){
                    PageUtil.push('wendangjiaoyu');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topView(BuildContext context) {
    return Container(
      height: 80 * ScaleWidth,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SubTextLabel(
            '总题数:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel('25'),
          SubTextLabel(
            '满分:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(
            '100',
            textColor: MainBlueColor,
          ),
          SubTextLabel(
            '及格分数:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel(
            '25',
            textColor: SuccessColor,
          ),
          SubTextLabel(
            '答题时间:',
            margin: EdgeInsets.only(left: 40 * ScaleWidth),
          ),
          SubTextLabel('40分钟'),
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
