import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
import 'package:shiyuan/states/default.dart';
class WorkImageUploadController{
  WorkImageUploadState _state;
  bind(WorkImageUploadState state){
    _state=state;
  }
  resetValue(List value){
    _state.resetValue(value);
  }
}
class WorkImageUpload extends StatefulWidget {
  WorkImageUpload({
    Key key,
    this.title = '',
    this.margin,
    this.color = Colors.white,
    this.must = false,
    this.showTopLine = false,
    this.showBottomLine = true,
    this.enable = true,
    this.value,
    this.onChange,
    this.controller,
  }) : super(key: key);
  String title;
  EdgeInsets margin;
  Color color;
  bool showTopLine;
  bool showBottomLine;
  bool must;
  bool enable;
  List value;
  Function onChange;
  WorkImageUploadController controller;

  @override
  State<StatefulWidget> createState() {
    WorkImageUploadState state=new WorkImageUploadState();
    if (controller != null) {
      controller.bind(state);
    }
    return state;
  }
}

class WorkImageUploadState extends State<WorkImageUpload> {
  List _imagesArray = [];

  void initState() {
    super.initState();
    _imagesArray = widget.value ??
        [
          {'src': '', 'description': ''}
        ];
  }
  void resetValue(List value){
    setState(() {
      _imagesArray = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return layout(context);
  }

  Widget layout(BuildContext context) {
    List<Widget> topViews = [];
    if (widget.showTopLine) {
      topViews.add(LineView());
    }
    List<Widget> bottomViews = [];
    if (widget.showBottomLine) {
      bottomViews.add(LineView());
    }
    List<Widget> rightActions = [];
    if (widget.enable) {
      rightActions = [
        ImageView(
          src: 'imgs/home/yinhuanfaqi/add.png',
          width: 30 * ScaleWidth,
          height: 29 * ScaleWidth,
          margin: EdgeInsets.only(right: 20 * ScaleWidth),
          onClick: () {
            setState(() {
              _imagesArray.add({'src': '', 'description': ''});
            });
          },
        ),
        MainTextLabel(
          '添加照片',
          textColor: Color(0xFF959595),
          margin: EdgeInsets.only(right: 30 * ScaleWidth),
          onClick: () {
            setState(() {
              _imagesArray.add({'src': '', 'description': ''});
            });
          },
        ),
      ];
    }
    List<Widget> imageItems = [];
    for (int i = 0; i < _imagesArray.length; i++) {
      var item = _imagesArray[i];
      imageItems.add(WorkImageWithMessage(
        enabled: widget.enable,
        src: item['src'],
        message: item['description'],
        onChange: (src, message) {
          item['src'] = src;
          item['description'] = message;
          widget.onChange(_imagesArray);
        },
        onDelete: () {
          setState(() {
            _imagesArray.removeAt(i);
            widget.onChange(_imagesArray);
          });
        },
      ));
    }
    return Container(
      color: widget.color,
      child: Column(
        children: <Widget>[
          ...topViews,
          Container(
            color: Colors.white,
            height: 88 * ScaleWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      MainTitleLabel(
                        widget.must ? '*' : '',
                        textColor: WarningColor,
                        margin: EdgeInsets.only(left: 30 * ScaleWidth),
                      ),
                      MainTitleLabel(
                        widget.title,
                        width: 295 * ScaleWidth,
                      ),
                    ],
                  ),
                ),
                ...rightActions,
              ],
            ),
          ),
          ...imageItems,
          ...bottomViews,
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
