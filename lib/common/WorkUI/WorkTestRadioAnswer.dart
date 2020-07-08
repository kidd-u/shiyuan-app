import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTestRadioAnswer extends StatefulWidget {
  const WorkTestRadioAnswer({
    Key key,
    this.margin,
    this.color = Colors.white,
    @required this.model,
    @required this.index,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final Map model; //数据
  final int index; //第几题

  @override
  State<StatefulWidget> createState() {
    return new WorkTestRadioAnswerState();
  }
}

class WorkTestRadioAnswerState extends State<WorkTestRadioAnswer> {
  Map question={};
  List options=[];
  String answer = '';
  String reply = '';
  bool isCorrect = true;
  String type = '';
  void initState() {
    super.initState();
    question = widget.model['question'];
    options = question['options'];
    answer=question['answer'];
    reply = widget.model['reply'];
    isCorrect = widget.model['isCorrect'];
    type=question['type'];
    if (type == 'TOF') {
      options=[{'no':'对'},{'no':'错'}];
    }
  }

  @override
  Widget build(BuildContext context) {

    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 56 * ScaleWidth,
            margin: EdgeInsets.only(top: 36 * ScaleWidth),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTextLabel(
                    '第${widget.index + 1}题',
                    margin: EdgeInsets.only(left: 65 * ScaleWidth),
                  ),
                ),
                isCorrect
                    ? Container()
                    : MainTextLabel(
                        '正确答案为${answer}',
                        textColor: Color(0xFFED6B47),
                        margin: EdgeInsets.only(right: 16 * ScaleWidth),
                      ),
                ImageView(
                  src: isCorrect ? 'imgs/home/xianshangpeixun/right.png' : 'imgs/home/xianshangpeixun/wrong.png',
                  width: 56 * ScaleWidth,
                  height: 56 * ScaleWidth,
                  margin: EdgeInsets.only(right: 70 * ScaleWidth),
                )
              ],
            ),
          ),
          MainTextLabel(
            question['content'],
            maxLines: 999,
            margin: EdgeInsets.only(left: 65 * ScaleWidth, right: 70 * ScaleWidth, top: 15 * ScaleWidth, bottom: 17 * ScaleWidth),
          ),
          ...options
              .map(
                (e) => Container(
              padding: EdgeInsets.only(left: 65 * ScaleWidth, right: 15 * ScaleWidth),
              margin: EdgeInsets.only(bottom: 15 * ScaleWidth),
                  child: Row(
                    children: <Widget>[
                      ImageView(src: reply.contains(e['no']) ? 'imgs/login/select_hui.png' : 'imgs/login/select_de.png', width: 24 * ScaleWidth, height: 24 * ScaleWidth),
                      Expanded(
                        child: MainTextLabel(
                          type == 'TOF'?e['no']:'${e['no']}、${e['content']}',
                          maxLines: 999,
                          margin: EdgeInsets.only(left: 21 * ScaleWidth),
                        ),
                      ),
                    ],
                  ),
            ),
          )
              .toList(),
          LineView(),
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
