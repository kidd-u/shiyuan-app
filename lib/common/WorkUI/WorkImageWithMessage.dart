import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';

class WorkImageWithMessage extends StatefulWidget {
  const WorkImageWithMessage({
    Key key,
    @required this.src,
    @required this.message = '',
    this.margin,
    this.color = Colors.white,
    @required this.onChange,
    @required this.onDelete,
    this.enabled = true,
    this.showBorder = true,
    this.paddingTop = 0,
  }) : super(key: key);
  final EdgeInsets margin;
  final Color color;
  final Function onChange; //返回(_src, _message)
  final Function onDelete;
  final String src;
  final String message;
  final bool enabled; //禁用，false为禁用
  final bool showBorder; //是否显示边框
  final double paddingTop;

  @override
  State<StatefulWidget> createState() {
    return new WorkImageWithMessageState();
  }
}

class WorkImageWithMessageState extends State<WorkImageWithMessage> {
  String _src, _message;

  void initState() {
    _src = widget.src;
    _message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> views = [];
    if (widget.enabled) {
      TextEditingController controller = new TextEditingController();
      controller.text = _message;
      Widget input = Expanded(
        child: InputView(
          controller: controller,
          maxLines: 999,
          placeholder: '请输入照片描述......',
          margin: EdgeInsets.only(left: 18 * ScaleWidth),
          onChanged: (text) {
            _message = text;
            widget.onChange(_src, _message);
          },
        ),
      );
      Widget delete = GestureDetector(
        onTap: () async {
          await DialogUtil.dialogConfim('是否确认删除');
          widget.onDelete();
        },
        child: Container(
          width: 77 * ScaleWidth,
          height: 136 * ScaleWidth,
          //边框设置
          decoration: new BoxDecoration(
            color: ErrorColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(3.0),
              bottomRight: Radius.circular(3.0),
            ),
          ),
          child: Center(
            child: SubTextLabel(
              '删除',
              textColor: Colors.white,
            ),
          ),
        ),
      );
      views.add(input);
      views.add(delete);
    } else {
      TextEditingController controller = new TextEditingController();
      controller.text = _message;
      Widget text = Expanded(
        child: InputView(
          controller: controller,
          enabled: false,
          maxLines: 9999,
          contentPadding: EdgeInsets.all(15 * ScaleWidth),
        ),
      );
      views.add(text);
    }
    return Container(
      color: widget.color,
      margin: widget.margin,
//      height: 136 * ScaleWidth,
      padding: EdgeInsets.only(bottom: 22 * ScaleWidth, top: widget.paddingTop),
      child: Row(
        children: <Widget>[
          SelectImage(
            width: 136 * ScaleWidth,
            heidht: 136 * ScaleWidth,
            margin: EdgeInsets.only(left: 30 * ScaleWidth),
            enabled: widget.enabled,
            src: _src,
            onChange: (value) {
              setState(() {
                _src = value;
              });
              widget.onChange(_src, _message);
            },
          ),
          Expanded(
            child: Container(
//              width: 518 * ScaleWidth,
              height: 136 * ScaleWidth,
              margin: EdgeInsets.only(left: 29 * ScaleWidth, right: 29 * ScaleWidth),
              //边框设置
              decoration: widget.showBorder
                  ? new BoxDecoration(
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      //设置四周边框
                      border: new Border.all(width: 1, color: Color(0xFFD4D4D4)),
                    )
                  : BoxDecoration(),
              child: Row(
                children: <Widget>[
                  ...views,
                ],
              ),
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
