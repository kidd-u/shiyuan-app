import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

class ImageJiaoYuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ImageJiaoYuState();
  }
}

class ImageJiaoYuState extends State<ImageJiaoYuPage> {
  int _seconds = 60;
  Timer _timer;
  String _vftext = '';
  bool _clickable = false;

  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    _seconds = 60;
    _clickable = false;
    _vftext = '$_seconds秒后可完成培训';
    if (mounted) setState(() {});
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _vftext = '$_seconds秒后可完成培训';
      if (mounted) setState(() {});
      if (_seconds == 0) {
        _vftext = '点击完成培训';
        _clickable = true;
      }
    });
  }

  _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Widget btn = Button(
      child: Text(
        '完成',
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      onPressed: (){
        PageUtil.push('videojiaoyu');
      },
    );
    return new Scaffold(
        backgroundColor: BackgroundColor,
        appBar: buildAppBar(context, '文档教育', actions: [btn]),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30 * ScaleWidth),
                    width: ScreenWidth,
                    height: 729 * ScaleWidth,
                    child: new Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591612032798&di=9fb445b2893a8ab71e4e58ff6a14cc04&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ff7246b600c3387442b4893a7500fd9f9d62aa058.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      itemCount: 10,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                  MainTitleLabel(
                    '地下车库安全教育',
                    margin: EdgeInsets.only(top: 47 * ScaleWidth),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 23 * ScaleWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          '课件',
                          width: 118 * ScaleWidth,
                          height: 40 * ScaleWidth,
                          textColor: Color(0xFF526CE8),
                          fontSize: 24 * ScaleWidth,
                          decoration: new BoxDecoration(
                            color: Color(0xFFDFE4FF),
                            borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
                          ),
                        ),
                        TextButton(
                          'MP4',
                          width: 118 * ScaleWidth,
                          height: 40 * ScaleWidth,
                          margin: EdgeInsets.only(left: 13 * ScaleWidth),
                          textColor: Color(0xFF526CE8),
                          fontSize: 24 * ScaleWidth,
                          decoration: new BoxDecoration(
                            color: Color(0xFFDFE4FF),
                            borderRadius: BorderRadius.all(Radius.circular(20 * ScaleWidth)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30 * ScaleWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImageView(
                          src: 'imgs/home/xianshangpeixun/leftbutton.png',
                          width: 278 * ScaleWidth,
                          height: 132 * ScaleWidth,
                        ),
                        ImageView(
                          src: 'imgs/home/xianshangpeixun/rightbutton.png',
                          width: 278 * ScaleWidth,
                          height: 132 * ScaleWidth,
                          margin: EdgeInsets.only(left: 49 * ScaleWidth),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 99 * ScaleWidth,
              color: Color(0xFF112DB8),
              child: Center(
                child: MainTitleLabel(
                  _vftext,
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ));
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
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
