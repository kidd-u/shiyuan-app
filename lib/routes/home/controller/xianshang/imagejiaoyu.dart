import 'package:flutter/material.dart';
import 'package:shiyuan/states/LogUtil.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

class ImageJiaoYuPage extends StatefulWidget {
  ImageJiaoYuPage({
    Key key,
    this.arguments, //任务id
  }) : super();
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new ImageJiaoYuState();
  }
}

class ImageJiaoYuState extends State<ImageJiaoYuPage> {
  List _attachments = [];
  Map _content={};
  int _index = 0;
  String _taskId = '';
  int _seconds = 60;
  int _readTimes = 0;
  Timer _timer;
  String _vftext = '';
  bool _clickable = false;
  String _title = '';

  SwiperController swiperController = new SwiperController();

  void initState() {
    super.initState();
    _attachments = widget.arguments['attachments'];
    _content = widget.arguments['content'];
    _taskId = _content['id'];
    _title = widget.arguments['title'];
    _startTimer();
  }

  submit() async {
    if (!_clickable) return;
    await DialogUtil.dialogConfim('确定完成培训?');
    var res = await HttpUtil.post('/process/online/material/' + _taskId, params: {'duration': _readTimes});
    _cancelTimer();
    if (res == true) {
      DialogUtil.showLoading();
      var res=await HttpUtil.get('/process/online/train/'+_content['id']);
      if (res['type'] == 'OC_CLASS') {
        String type=res['material']['type'];
        Map material=res['material'];
        material={...material,'content':_content,'page':widget.arguments['page']};
        print('数据*****');
        LogUtil.d(Filter.toJson(material));
        if (type == 'IMAGE') {
          PageUtil.push('imagejiaoyu',arguments: material);
        }else if (type == 'TEXT') {
          PageUtil.push('wendangjiaoyu',arguments: material);
        }  else{
          PageUtil.push('videojiaoyu',arguments: material);
        }
      } else {
        Map paper = res['paper'];
        DialogUtil.showLoading();
        var SINGLE = await HttpUtil.get('/process/online/test/' + paper['id'].toString(),
            params: {'type': 'SINGLE', 'page': 0, 'size': paper['totalQustions']});
        DialogUtil.showLoading();
        var MULTI = await HttpUtil.get('/process/online/test/' + paper['id'].toString(),
            params: {'type': 'MULTI', 'page': 0, 'size': paper['totalQustions']});
        DialogUtil.showLoading();
        var TOF = await HttpUtil.get('/process/online/test/' + paper['id'].toString(),
            params: {'type': 'TOF', 'page': 0, 'size': paper['totalQustions']});
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
        PageUtil.push('zaixiankaoshi', arguments: {'paper': paper, 'contents': contents, 'title': _title,'page': widget.arguments['page']});
      }
    }  else{
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
//        PageUtil.push('videojiaoyu');
        submit();
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
                      controller: swiperController,
                      itemBuilder: (BuildContext context, int index) {
                        return new ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Image.network(
                            _attachments[index]['src'],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      onIndexChanged: (index) {
                        _index = index;
                      },
                      itemCount: _attachments.length,
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                  MainTitleLabel(
                    (_index + 1).toString() + '/' + _attachments.length.toString(),
                    margin: EdgeInsets.only(top: 47 * ScaleWidth),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
//                  center(),
                  Container(
                    margin: EdgeInsets.only(top: 30 * ScaleWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ImageView(
                          src: 'imgs/home/xianshangpeixun/leftbutton.png',
                          width: 278 * ScaleWidth,
                          height: 132 * ScaleWidth,
                          onClick: () {
                            swiperController.previous();
                          },
                        ),
                        ImageView(
                          src: 'imgs/home/xianshangpeixun/rightbutton.png',
                          width: 278 * ScaleWidth,
                          height: 132 * ScaleWidth,
                          margin: EdgeInsets.only(left: 49 * ScaleWidth),
                          onClick: () {
                            swiperController.next();
                          },
                        )
                      ],
                    ),
                  )
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
        ));
  }

  Widget center() {
    return Container(
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
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
