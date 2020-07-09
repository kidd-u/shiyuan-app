import 'dart:io';
import 'package:shiyuan/common/WorkUI/work.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shiyuan/states/default.dart';
import 'package:flutter_html/flutter_html.dart';

class NoticePage extends StatefulWidget {
  NoticePage({
    Key key,
    @required this.arguments,
  }) : super(key: key);
  Map arguments;

  @override
  State<StatefulWidget> createState() {
    return new NoticeState();
  }
}

class NoticeState extends State<NoticePage> {
  Map _detail = {};

  void initState() {
    super.initState();
    getDetail();
  }

  getDetail() async {
    var res = await HttpUtil.get('/rolling/notice/${widget.arguments['id']}');
    setState(() {
      _detail = res;
    });
  }

  openFile() async {
    String url = _detail['attachment']['src'];
    if (Platform.isIOS) {
      PageUtil.push('WebView', arguments: url);
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: BackgroundColor,
      appBar: buildAppBar(context, '通告详情'),
      body: new ListView(
        physics: new AlwaysScrollableScrollPhysics(parent: new BouncingScrollPhysics()),
        children: <Widget>[
          MainTitleLabel(
            _detail.safe(['title']) ?? '',
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
            margin: EdgeInsets.only(top: 22 * ScaleWidth),
          ),
          SubTextLabel('${Filter.time(_detail.safe(['createdAt']))}', textAlign: TextAlign.center, margin: EdgeInsets.only(top: 20 * ScaleWidth)),
          ..._detail.containsKey('attachment')
              ? [
                  WorkFile(
//                    color: Colors.transparent,
                    margin: EdgeInsets.only(top: 25 * ScaleWidth),
//                    showTopLine: false,
//                    showBottomLine: false,
                    title: _detail.safe(['attachment', 'description']) ?? '',
                    name: _detail.safe(['attachment', 'name']) ?? '',
                    type: (_detail.safe(['attachment', 'type']) ?? '' as String).toLowerCase(),
                    onClick: () {
                      openFile();
                    },
                  ),
                ]
              : [],
          Html(data: _detail.safe(['content']) ?? ''),
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
