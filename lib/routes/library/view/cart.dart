import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';

class CartView extends StatefulWidget {
  const CartView({
    Key key,
    this.title,
    this.tag = 0,
    this.total = '0',
  }) : super(key: key);
  final String title;
  final int tag;
  final String total;

  @override
  State<StatefulWidget> createState() {
    return new CartViewState();
  }
}

class CartViewState extends State<CartView> {
  var _imagesList = [
    "imgs/library/yinhuantiaoshu.png",
    "imgs/library/yizhenggai.png",
    "imgs/library/daizhenggai.png",
    "imgs/library/weizhenggai.png",
    "imgs/library/zhenggailv.png",
  ];
  var _titleList = [
    '本月隐患总条数',
    '已整改',
    '待整改',
    '超期未整改',
    '隐患整改率',
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
      ),
      child: Column(
        children: <Widget>[
          ImageView(src: _imagesList[widget.tag], margin: EdgeInsets.only(top: 52 * ScaleWidth), width: 82 * ScaleWidth, height: 82 * ScaleWidth),
          Label(_titleList[widget.tag], margin: EdgeInsets.only(top: 30 * ScaleWidth), fontSize: 30 * ScaleWidth, fontWeight: FontWeight.bold),
          Label(widget.total, margin: EdgeInsets.only(top: 42 * ScaleWidth), fontSize: 60 * ScaleWidth, fontWeight: FontWeight.bold),
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
