import 'package:flutter/material.dart';
import 'package:shiyuan/common/WorkUI/WorkImageWithMessage.dart';
import 'package:shiyuan/states/default.dart';

class WorkImageUpload extends StatefulWidget {
  const WorkImageUpload({
    Key key,
    this.title = '',
    this.margin,
    this.color = Colors.white,
    this.must = false,
    this.showTopLine = false,
    this.showBottomLine = true,
    this.enable = true,
    this.onChange,
  }) : super(key: key);
  final String title;
  final EdgeInsets margin;
  final Color color;
  final bool showTopLine;
  final bool showBottomLine;
  final bool must;
  final bool enable;
  final Function onChange;

  @override
  State<StatefulWidget> createState() {
    return new WorkImageUploadState();
  }
}

class WorkImageUploadState extends State<WorkImageUpload> {
  List _imagesArray = [
    {'src': '', 'message': ''}
  ];

  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
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
    List<Widget> rightActions=[];
    if (widget.enable) {
      rightActions = [
        ImageView(
          src: 'imgs/home/yinhuanfaqi/add.png',
          width: 30 * ScaleWidth,
          height: 29 * ScaleWidth,
          margin: EdgeInsets.only(right: 20 * ScaleWidth),
          onClick: () {
            setState(() {
              _imagesArray.add({'src': '', 'message': ''});
            });
          },
        ),
        MainTextLabel(
          '添加照片',
          textColor: Color(0xFF959595),
          margin: EdgeInsets.only(right: 30 * ScaleWidth),
          onClick: () {
            setState(() {
              _imagesArray.add({'src': '', 'message': ''});
            });
          },
        ),
      ];
    }
    List<Widget> imageItems=[];
    for (int i = 0; i < _imagesArray.length; i++) {
      var item = _imagesArray[i];
      imageItems.add(WorkImageWithMessage(
        enabled: widget.enable,
        src: item['src'],
        message: item['message'],
        index: i,
        onChange: (src, message) {
          setState(() {
            item['src'] = src;
            item['message'] = message;
          });
        },
        onDelete: (index) {
          setState(() {
            _imagesArray.removeAt(index);
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
