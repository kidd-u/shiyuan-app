import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
class VideoJiaoYuPage extends StatefulWidget {
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
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
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
    );
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '文档教育', actions: [btn]),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          Container(
//            height: 400.0,
            color: Colors.grey,
            child:_controller.value.initialized? Chewie(
              controller: ChewieController(
                videoPlayerController: _controller,
                aspectRatio: _controller.value.aspectRatio,
                autoPlay: false,
                looping: false,
              ),
            ):SizedBox(),
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
