import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/routes/home/model/AnswerModel.dart';

class WorkTestRadio extends StatefulWidget {
  const WorkTestRadio({Key key, this.margin, this.color = Colors.white, this.model, this.onChange}) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final Function onChange;
  final AnswerModel model;

  @override
  State<StatefulWidget> createState() {
    return new WorkTestRadioState();
  }
}

class WorkTestRadioState extends State<WorkTestRadio> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> answerListView = [];
    for (int i = 0; i < widget.model.answerList.length; i++) {
      Widget item = new Container(
        height: 58 * ScaleWidth,
        padding: EdgeInsets.only(left: 65 * ScaleWidth),
        child: Row(
          children: <Widget>[
            radioImg(context),
            MainTextLabel(
              widget.model.answerList[i],
              margin: EdgeInsets.only(left: 21 * ScaleWidth),
            ),
          ],
        ),
      );
      answerListView.add(item);
    }
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
                    widget.model.index,
                    margin: EdgeInsets.only(left: 65 * ScaleWidth),
                  ),
                ),
                widget.model.isRight
                    ? Container()
                    : MainTextLabel(
                        '正确答案为C',
                        textColor: Color(0xFFED6B47),
                        margin: EdgeInsets.only(right: 16 * ScaleWidth),
                      ),
                ImageView(
                  src: widget.model.isRight ? 'imgs/home/xianshangpeixun/right.png' : 'imgs/home/xianshangpeixun/wrong.png',
                  width: 56 * ScaleWidth,
                  height: 56 * ScaleWidth,
                  margin: EdgeInsets.only(right: 70 * ScaleWidth),
                )
              ],
            ),
          ),
          MainTextLabel(
            widget.model.title,
            maxLines: 999,
            margin: EdgeInsets.only(left: 65 * ScaleWidth, right: 70 * ScaleWidth, top: 15 * ScaleWidth, bottom: 17 * ScaleWidth),
          ),
          ...answerListView,
          LineView(),
        ],
      ),
    );
  }

  Widget radioImg(BuildContext context) {
    return ImageView(src: 'imgs/login/select_de.png', width: 24 * ScaleWidth, height: 24 * ScaleWidth);
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
