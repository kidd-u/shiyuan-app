import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shiyuan/common/FlowDelegate/TestFlowDelegate.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Page();
  }
}

class Page extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
//      appBar: buildAppBar(context, '首页',showPop: false),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          color: BackgroundColor,
          child: new ListView(
            physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
            children: <Widget>[
              header(context),
              lunbo(context),
              changyong(context),
              quanbu(context),
            ],
          ),
        ),
      ),
    );
  }

  /**
   * 头部图片
   * */
  Widget header(BuildContext context) {
    return new ImageView(
      src: 'imgs/home/banner.png',
      width: ScreenWidth,
      height: 336 * ScaleWidth,
    );
  }

  /**
   * 轮播
   * */
  Widget lunbo(BuildContext context) {
    return new Container(
      width: ScreenWidth,
      height: 98 * ScaleWidth,
      child: new Center(
        child: new Container(
          width: 734 * ScaleWidth,
          height: 70 * ScaleWidth,
          //边框设置
          decoration: new BoxDecoration(
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(10 * ScaleWidth)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                  blurRadius: 3.0, //阴影模糊程度
                  spreadRadius: 1 //阴影扩散程度
                  )
            ],
          ),
          child: new Row(
            children: <Widget>[
              new Container(
                width: 86 * ScaleWidth,
                height: 70 * ScaleWidth,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10 * ScaleWidth), bottomLeft: Radius.circular(10 * ScaleWidth)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        offset: Offset(2.0, 0.0), //阴影xy轴偏移量
                        blurRadius: 3.0, //阴影模糊程度
                        spreadRadius: 1 //阴影扩散程度
                        )
                  ],
                ),
                child: new Center(
                  child: ImageView(
                    src: 'imgs/home/gonggao.png',
                    width: 38 * ScaleWidth,
                    height: 38 * ScaleWidth,
                    margin: EdgeInsets.only(bottom: 6 * ScaleWidth),
                    onClick: () {
                      DialogUtil.showToast('111');
                    },
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 34 * ScaleWidth, right: 34 * ScaleWidth),
                height: 70 * ScaleWidth,
                width: 580 * ScaleWidth,
                child: new Swiper(
                  scrollDirection: Axis.vertical,
                  loop: true,
                  autoplay: true,
                  autoplayDelay: 3000,
                  duration: 600,
                  outer: false,
                  itemBuilder: (BuildContext context, int index) {
                    return new Center(
                      child: new Text(
                        '安全通告：2020年第一季度安全综合排查正在进行安全通告：2020年第一季度安全综合排查正在进行',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color.fromRGBO(93, 83, 168, 1),
                          fontSize: 24 * ScaleWidth,
                        ),
                      ),
                    );
                  },
                  itemCount: 3,
                  pagination: null,
                  control: null,
                  onTap: (int index) {
//                    print(DefaultUtil.mainContext);
                    DialogUtil.showToast('点击了$index');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /**
   * 常用
   * */
  Widget changyong(BuildContext context) {
    return new Container(
      width: ScreenWidth,
      height: 424 * ScaleWidth,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            width: ScreenWidth,
            height: 64 * ScaleWidth,
            child: Row(
              children: <Widget>[
                Label(
                  '常用功能',
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  fontSize: 26 * ScaleWidth,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          LineView(),
          Container(
            width: ScreenWidth,
            height: 359 * ScaleWidth,
            child: Wrap(
              spacing: 0, //主轴上子控件的间距
              runSpacing: 0, //交叉轴上子控件之间的间距
              children: <Widget>[
                changyongItem(context, 'imgs/home/yinhuanfaqi.png', '隐患发起', 0),
                changyongItem(context, 'imgs/home/xianshangpeixun.png', '线上培训', 1),
                changyongItem(context, 'imgs/home/jihuajiancha.png', '计划检查', 2),
                changyongItem(context, 'imgs/home/xianxiapeixun.png', '线下培训', 3),
                changyongItem(context, 'imgs/home/yinhuanzhenggai.png', '隐患整改', 4),
                changyongItem(context, 'imgs/home/zuoyeguanli.png', '作业管理', 5),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget changyongItem(BuildContext context, String src, String title, int index) {
    return Container(
      width: ScreenWidth / 5,
      height: 358 / 2 * ScaleWidth,
      child: Column(
        children: <Widget>[
          ImageView(
            src: src,
            width: 100 * ScaleWidth,
            height: 100 * ScaleWidth,
            margin: EdgeInsets.only(top: 35 * ScaleWidth),
            onClick: () {
              print('$index');
            },
          ),
          SmallTextLabel(title),
        ],
      ),
    );
  }

  /**
   * 全部
   * */
  Widget quanbu(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 18 * ScaleWidth),
      width: ScreenWidth,
      height: 574 * ScaleWidth,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            width: ScreenWidth,
            height: 64 * ScaleWidth,
            child: Row(
              children: <Widget>[
                Label(
                  '全部功能',
                  margin: EdgeInsets.only(left: 30 * ScaleWidth),
                  fontSize: 26 * ScaleWidth,
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          LineView(),
          Container(
            width: ScreenWidth,
            height: 359 * ScaleWidth,
            child: Wrap(
              spacing: 0, //主轴上子控件的间距
              runSpacing: 0, //交叉轴上子控件之间的间距
              children: <Widget>[
                quanbuItem(context, 'imgs/home/zaixiankaoshi.png', '在线考试', 0),
                quanbuItem(context, 'imgs/home/waibujiaoyu.png', '外部教育', 1),
                quanbuItem(context, 'imgs/home/falvbiaozhunku.png', '法律标准库', 2),
                quanbuItem(context, 'imgs/home/xiangguanfanganquangongzuo.png', '相关方安全工作', 3),
                quanbuItem(context, 'imgs/home/zuoyeguanli2.png', '作业管理', 4),
                quanbuItem(context, 'imgs/home/yinhuanfaqi2.png', '隐患发起', 5),
                quanbuItem(context, 'imgs/home/xianshangpeixun2.png', '线上培训', 6),
                quanbuItem(context, 'imgs/home/jihuajiancha2.png', '计划检查', 7),
                quanbuItem(context, 'imgs/home/xianxiapeixun2.png', '线下培训', 8),
                quanbuItem(context, 'imgs/home/yinhuanzhenggai2.png', '隐患整改', 9),
                quanbuItem(context, 'imgs/home/anquanhuiwu.png', '安全会务', 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget quanbuItem(BuildContext context, String src, String title, int index) {
    return Container(
      width: ScreenWidth / 5,
      height: 508 / 3 * ScaleWidth,
      child: Column(
        children: <Widget>[
          ImageView(
            src: src,
            width: 77 * ScaleWidth,
            height: 61 * ScaleWidth,
            margin: EdgeInsets.only(top: 35 * ScaleWidth),
            onClick: () {
              print('$index');
            },
          ),
          SmallTextLabel(
            title,
            margin: EdgeInsets.only(top: 30 * ScaleWidth),
          ),
        ],
      ),
    );
  }
}
