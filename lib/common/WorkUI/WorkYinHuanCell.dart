import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class WorkYinHuanCell extends StatefulWidget {
  const WorkYinHuanCell({
    Key key,
    this.color = Colors.white,
    this.margin,
    @required this.forms,
    @required this.onDelete,
  }) : super(key: key);
  final Color color;
  final EdgeInsets margin;
  final List forms;
  final Function onDelete;

  @override
  State<StatefulWidget> createState() {
    return new WorkYinHuanCellState();
  }
}

class WorkYinHuanCellState extends State<WorkYinHuanCell> {
  String _title, _value;
  TextEditingController controller = TextEditingController();

  void initState() {
    super.initState();
    for (int i = 0; i < widget.forms.length; i++) {
      Map item = widget.forms[i];
      if (item['name'] == '计划') {
        _title = item['label'];
      }
      if (item['name'] == '隐患内容') {
        _value = item['label'];
      }
    }
    controller.text = _value;
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Container(
      color: widget.color,
      margin: widget.margin ?? EdgeInsets.only(top: 15 * ScaleWidth),
      child: Column(
        children: <Widget>[
          LineView(),
          new Container(
            margin: widget.margin,
            color: widget.color,
            height: 88 * ScaleWidth,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTitleLabel(
                    _title,
                    fontWeight: FontWeight.bold,
                    margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  ),
                ),
                ImageView(
                  src: 'imgs/home/yinhuanfaqi/delete.png',
                  width: 31 * ScaleWidth,
                  height: 33 * ScaleWidth,
                  margin: EdgeInsets.only(right: 20 * ScaleWidth),
                  onClick: () => widget.onDelete,
                ),
                MainTextLabel(
                  '删除',
                  textColor: ErrorColor,
                  margin: EdgeInsets.only(right: 30 * ScaleWidth),
                  onClick: () => widget.onDelete,
                ),
              ],
            ),
          ),
          LineView(),
          InputView(
            color: widget.color,
            controller: controller,
            enabled: false,
            maxLength: 999,
            padding: EdgeInsets.only(left: 30*ScaleWidth,right: 30*ScaleWidth),
            height: 170*ScaleWidth,
          ),
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
