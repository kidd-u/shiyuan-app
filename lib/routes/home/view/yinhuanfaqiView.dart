import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import '../model/yinhuanfaqiModel.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';
import 'package:shiyuan/common/WorkUI/work.dart';

class YinhuanfaqiView extends StatefulWidget {
  YinhuanfaqiView({Key key, this.model, this.index, this.onDelete}) : super(key: key);
  YinhuanfaqiModel model;
  int index;
  Function onDelete;

  @override
  State<StatefulWidget> createState() {
    return new YinhuanfaqiViewState();
  }
}

class YinhuanfaqiViewState extends State<YinhuanfaqiView> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      color: Colors.white,
      width: ScreenWidth,
//      height: 1056 * ScaleWidth,
      margin: EdgeInsets.only(top: 20 * ScaleWidth),
      child: Column(
        children: <Widget>[
          WorkTitleWithDelete(
              title: '安全隐患' + widget.index.toString(),
              onDelete: () {
                widget.onDelete();
              }),
          WorkInputArea(placehoder: '填写隐患说明......', onChange: (text) {}),
          WorkImageTitle(onAdd: () {
            setState(() {
              widget.model.imgs.add(Imgs());
            });
          }),
          Container(
              height: 158 * widget.model.imgs.length * ScaleWidth,
              child: ListView.builder(
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return WorkImageWithMessage(
                    src: widget.model.imgs[index].src,
                    message: widget.model.imgs[index].msg,
                    onDelete: (){
                      setState(() {
                        widget.model.imgs.removeAt(index);
                      });
                    },
                  );
                },
                itemCount: widget.model.imgs.length,
              )),
          WorkTitle(title: '整改要求'),
          WorkInputArea(placehoder: '填写隐患说明......', height: 303 * ScaleWidth, onChange: (text) {}),
          WorkChoose(title: '整改人:',placeholder: '选择整改人',),
          WorkChoose(title: '限期整改时间:',placeholder: '请选择日期',),
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
