import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
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
  int _seconds = 60;
  Timer _timer;
  String _vftext = '';
  bool _clickable = false;
  int _readTimes = 0;
  List _attachments = [];
  Map _content = {};
  String _taskId = '';
  String _title = '';

  void initState() {
    super.initState();
    _attachments = widget.arguments['attachments'];
    _content = widget.arguments['content'];
    _taskId = '${_content['id']}';
    _title = widget.arguments['title'];
    String url = _attachments[0]['src'];
    _startTimer();
    _controller = VideoPlayerController.network(Uri.encodeFull(url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  submit() async {
    if (!_clickable) return;
    await DialogUtil.dialogConfim('确定完成培训?');
    var res = await HttpUtil.post('/process/online/material/${_taskId}', params: {'duration': _readTimes});
    _cancelTimer();
    if (res == true) {
      DialogUtil.showLoading();
      var res = await HttpUtil.get('/process/online/train/${_content['id']}');
      if (res['type'] == 'OC_CLASS') {
        String type = res['material']['type'];
        Map material = res['material'];
        material = {...material, 'content': _content, 'page': widget.arguments['page']};
        print('数据*****');
        LogUtil.d(Filter.toJson(material));
        if (type == 'IMAGE') {
          PageUtil.push('imagejiaoyu', arguments: material);
        } else if (type == 'TEXT') {
          PageUtil.push('wendangjiaoyu', arguments: material);
        } else {
          PageUtil.push('videojiaoyu', arguments: material);
        }
      } else {
        Map paper = res['paper'];
        DialogUtil.showLoading();
        var SINGLE = await HttpUtil.get('/process/online/test/${paper['id']}',
            params: {'type': 'SINGLE', 'page': 0, 'size': paper['totalQustions']});
        DialogUtil.showLoading();
        var MULTI = await HttpUtil.get('/process/online/test/${paper['id']}',
            params: {'type': 'MULTI', 'page': 0, 'size': paper['totalQustions']});
        DialogUtil.showLoading();
        var TOF =
            await HttpUtil.get('/process/online/test/${paper['id']}', params: {'type': 'TOF', 'page': 0, 'size': paper['totalQustions']});
        List contents = [];
        if (SINGLE['content'].length > 0) {
          List content = SINGLE['content'];
          contents.add({
            'type': 'SINGLE',
            'content': content,
            'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'SINGLE'}).toList()
          });
        }
        if (MULTI['content'].length > 0) {
          List content = MULTI['content'];
          contents.add({
            'type': 'MULTI',
            'content': content,
            'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'MULTI'}).toList()
          });
        }
        if (TOF['content'].length > 0) {
          List content = TOF['content'];
          contents.add({
            'type': 'TOF',
            'content': content,
            'answers': content.map((e) => {'id': e['id'], 'reply': '', 'isCorrect': false, 'type': 'TOF'}).toList()
          });
        }
        _controller.pause();
        PageUtil.push('zaixiankaoshi', arguments: {'paper': paper, 'contents': contents, 'title': _title, 'page': widget.arguments['page']});
      }
    } else {
      PageUtil.popToName(widget.arguments['page']);
    }
  }

  _startTimer() {
    _seconds = 60;
    _clickable = false;
    _vftext = '$_seconds秒后可完成培训';
    if (mounted) setState(() {});
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
//      if (_seconds == 0) {
//        _cancelTimer();
//        return;
//      }
      _readTimes++;
      _seconds--;
      _vftext = '$_seconds秒后可完成培训';
      if (mounted) setState(() {});
      if (_seconds <= 0) {
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
      onPressed: () {
        submit();
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
                  _attachments.length > 0 ? _attachments[0]['description'] : '',
                  fontWeight: FontWeight.bold,
                  margin: EdgeInsets.only(top: 30 * ScaleWidth, left: 25 * ScaleWidth),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => submit(),
            child: Container(
              height: 99 * ScaleWidth,
              color: Color(0xFF112DB8),
              child: Center(
                child: MainTitleLabel(
                  _vftext,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
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
