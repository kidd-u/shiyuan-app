import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class VideoJiaoYuPage extends StatefulWidget {
  VideoJiaoYuPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new VideoJiaoYuState();
  }
}

class VideoJiaoYuState extends State<VideoJiaoYuPage> {
  Widget playerWidget;
  VideoPlayerController _controller;

  // bool _isPlaying = false;
  String url = 'http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4';
  int _seconds = 60;
  Timer _timer;
  String _vftext = '';
  bool _clickable = false;

  void initState() {
    super.initState();
    _startTimer();
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
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
        PageUtil.push('xianshangshenhe');
      },
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '视频教育', actions: [btn]),
      body: Column(
        children: <Widget>[
          Expanded(
            child: new ListView(
              physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
              children: <Widget>[
                Container(
//            height: 400.0,
                  color: Colors.grey,
                  child: _controller.value.initialized
                      ? Chewie(
                          controller: ChewieController(
                            videoPlayerController: _controller,
                            aspectRatio: _controller.value.aspectRatio,
                            autoPlay: false,
                            looping: false,
                          ),
                        )
                      : SizedBox(),
                ),
                MainTitleLabel(
                  '2020年全体员工消防教育',
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(top: 30 * ScaleWidth, left: 25 * ScaleWidth),
                ),
                Container(
                  margin: EdgeInsets.only(top: 23 * ScaleWidth, left: 25 * ScaleWidth),
                  child: Row(
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
    _controller.dispose();
    super.dispose();
  }
}
