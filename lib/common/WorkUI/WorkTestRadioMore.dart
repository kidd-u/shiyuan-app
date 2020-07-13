import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkTestRadioMore extends StatefulWidget {
  const WorkTestRadioMore({
    Key key,
    this.margin,
    this.color = Colors.white,
    @required this.model,
    @required this.index,
    @required this.onChange,
    @required this.answer,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final Function onChange;
  final Map model; //数据
  final int index; //第几题
  final Map answer; //已选答案

  @override
  State<StatefulWidget> createState() {
    return new WorkTestRadioMoreState();
  }
}

class WorkTestRadioMoreState extends State<WorkTestRadioMore> {
  Map question = {};
  List options = [];
  String answer = '';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    question = widget.model['question'];

    options = question['options'];
    answer = widget.answer['reply'];
    options.forEach((element) {
      element['select'] = answer.contains(element['no']) ? element['no'] : '';
    });
    print(answer);
    print(options);
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
//                widget.model.isRight
//                    ? Container()
//                    : MainTextLabel(
//                        '正确答案为C',
//                        textColor: Color(0xFFED6B47),
//                        margin: EdgeInsets.only(right: 16 * ScaleWidth),
//                      ),
//                ImageView(
//                  src: widget.model.isRight ? 'imgs/home/xianshangpeixun/right.png' : 'imgs/home/xianshangpeixun/wrong.png',
//                  width: 56 * ScaleWidth,
//                  height: 56 * ScaleWidth,
//                  margin: EdgeInsets.only(right: 70 * ScaleWidth),
//                )
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        e['select'] = e['select'] == e['no'] ? '' : e['no'];
                        print(options);
                        answer = options.map((el) => el['select']).toList().join('');
                        widget.onChange(answer);
                      });
                    },
                    child: Row(
                      children: <Widget>[
                        ImageView(
                            src: answer.contains(e['no']) ? 'imgs/login/select.png' : 'imgs/login/select_de.png',
                            width: 24 * ScaleWidth,
                            height: 24 * ScaleWidth),
                        Expanded(
                          child: MainTextLabel(
                            e['no'] + '、' + e['content'],
                            maxLines: 999,
                            margin: EdgeInsets.only(left: 21 * ScaleWidth),
                          ),
                        ),
                      ],
                    ),
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