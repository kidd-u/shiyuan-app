import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import '../model/yinhuanfaqiModel.dart';
import 'package:shiyuan/common/UIKit/SelectImage.dart';

class YinhuanfaqiView extends StatefulWidget {
  YinhuanfaqiView({Key key, this.model, this.index, this.onDelete}) : super(key: key);
  YinhuanfaqiModel model;
  int index;
  CallbackAction onDelete;

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
          LineView(),
          Container(
            height: 86 * ScaleWidth,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MainTitleLabel(
                    '安全隐患' + widget.index.toString(),
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
            height: 163 * ScaleWidth,
            padding: EdgeInsets.only(left: 30 * ScaleWidth, right: 30 * ScaleWidth, top: 10 * ScaleWidth, bottom: 10 * ScaleWidth),
            placeholder: '填写隐患说明......',
            maxLines: 999,
          ),
          LineView(),
          Container(
            height: 73 * ScaleWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ImageView(
                  src: 'imgs/home/yinhuanfaqi/add.png',
                  width: 30 * ScaleWidth,
                  height: 29 * ScaleWidth,
                  margin: EdgeInsets.only(right: 20 * ScaleWidth),
                  onClick: () {
                    setState(() {
                      widget.model.imgs.add(Imgs());
                    });
                  },
                ),
                MainTextLabel(
                  '添加照片',
                  textColor: Color(0xFF959595),
                  margin: EdgeInsets.only(right: 30 * ScaleWidth),
                  onClick: () {
                    setState(() {
                      widget.model.imgs.add(Imgs());
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 158 * widget.model.imgs.length * ScaleWidth,
            child: ListView.builder(
              physics: new NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return imageItem(context, widget.model.imgs[index]);
              },
              itemCount: widget.model.imgs.length,
            ),
          )
        ],
      ),
    );
  }

  Widget imageItem(BuildContext context, Imgs imgsModel) {
    return Container(
      height: 136 * ScaleWidth,
      margin: EdgeInsets.only(bottom: 22 * ScaleWidth),
      child: Row(
        children: <Widget>[
          SelectImage(
            width: 136 * ScaleWidth,
            heidht: 136 * ScaleWidth,
            margin: EdgeInsets.only(left: 30 * ScaleWidth),
          ),
          Container(
            width: 518 * ScaleWidth,
            height: 136 * ScaleWidth,
            margin: EdgeInsets.only(left: 29 * ScaleWidth),
            //边框设置
            decoration: new BoxDecoration(
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              border: new Border.all(width: 1, color: Color(0xFFD4D4D4)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: InputView(
                  maxLines: 999,
                  placeholder: '请输入照片描述......',
                  margin: EdgeInsets.only(left: 18 * ScaleWidth),
                  onChanged: (text) {
                    imgsModel.msg = text;
                  },
                )),
                Container(
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
                    child: GestureDetector(
                      onTap: () async {
                        await DialogUtil.dialogConfim('是否确认删除');
                      },
                      child: Center(
                        child: SubTextLabel(
                          '删除',
                          textColor: Colors.white,
                        ),
                      ),
                    ))
              ],
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
